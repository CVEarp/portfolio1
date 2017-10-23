#!/bin/bash

# A script to produce a system information HTML file

##### Constants

TITLE="System Information requested by $HOSTNAME"
RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updated on $RIGHT_NOW"
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
  ssys="$(lscpu)"	
  if [ "$is_plain" -eq 0 ]; then
    printf "$DIVIDER_FORMAT" "$DIVIDER"
    printf "$GENERAL_FORMAT" "System release info" "$ssys" ""
  else
    printf "$GENERAL_FORMAT" "<h2>System release info</h2>" "<pre>" "$ssys" "</pre>" ""
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
    printf "$GENERAL_FORMAT" "<footer><pre><h1 align = "center">" "$FOOTER" "</h1></pre></footer>"
  fi
}

setuid_binaries()
{	
	aux="$(find / -perm -4000 -ls 2>/dev/null)"
	if [ "$is_plain" -eq 0 ]; then
	     printf "$DIVIDER_FORMAT" "$DIVIDER"
	     printf "$GENERAL_FORMAT" "List of setuid binaries:" "$aux" ""
	   else
	     printf "$GENERAL_FORMAT" "<h2>List of setuid binaries</h2><pre>" "$aux" "</pre>"
	fi   
	
}  # end of setuid_binaries

restricted_dirs()
{
	aux="$(find / -perm -1755 -ls 2>/dev/null)"
	if [ "$is_plain" -eq 0 ]; then
            printf "$DIVIDER_FORMAT" "$DIVIDER"
	    printf "$GENERAL_FORMAT" "Directories with restricted deletion flags" "$aux" ""
	  else
	    printf "$GENERAL_FORMAT" "<h2>Directories with restricted deletion flags</h2><pre>" "$aux" "</pre>"   
	fi
}  # end of restricted_dirs

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
  $(setuid_binaries)
  $(restricted_dirs)
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
        <h1 align = "center">$TITLE</h1>
        <p align = "center">$TIME_STAMP</p>
	<hr />
        $(system_info)
        $(users_connected)
        $(show_uptime)
        $(drive_space)
        $(ram_space)
	<hr />
	$(setuid_binaries)
	$(restricted_dirs)
	<hr />
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
  echo "		-p  	Output as plain text."
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
	$(2>error)
        ;;
	esac
done



write_page



