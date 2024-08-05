#!/bin/bash

# Read user inputs
read -p "What IP are you scanning? (EX: 192.168.0.1): " ip
read -p "Protocol (tcp/udp): " protocol

touch $ip.txt

# watch results 
terminator -e "tail -f $ip.txt" -T "NC Results"

# Choose the correct nc flags based on the protocol
if [ "$protocol" == "tcp" ]; then
  flags="-zvn -w1"
elif [ "$protocol" == "udp" ]; then
  flags="-nv -u -z -w1"
fi

# Scan ports
echo "Scanning $ip for $protocol ports..."
for i in {1..65535}; do
  nc $flags $ip $i 2>&1 | grep -i "open" >> $ip.txt &
done

# Wait for all background processes to finish
wait

echo "Scan complete. Results saved to $ip.txt"
