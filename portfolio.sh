#!/bin/bash

# A script to produce a system information HTML file

##### Constants

TITLE="System Information requested by $HOSTNAME"
RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updated on $RIGHT_NOW by $USER"
FOOTER="@bart @carlos | SDU Robotics | Linux for Embedded Systems"
is_plain=1
GENERAL_FORMAT="\n%40s\n\n%35s\n%s\n"
DIVIDER=============================
DIVIDER=$DIVIDER$DIVIDER
DIVIDER_WIDTH=60
DIVIDER_FORMAT="\n%$DIVIDER_WIDTH.${DIVIDER_WIDTH}s\n"
##### Functions

system_info()
{
  if [ "$is_plain" -eq 0 ]; then
    printf "$DIVIDER_FORMAT" "$DIVIDER"
    printf "$GENERAL_FORMAT" "System release info" "Function not yet implemented" ""
  else
    printf "$GENERAL_FORMAT" "<h2>System release info</h2>" "<p>Function not yet implemented</p>" ""
  fi
}   # end of system_info

users_connected()
{
  aux="$(who -q | head -n -1)"
  if [ "$is_plain" -eq 0 ]; then
    printf "$DIVIDER_FORMAT" "$DIVIDER"
    printf "$GENERAL_FORMAT" "List of logged in users" "$aux" ""
  else
    printf "$GENERAL_FORMAT" "<h2>List of logged in users</h2><pre>" "$aux" "</pre>"
  fi
}
show_uptime()
{
  aux="$(uptime -p)"
  if [ "$is_plain" -eq 0 ]; then
    printf "$DIVIDER_FORMAT" "$DIVIDER"
    printf "$GENERAL_FORMAT" "System Uptime" "$aux" ""
  else
    printf "$GENERAL_FORMAT" "<h2>System uptime</h2><pre>" "$aux" "</pre>"
  fi
}   # end of show_uptime


drive_space()
{
  aux="$(df -h)"
  if [ "$is_plain" -eq 0 ]; then
    printf "$DIVIDER_FORMAT" "$DIVIDER"
    printf "$GENERAL_FORMAT" "Filesystem space" "$aux" ""
  else
    printf "$GENERAL_FORMAT" "<h2>Filesystem space</h2><pre>" "$aux" "</pre>"
  fi
}   # end of drive_space

ram_space()
{
  aux="$(free -m)"
  if [ "$is_plain" -eq 0 ]; then
    printf "$DIVIDER_FORMAT" "$DIVIDER"
    printf "$GENERAL_FORMAT" "RAM consumption" "$aux" ""
  else
    printf "$GENERAL_FORMAT" "<h2>RAM consumption</h2><pre>" "$aux" "</pre>"
  fi
}   # end of ram_space

footer()
{
  if [ "$is_plain" -eq 0 ]; then
    printf "$DIVIDER_FORMAT" "$DIVIDER"
    printf "$GENERAL_FORMAT" "ABOUT" "$FOOTER" ""
  else
    printf "$GENERAL_FORMAT" "<footer><pre>" "$FOOTER" "</pre></footer>"
  fi
}

home_space()
{
  # Only the superuser can get this information
  aux="$(du -s /home/* | sort -nr)"
  if [ "$(id -u)" = "0" ]; then
    if [ "$is_plain" -eq 0 ]; then
      printf "$DIVIDER_FORMAT" "$DIVIDER"
      printf "$GENERAL_FORMAT" "Home directory space by user" "$aux" ""
    else
      printf "$GENERAL_FORMAT" "<h2>Home directory space by user</h2><pre>Bytes Directory" "$aux" "</pre>"
    fi   
  fi
}   # end of home_space

write_page()
{

  if [ "$is_plain" -eq 0 ]; then
  cat <<- _EOF2_
  $TITLE
  $TIME_STAMP
  $(system_info)
  $(users_connected)
  $(show_uptime)
  $(drive_space)
  $(ram_space)
  $(home_space)
  $(footer)

_EOF2_
  else
    cat <<- _EOF_
    <!DOCTYPE html>
    <html>
        <head>
        <title>$TITLE</title>
        </head>
        <body>
        <h1>$TITLE</h1>
        <p>$TIME_STAMP</p>
        $(system_info)
        $(users_connected)
        $(show_uptime)
        $(drive_space)
        $(ram_space)
        $(home_space)
        $(footer)
        </body>
      </html>
 
_EOF_
  fi
}

usage()
{
  echo "Usage: portfolio.sh [OPTION]..." #export PATH=$PATH:$(pwd)
  echo "Generates an output containing system information such as date, users and more." 
  echo "If no option is given, output is generated in HTML format."
  echo
  echo "Mandatory arguments to long options are mandatory for short options too."
  echo "		-h 	Help. (This)"
  echo "		-a  	Output as plain text."
  echo "		-c	Displays information by colors."
  echo 
}

while getopts ":hp" opt; do
	case $opt in
      h)
        usage
        exit 0
        ;;
      p)
        is_plain=0
        ;;
	esac
done



write_page
