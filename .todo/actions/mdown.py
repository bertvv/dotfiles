#!/usr/bin/env python
# encoding: utf-8
"""
markdowngen.py

Created by Emil Erlandsson on 2011-02-10.
Copyright (c) 2011 Emil Erlandsson. All rights reserved.
"""

import sys
import os

def e(str):
	"""emphasis"""
	return "_%s_"

def se(str):
	"""strong emphasis"""
	return self.emphasis(self.emphasis(str))
	
def c(str):
	"""code"""
	return "`%s`" % str
	
def h1(str):
	return "%s\n%s\n" % (str, "=" * len(str))
	
def h2(str):
	return "%s\n%s\n" % (str, "-" * len(str))

def h3(str):
	return "### %s ###" % str

def h3(str):
	return "### %s ###" % str

def h4(str):
	return "#### %s ####" % str

def h5(str):
	return "##### %s #####" % str
	
def h6(str):
	return "###### %s ######" % str

def bq(str):
	lines = str.split("\n")
	output = ""
	for line in lines:
		output = output + "> %s\n" % line
	return output

def a(text, url, title = ""):
	return '[%s](%s "%s")' % (text, url, title)

def li(items):
	output = ""
	for item in items:
		output = output + "* %s\n" % item
	return output		

class MarkdownDocument(object):
	"""docstring for MarkdownDocument"""
	def __init__(self):
		super(MarkdownDocument, self).__init__()
		self.document = []
		
	def __str__(self):
		"""docstring for __str__"""
		return "..."	

def main():
	print h1("Emil Erlandsson")
	print li(["apa", "bepa", "cepa"])
	print a("text", "http://localhost")
	print h2("a second level heading")


if __name__ == '__main__':
  main()

