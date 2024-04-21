#! /usr/bin/env bash
#
# Created:  Tue 18 Feb 2014 12:24:22 pm CET
# Modified: Tue 25 Mar 2014 10:33:48 am CET CET CET CET CET CET CET CET
# Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Cleanup download folder: delete files not accessed for a specified number
# of days/

set -e # abort on nonzero exitstatus
set -u # abort on unbound variable

#--------------------------------------------------------------------------
# Variables
#--------------------------------------------------------------------------

download_folder=~/Downloads

# Notation: +n  => "At least n days"
age="+21"
log="${download_folder}/cleanup-downloads.log"

#--------------------------------------------------------------------------
# Script proper
#--------------------------------------------------------------------------
echo "$(date -Iseconds) : Start cleanup" >> "${log}"
find "${download_folder}" -atime ${age} -exec rm -fv {} \; \
  >> "${log}"
echo "Deleting empty directories" >> "${log}"
find "${download_folder}" -type d -empty -print -delete \
  >> "${log}"


