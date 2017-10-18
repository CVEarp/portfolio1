#!/bin/bash

# A script to produce a system information HTML file

##### Constants

TITLE="System Information for $HOSTNAME"
RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updated on $RIGHT_NOW by $USER"

##### Functions

system_info()
{
    echo "<h2>System release info</h2>"
    echo "<p>Function not yet implemented</p>"

}   # end of system_info


show_uptime()
{
    echo "<h2>System uptime</h2>"
    echo "<pre>"
    uptime
    echo "</pre>"

}   # end of show_uptime


drive_space()
{
    echo "<h2>Filesystem space</h2>"
    echo "<pre>"
    df
    echo "</pre>"

}   # end of drive_space


home_space()
{
    # Only the superuser can get this information

    if [ "$(id -u)" = "0" ]; then
        echo "<h2>Home directory space by user</h2>"
        echo "<pre>"
        echo "Bytes Directory"
        du -s /home/* | sort -nr
        echo "</pre>"
    fi

}   # end of home_space

write_page()
{
    cat <<- _EOF_
    <html>
        <head>
        <title>$TITLE</title>
        </head>
        <body>
        <h1>$TITLE</h1>
        <p>$TIME_STAMP</p>
        $(system_info)
        $(show_uptime)
        $(drive_space)
        $(home_space)
        </body>
    </html>
_EOF_

}

usage()
{
  echo "Usage: portfolio.sh [OPTION]..."
  echo "Generates an output containing system information such as date, users and more." 
  echo "If no option is given, output is generated in HTML format."
  echo
  echo "Mandatory arguments to long options are mandatory for short options too."
  echo "		-h 	Help. (This)"
  echo "		-a  	Output as plain text."
  echo "		-c	Displays information by colors."
  echo 
}


DSU="Disk Space Utilization"
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
			usage
			exit 0
			;;
		a)
			echo $TITLE | od -An -vtu1
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
		<TITLE>$TITLE</TITLE>
	</HEAD>
	<BODY text = "orange" bgcolor = "black">
		<H1 align = "center">$title</H1>
		<hr />
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
