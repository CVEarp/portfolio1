#!/bin/bash

# Program to output a system information page


WHITE="\033[37m"
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PINK="\033[35m"
GREEN="\033[32m"
BROWN="\033[1;31m"
NC='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)

title="Basic system information:"
dsu="Disk Space Utilization"
mu="Memory Usage"
hsu="Home Space Utilization"
bottom="@bart @carlos | SDU Robotics | Linux for Embedded Systems"
CURRENT_TIME=$(date)
TIMESTAMP=$(uptime)
opt="?"
place="Odense | Funen | Denmark"

while getopts ":hac" opt; do
	case $opt in
	       	h)
			echo
			echo "Program $bold ./portfolio.sh: $normal display of useful basic system information." 
			echo "By default, shows information in HTML."
			echo "$bold USING OTHER OPTIONS: $normal"
			echo "		-h 	help."
			echo "		-a  	Displays tinformation in ASCII."
			echo "		-c	Displays information by colors."
			exit 0
			;;
		a)
			echo "Working on it."
			exit 0
			;;
		c)
			echo -e "$CYAN $bold Basic system information: $normal $NC"
			echo '----------------------------------------'
			echo 'Date:'
			printf $PINK
			date
			printf $NC
			echo '----------------------------------------'
			echo 'Uptime and load average:'
			printf $BLUE
			uptime  
			printf $NC
			echo '----------------------------------------'
			echo 'Logged-in users:'
			printf $GREEN
			who
			printf $NC
			echo '----------------------------------------'
			echo 'RAM memory usage:'
			printf $RED
			df -h
			printf $NC
			echo '----------------------------------------'
			echo 'Amount of free disk space:'
			printf $BROWN
			free -m
			printf $NC
			echo '----------------------------------------'
			echo 'Month calendar:'
			printf $WHITE
			cal 
			printf $NC
			echo '----------------------------------------'
			echo -e "$CYAN $bold @charlieviescas | SDU Robotics | Linux for Embedded Systems $normal $NC"
			echo
			exit 0
			;;
	esac
done





if [ "$opt" = "?" ]; then
echo "
<HTML>
	<HEAD>
		<TITLE>$title</TITLE>
	</HEAD>
	<BODY>
		<H1>$title</H1>
		<P>$CURRENT_TIME<P>
		<P>$TIMESTAMP</P>
		<P>$place</P>
		<H2>$dsu</H2>
		<PRE>$(df -h)</PRE>
		<H2>$mu</H2>
		<PRE>$(free -m)</PRE>
		<H2>$hsu</H2>
		<PRE>$(du -sh /home/*)</PRE>
		<H3>$bottom</H3>
	</BODY>
</HTML>"
fi
