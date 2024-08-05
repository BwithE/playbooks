#!/bin/bash

# Read user inputs
read -p "What IP are you scanning? (EX: 192.168.0.1): " ip
read -p "Port range (e.g., 1-1000): " portrange
read -p "Protocol (tcp/udp): " protocol

# Choose the correct nc flags based on the protocol
if [ "$protocol" == "tcp" ]; then
  flags="-zvn -w1"
elif [ "$protocol" == "udp" ]; then
  flags="-nv -u -z -w1"
else
  echo "Invalid protocol. Please enter 'tcp' or 'udp'."
  exit 1
fi

# Extract start and end ports from the range
IFS='-' read -r start_port end_port <<< "$portrange"

# Validate port range
if ! [[ "$start_port" =~ ^[0-9]+$ ]] || ! [[ "$end_port" =~ ^[0-9]+$ ]] || [ "$start_port" -gt "$end_port" ]; then
  echo "Invalid port range. Please enter a valid range like 1-1000."
  exit 1
fi

# Print out the loop command syntax
if [ "$start_port" -eq "$end_port" ]; then
  # Single port
  echo "To scan port $start_port on $ip with $protocol protocol, use:"
  echo "nc $flags $ip $start_port"
else
  # Port range
  echo "To scan ports from $start_port to $end_port on $ip with $protocol protocol, use:"
  echo "for i in {$start_port..$end_port}; do (nc $flags $ip \$i 2>&1 | grep open >> $ip.txt &) done"
fi
