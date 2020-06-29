#!/bin/bash

#This will block all incoming\outgoing connection 

if [ "$1" = '-h' ];then
    #Help and usage
    echo "This will block all incoming\outgoing connection "
    echo "allow connnection for ip address given as args"
    echo "Uasge:wall.sh"
    echo "      wall.sh [ip]"
    echo "      wall.sh [ip] [ip]"
else
    #flush iptables and blocking and all connections
    sudo iptables -F
    sudo iptables -A INPUT -j DROP
    sudo iptables -A OUTPUT -j DROP

    echo "Blocked all connections!"

    #Allowing cretain ip address given as command line arguments

    for ip in "$@";do
        sudo iptables -I INPUT -s "$ip" -j ACCEPT
        sudo iptables -I OUTPUT -d "$ip" -j ACCEPT
        echo "New rules added to $ip"
    done
    echo ""
    echo "Updated firewall"
    sudo iptables -L
fi