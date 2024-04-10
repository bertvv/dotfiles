#!/usr/bin/env bash
#
# Created:  Sun 30 Jun 2013 10:54:14 PM CEST
# Modified: Sun 30 Jun 2013 10:57:59 PM CEST
# Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Initialises a few reusable variables for setting colour in the terminal

#--------------------------------------------------------------------------
# Variables
#--------------------------------------------------------------------------

# Reset
export Reset='\e[0m'       # Text Reset
export Default=${Reset}

# Regular Colors
export Black='\e[0;30m'        # Black
export Red='\e[0;31m'          # Red
export Green='\e[0;32m'        # Green
export Yellow='\e[0;33m'       # Yellow
export Blue='\e[0;34m'         # Blue
export Purple='\e[0;35m'       # Purple
export Cyan='\e[0;36m'         # Cyan
export White='\e[0;37m'        # White

# Bold
export BBlack='\e[1;30m'       # Black
export BRed='\e[1;31m'         # Red
export BGreen='\e[1;32m'       # Green
export BYellow='\e[1;33m'      # Yellow
export BBlue='\e[1;34m'        # Blue
export BPurple='\e[1;35m'      # Purple
export BCyan='\e[1;36m'        # Cyan
export BWhite='\e[1;37m'       # White

# Underline
export UBlack='\e[4;30m'       # Black
export URed='\e[4;31m'         # Red
export UGreen='\e[4;32m'       # Green
export UYellow='\e[4;33m'      # Yellow
export UBlue='\e[4;34m'        # Blue
export UPurple='\e[4;35m'      # Purple
export UCyan='\e[4;36m'        # Cyan
export UWhite='\e[4;37m'       # White

# Background
export On_Black='\e[40m'       # Black
export On_Red='\e[41m'         # Red
export On_Green='\e[42m'       # Green
export On_Yellow='\e[43m'      # Yellow
export On_Blue='\e[44m'        # Blue
export On_Purple='\e[45m'      # Purple
export On_Cyan='\e[46m'        # Cyan
export On_White='\e[47m'       # White

# High Intensity
export IBlack='\e[0;90m'       # Black
export IRed='\e[0;91m'         # Red
export IGreen='\e[0;92m'       # Green
export IYellow='\e[0;93m'      # Yellow
export IBlue='\e[0;94m'        # Blue
export IPurple='\e[0;95m'      # Purple
export ICyan='\e[0;96m'        # Cyan
export IWhite='\e[0;97m'       # White

# Bold High Intensity
export BIBlack='\e[1;90m'      # Black
export BIRed='\e[1;91m'        # Red
export BIGreen='\e[1;92m'      # Green
export BIYellow='\e[1;93m'     # Yellow
export BIBlue='\e[1;94m'       # Blue
export BIPurple='\e[1;95m'     # Purple
export BICyan='\e[1;96m'       # Cyan
export BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
export On_IBlack='\e[0;100m'   # Black
export On_IRed='\e[0;101m'     # Red
export On_IGreen='\e[0;102m'   # Green
export On_IYellow='\e[0;103m'  # Yellow
export On_IBlue='\e[0;104m'    # Blue
export On_IPurple='\e[0;105m'  # Purple
export On_ICyan='\e[0;106m'    # Cyan
export On_IWhite='\e[0;107m'   # White

