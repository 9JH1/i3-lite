#!/bin/bash
if [ $(dunstctl is-paused) = "true" ];then
    echo -n "󱆷 ";
else
    echo -n "󱁣 ";
fi
