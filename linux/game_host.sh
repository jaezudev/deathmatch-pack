#!/bin/bash
read -p "How many players (w/ host)? " players
read -p "Specify port (leave empty for default): " port
if [[ "$port" == "" ]]; then
	./gzdoom -host $players -deathmatch
else
	./gzdoom -host $players -deathmatch -port $port
fi