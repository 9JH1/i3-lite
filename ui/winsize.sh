#!/bin/bash
xwininfo | grep "geometry" \
	| awk '{print $2}' \
	| tr '+' ' ' \
	| awk '{print $1}' \
	| tr 'x' ' '
