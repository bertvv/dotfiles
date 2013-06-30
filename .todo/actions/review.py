#!/usr/bin/env python
# encoding: utf-8
"""
review.py

Created by Emil Erlandsson on 2011-02-10.
Copyright (c) 2011 Emil Erlandsson. All rights reserved.

review.py
=========

This is a utility script for creating a review of the current files in the
todo.sh directory.

Example:
	python review.py [TODO_DIR]
"""

import sys
import os
import datetime

from todotxt import Todo
import mdown

UNTOUCHABLES = ["done.txt", "report.txt", "todo.txt.bak", "todo.txt", "Todo.tmp", "todo.tmp"]
TODOFILE = "todo.txt"
DONEFILE = "done.txt"
CUTOFFDAYS = 7

def print_file(todofile):
	projects = {}
	contexts = {}
	
	print ""
	print mdown.h1(os.path.basename(todofile).replace(".txt", "").capitalize())
	
	for line in open(todofile, "r").readlines():
		t = Todo(line)
		
		if not projects.has_key(t.project):
			projects[t.project] = []
		projects[t.project].append(t)
		
		if not contexts.has_key(t.context):
			contexts[t.context] = []
			
		contexts[t.context].append(t)
	
	print ""
	print mdown.h2("By project:")
	for prj in projects.keys():
		
		if prj == "":
			print mdown.h3("No project assigned")
		else:
			print mdown.h3("%s" % prj.replace("+", ""))
		print mdown.li(projects[prj])

	print ""
	print mdown.h2("By context:")
	for ctx in contexts.keys():
		if ctx == "":
			print mdown.h3("No context assigned")
		else:
			print mdown.h3("%s" % ctx)
		print mdown.li(contexts[ctx])


def main(directory):
	files = [os.path.join(directory, x) for x in (set(os.listdir(sys.argv[1])) - set(UNTOUCHABLES)) if os.path.isfile(os.path.join(directory, x))]

	# Always start with todo.txt
	print_file(os.path.join(directory, TODOFILE))
	
	# Print the rest of the files
	for f in files:
		print_file(f)
		
	# Get some stats for the last week
	done = [Todo(x) for x in open(os.path.join(directory, DONEFILE), "r").readlines()]
	overall = len(done)
	
	
	
	today = datetime.datetime.today()
	cutoff =  today - datetime.timedelta(days=CUTOFFDAYS)
	done = [x for x in done if x.completed >= cutoff]
	
	
	print mdown.h1("Statistics")
	print "* %d tasks completed since %s (last week)" % (len(done), str(cutoff))
	print "* Averaging %0.1f tasks per day" % (float(len(done) / CUTOFFDAYS ) )
	print "* %d tasks completed since the beginning of time" % overall 

if __name__ == '__main__':
	if len(sys.argv) is not 2:
		print "Usage: review.py [TODO_DIR]"
		sys.exit(1)
	
	if os.path.isdir(sys.argv[1]):
		main(sys.argv[1])
	else:
		print "Error: %s is not a directory" % sys.argv[1]
		sys.exit(1)

