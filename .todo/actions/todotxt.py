#!/usr/bin/env python
# encoding: utf-8
"""
todotxt.py

Created by Emil Erlandsson on 2011-02-09.
Copyright (c) 2011 Emil Erlandsson. All rights reserved.
"""
TESTDATA="""(B) +GarageSale @phone schedule Goodwill pickup
+GarageSale @home post signs around the neighborhood
2011-03-12 (A) @phone thank Mom for the meatballs
@shopping Eskimo pies +freaksale"""

import sys
import os
import re
import datetime

class Todo(object):
	def __init__(self, string = ""):
		self.project = ""
		self.context = ""
		self.date = ""
		self.task = ""
		self.priority = ""
		self.done = False
		self.completed = None
		if string is not "":
			self.parse(string)
	
	def parse(self, string):
		
		# special handling for the done.txt
		if string.startswith("x"):
			self.done = True
			m = re.match("^x ([\d]{4}-[\d]{2}-[\d]{2})", string)
			if m is not None:
				year, month, day = m.group(1).split("-")
				self.completed = datetime.datetime(int(year),int(month),int(day))
				string.replace(m.group(1), "")
				# Remove the 'x' and strip
				string = string[1:].strip()
		
		# extract priority (A-Z)
		m = re.match(".*(\([A-Z]\)).*", string)
		if m is not None:
			self.priority = m.group(1)
		
		# extract project\@[\w]*
		m = re.match(".*(\+[\w]*).*", string)
		if m is not None:
			self.project = m.group(1)
		
		# extract context
		m = re.match(".*(\@[\w]*).*", string)
		if m is not None:
			self.context = m.group(1)
		
		# extract date
		m = re.match(".*([\d]{4}-[\d]{2}-[\d]{2}).*", string)
		if m is not None:
			self.date = m.group(1)
			
		# Assume the rest is the task
		self.task = string.replace(self.priority, "").replace(self.project, "").replace(self.context, "").replace(self.date, "").strip()
			
	def __str__(self):
		return ("%s %s %s %s %s" %  (self.priority, self.date, self.task, self.project, self.context)).strip().replace("  ", " ")
		
if __name__ == '__main__':
	pass
