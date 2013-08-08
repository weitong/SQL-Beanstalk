#!/usr/bin/env python
#
#	File: exceptions.py
#
#	IDENTIFICATION
#		apps/mplib/exceptions.py



class ErrorRuleException(Exception):
	def __init__(self, arg):
		self.args = arg
		print 'Error Rule'

class NotImplException(Exception):
	def __init__(self, arg):
		self.args = arg
		print 'Not impl'

class FailToOpenFile(Exception):
	def __init__(self, arg):
		self.args = arg
		print 'FailToOpenFile'