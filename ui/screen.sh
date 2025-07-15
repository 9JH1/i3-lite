#!/bin/bash
xrandr --current | grep "*" | awk '{print $1}' | tr 'x' ' '
