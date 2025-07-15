#!/bin/bash

# --- SETTINGS ---

MAX_RETRYS=10
RETRY_INTERVAL=0
INTERFACE=$(ip addr show | awk '/inet.*brd/{print $NF}')
INTERFACE="wlan0"
HOSTNAME=$(cat /etc/hostname)
PUBLIC_IP=$(ip addr show | grep "brd"  | grep "inet " | awk '{print $4}')
HOSTNAME_SIZE=10
HOSTNAME_MESSAGE="3meMFKR"

# --- END OF SETTINGS ---

#print host information
#for addr in $(ifconfig | grep ether | awk '{print $2}');do
#	printf "    "
#	echo $addr
#done;
#echo -e " - Network Device(s): (using \"\033[95m$INTERFACE\033[0m\")"
#for device in $(ip addr show | grep "state" | awk '{print $2}');do
#	echo "   ${device::-1}"
#done;

echo -e "Starting System Update.."
change_mac_address(){
	HEX_VALUES=$(xxd -l 6 -p /dev/urandom | tr -d '\n')
	MAC_ADDRESS=$(echo $HEX_VALUES | sed 's/\(..\)/\1:/g; s/.$//')

	# take interface down
	ip link set dev $INTERFACE down || {
		return 1
	}

	# set mac 
	ip link set dev $INTERFACE address $MAC_ADDRESS || {
		return 1
	}

	# interface back up
	ip link set dev $INTERFACE up || {
		return 1
	}

	return 0
}

# run spoof loop
attempt=1
while true;do
	change_mac_address >/dev/null
	if [ $? -eq 0 ];then
		echo "Part 1 Complete"
		break 
	fi;

	if [ $attempt -eq $MAX_RETRYS ];then
		echo "Error: surpassed max_retrys"
		exit 1
	fi
	attempt=$((attempt + 1))
	sleep $RETRY_INTERVAL
done;

gen_rand_char() {
	all_chars="1234567890QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm"
	index=$(($RANDOM % ${#all_chars}))
	rand_char=${all_chars:$index:1}
}

# hostname spoof
random_list=""
for((i=0; i<$HOSTNAME_SIZE; i++));do
	a=$(gen_rand_char)
	printf "$a"
	random_list="$random_list$a"
done

# process string and sanitize into a hostname
random_list="$HOSTNAME_MESSAGE$random_list"
sha256_hostname=$(echo "$random_list" | sha256sum)
sha256_hostname=${sha256_hostname::-2}
sha256_hostname=${sha256_hostname:0:${#sha256_hostname}/2}
echo $sha256_hostname > /etc/hostname
echo "Part 2 Complete"
echo -e "Rebooting..."
sleep 1
reboot
