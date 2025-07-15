#!/bin/bash
echo -e "Mac: "
ip link | grep "link/ether" | tail -n 1 | awk '{print $2}'
