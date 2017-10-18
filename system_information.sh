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
usr="Logged-in users:"
dsu="Disk Space Utilization"
mu="Memory Usage"
hsu="Home Space Utilization"
cale="Month calendar"
bottom="@bart @carlos | SDU Robotics | Linux for Embedded Systems"
CURRENT_TIME=$(date)
TIMESTAMP=$(uptime)
opt="?"
place="Odense | Funen | Denmark"

while getopts ":ha" opt; do
	case $opt in
	       	h)
			echo
			echo "Program $bold ./portfolio.sh: $normal display of useful basic system information." 
			echo "By default, it displays system information in HTML."
			echo "$bold USING OTHER OPTIONS: $normal"
			echo "		-h 	help."
			echo "		-a  	Displays tinformation in ASCII."
			exit 0
			;;
		a)
			echo $title | od -An -vtu1
			echo "dare" | od -An -vtu1
			date | od -An -vtu1
			echo "Uptime and load average:" | od -An -vtu1
			uptime | od -An -vtu1
			echo "Logged-in users:" | od -An -vtu1
			who | od -An -vtu1
			echo "RAM memory usage:" | od -An -vtu1
			df -h | od -An -vtu1
			echo "Amount of free disk space" | od -An -vtu1
			free -m | od -An -vtu1
			echo "Month calendar" | od -An -vtu1
			cal | od -An -vtu1
			echo $bottom | od -An -vtu1
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
	<BODY text = "orange" bgcolor = "black">
		<H1 align = "center">$title</H1>
		<hr />
		<P>$usr</P>
		<P>$(who)</P>
		<P>$CURRENT_TIME<P>
		<P>$TIMESTAMP</P>
		<P>$place</P>
		<H2>$dsu</H2>
		<PRE>$(df -h)</PRE>
		<H2>$mu</H2>
		<PRE>$(free -m)</PRE>
		<H2>$hsu</H2>
		<PRE>$(du -sh /home/*)</PRE>
		<H2>$cale</H2>
		<PRE>$(cal)</PRE>
		<hr />
		<H3 align = "center">$bottom</H3>
	</BODY>
</HTML>"
fi



