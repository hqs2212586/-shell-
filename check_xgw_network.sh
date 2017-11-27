#!/bin/bash

#
# Check xgw network status, such as bps, pps or util
#

INTERVAL=5
TENG_BPS=$((10*1024*1024*1024*64/(84*8)))

# Print alarm json messages
function print_json()
{
    cat <<EOF
{
    "collection_flag":0,
    "MSG": [$1]
}
EOF
}

function get_port_status()
{
    local output=$(sudo /usr/local/sbin/base_admin --port-status "$1")

    # rx dropped
    local rx_dropped=$(echo "$output" | awk '/Packets dropped of recieved/{print $NF}')
    # tx dropped
    local tx_dropped=$(echo "$output" | awk '/Packets dropped of transived/{print $NF}')
    # packet recieved
    local rx_packets=$(echo "$output" | awk '/Packets recieved/{print $NF}')
    # packets transived
    local tx_packets=$(echo "$output" | awk '/Packets transived/{print $NF}')
    # bytes recieved
    local rx_bytes=$(echo "$output" | awk '/Bytes recieved/{print $NF}')
    # bytes transived
    local tx_bytes=$(echo "$output" | awk '/Bytes transived/{print $NF}')

    echo 6:$rx_dropped:$tx_dropped:$rx_packets:$tx_packets:$rx_bytes:$tx_bytes
}

function check_network_status()
{
    local port_num=$(sudo /sbin/lspci | grep -i '82599' | wc -l)
    local last_status=() curr_status=()

    # Get the port status first time
    local port

    for port in `seq 0 $((port_num-1))`; do
        last_status[port]="$(get_port_status $port)"
    done

    # Sleep interval seconds
    sleep $INTERVAL

    # Get the port status second time
    for port in `seq 0 $((port_num-1))`; do
        curr_status[port]="$(get_port_status $port)"
    done

    local last_values curr_values length delta_values
    local v i msg

    # Calculate the results
    for port in `seq 0 $((port_num-1))`; do
        last_values=($(echo "${last_status[port]}" | sed 's/:/ /g'))
        curr_values=($(echo "${curr_status[port]}" | sed 's/:/ /g'))

        length=${last_values[0]}
        delta_values=($port)

        for i in `seq 1 $length`; do
            v=$(echo "scale=2;(${curr_values[i]}-${last_values[i]})/$INTERVAL" | bc | awk '{printf "%f", $0}')
            delta_values[i]="$v"
        done

        # Add rx util and tx util using current values
        curr_values[length+1]=$(echo "scale=2;(${curr_values[5]}*100)/$TENG_BPS" | bc | awk '{printf "%f", $0}')
        curr_values[length+2]=$(echo "scale=2;(${curr_values[6]}*100)/$TENG_BPS" | bc | awk '{printf "%f", $0}')

        #declare -p last_values
        #declare -p curr_values
        #declare -p delta_values

        msg="{\"port\":${delta_values[0]},\"rx_dropped\":${curr_values[1]},\"tx_dropped\":${curr_values[2]},
                \"rx_packets\":${curr_values[3]},\"tx_packets\":${curr_values[4]},\"rx_bytes\":${curr_values[5]},
                \"tx_bytes\":${curr_values[6]},\"rx_util\":${curr_values[7]},\"tx_util\":${curr_values[8]},
                \"rx_dropped_rate\":${delta_values[1]},\"tx_dropped_rate\":${delta_values[2]},
                \"rx_pps\":${delta_values[3]},\"tx_pps\":${delta_values[4]},\"rx_bps\":${delta_values[5]},
                \"tx_bps\":${delta_values[6]}},$msg"
    done

    echo "${msg%,}" | tr -d '\n '
}

function main()
{
    local msg=$(check_network_status)
    print_json "$msg"
}

main