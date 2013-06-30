#!/usr/bin/env python
# encoding: utf-8
"""
lately.py

Created by Emil Erlandsson on 2011-02-15.
Copyright (c) 2011 Emil Erlandsson. All rights reserved.
"""

import datetime
import sys
import os
import re

DONE = "done.txt"

# Bash coloring from:
# https://github.com/emilerl/emilerl/blob/master/pybash/bash/__init__.py

RESET = '\033[0m'
CCODES = {
    'black'           :'\033[0;30m',
    'blue'            :'\033[0;34m',
    'green'           :'\033[0;32m',
    'cyan'            :'\033[0;36m',
    'red'             :'\033[0;31m',
    'purple'          :'\033[0;35m',
    'brown'           :'\033[0;33m',
    'light_gray'      :'\033[0;37m',
    'dark_gray'       :'\033[0;30m',
    'light_blue'      :'\033[0;34m',
    'light_green'     :'\033[0;32m',
    'light_cyan'      :'\033[0;36m',
    'light_red'       :'\033[0;31m',
    'light_purple'    :'\033[0;35m',
    'yellow'          :'\033[0;33m',
    'white'           :'\033[0;37m',
}

class Colors(object):
    """A helper class to colorize strings"""
    def __init__(self, state = False):
        self.disabled = state
    
    def disable(self):
        self.disabled = True
        
    def enable(self):
        self.disabled = False
            
    def __getattr__(self,key):
        if key not in CCODES.keys():
            raise AttributeError, "Colors object has no attribute '%s'" % key
        else:
            if self.disabled:
                return lambda x: x
            else:
                return lambda x: RESET + CCODES[key] + x + RESET
    
    def __dir__(self):
        return self.__class__.__dict__.keys() + CCODES.keys()

def main(directory, cutoff_days = 7):
    f = open(os.path.join(directory, DONE), 'r')
    lines = f.readlines()
    today = datetime.datetime.today()
    cutoff =  today - datetime.timedelta(days=cutoff_days)
    c = Colors()
    print c.red("\nClosed tasks since %s\n" % cutoff.strftime("%Y-%m-%d")) 
    
    for line in lines:
        m = re.match("x ([\d]{4}-[\d]{2}-[\d]{2}).*", line)
        if m is not None:
            done = m.group(1)
            year, month, day = m.group(1).split("-")
            completed = datetime.datetime(int(year),int(month),int(day))
            if completed >= cutoff:
                print c.green(m.group(1)) + " " + c.blue(line.replace("x %s" % m.group(1), "").strip())
    
    print ""

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print "Usage: lately.py [TODO_DIR] <days back>"
        sys.exit(1)

    if os.path.isdir(sys.argv[1]):
        if len(sys.argv) is 3:
            main(sys.argv[1], int(sys.argv[2]))
        else:
            main(sys.argv[1])
    else:
        print "Error: %s is not a directory" % sys.argv[1]
        sys.exit(1)

