#!/usr/bin/env python
#
#
#	File: check_dependency.py
#		check the dependency of the bison rules
#	Author: Wei Tong
#
#
# IDENTIFICATION
#	tools/check_dependency.py
#
#################################################


ws = [' ', '\n', '\t']

import sys
import xml.etree.cElementTree as ET

file_num = len(sys.argv)-1
trees = {}
types = []
rules = {}

def format(parent):
        """ """
        for node in parent.getchildren():
                if node.tag == 'rule':
                        rule(node)
                else:
                        format(node)

def rule(node):
	children = node.getchildren()
	rule_antecedent = children[0].attrib['value']
	rule_consequents = cons_list(children[2])
	types.append(rule_antecedent)
	rules[rule_antecedent] = rule_consequents

def cons_list(node):
	consequents = []
	children = node.getchildren()
	if len(children) == 1:
		return [cons(children[0])]
	elif len(children) == 3:
		return [cons(children[0])] + cons_list(children[2])
	else:
		print "cons_list: error rule"

def cons(node):
	children = node.getchildren()
	if len(children) == 0:
		return []
	else:
		return node_list(children[0])

def node_list(node):
	children = node.getchildren()
	if len(children) == 1:
		return [node_handle(children[0])]
	else:
		return [node_handle(children[0])] + node_list(children[1])

def node_handle(node):
	return node.attrib['value']

def check_dependency():
	fobj_dep = open("./gram"+".gc", "w")
	num = 0
	undo_types = []
	#print len(types)
	for key in rules.keys():
		for cons  in rules[key]:
			for t in cons:
				if (t not in types) and (t not in undo_types):
					if t[0:3] != "SQL" and t[0] != '%':
						undo_types.append(t)
						num += 1
	ltmp = {}.fromkeys(undo_types).keys()
	for i in ltmp:
		fobj_dep.write(i + "\n")
	fobj_dep.close()
	print "-------> " + str(num)


for i in range(1, file_num + 1):
	trees[i] = ET.ElementTree(file=sys.argv[i])

for i in range(1, file_num+1):
	format(trees[i].getroot())

check_dependency()