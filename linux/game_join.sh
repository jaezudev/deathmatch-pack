#!/bin/bash
read -p "Enter IP address: " ip
read -p "Specify port (leave empty for default): " port
if [[ "$port" == "" ]]; then
	./gzdoom -join $ip
else
	./gzdoom -join $ip -port $port
fi