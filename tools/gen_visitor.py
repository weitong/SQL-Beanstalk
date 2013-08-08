#!/usr/bin/env python
#
#	File: gen_visitor.py
#	Author: Wei Tong
#	Generate the python code to visit a syntax tree
#
#	IDENTIFICATION
#		tools/gen_visitor.py
#
#
#	call the generate() function to do the job
#

import sys
import xml.etree.cElementTree as ET

file_num = len(sys.argv) - 1

ws = [' ', '\n', '\t']
types = []
allrules = {}
final_types = []
trees = {}

#	scanRule
#		traverse the syntax tree of bison rules, and store the rule in the dicts
#
#		if the rule is 
#		ANTE 
#			: CONS1_A CONS1_B CONS1_C
#			| CONS2_A CONS2_B
#			;
#		
#		in the dict, store as:
#			{
#				ANTE: [
#					[CONS1_A, CONS1_B, CONS1_C], 
#					[CONS2_A, CONS2_B]
#				]
#			}

def scanRule(parent):
        """ """
        for node in parent.getchildren():
                if node.tag == 'rule':
                        rule(node)
                else:
                        scanRule(node)
def rule(node):
	children = node.getchildren()
	rule_antecedent = children[0].attrib['value']
	rule_consequents = cons_list(children[2])
	# append the grammar node to the list
	types.append(rule_antecedent)
	# set the rule
	allrules[rule_antecedent] = rule_consequents

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

#
#	generate_code
#		generate the bison rule/action code to construct the AST
#
def generate_code(fileout, fitems = [], dreturn = '\'\''):
	fobj_yacc = open(fileout, "w")

	rules = {}
	nodes = set()
	if fitems == []:
		rules = allrules
	else:
		for item in fitems:
			if item == 'SELECT':
				nodes.add('SelectStmt')
			elif item == 'WHERE':
				nodes.add('where_clause')
			else:
				print 'not impl'

			while len(nodes) != 0:
				current = nodes.pop()
				#print current
				if current in allrules:
					tmp = allrules[current]
					rules[current] = tmp
					for rule_list in tmp:
						for n in rule_list:
							if n in allrules and n not in rules:
								nodes.add(n)
				else:
					pass


	for key in rules.keys():
		# handle each grammar node, construct a function in this level


		rule_str = '\tdef handle_' + key + '(self, node, tlevel = 0):\n'
		comment_str = '\t\t\"\"\"\n'
		comment_str += '\t\t@caller:\n'
		comment_str += '\t\t@description:\n'
		comment_str += '\t\t\"\"\"\n\n'
		rule_str += comment_str

		common_str = '\t\tchildren = node.getchildren()\n'
		common_str += '\t\tattributes = node.attrib\n'
		common_str += '\t\trule = int(attributes[\'rule\'])\n\n'

		rule_str += common_str
		rule_index = 1
		for cons_index in range(0, len(rules[key])):
			# handle each rule, construct a if clause in this level
			block_content = ''

			if rule_index == 1:
				# if the first rule of the grammar node
				if rules[key][cons_index] == []:
					# if the rule get NULL
					block_content += '\t\tif rule == rules.' + 'R_' + key.upper() + '__NULL:\n'
					block_content += '\t\t\t# ' + ' '.join(rules[key][cons_index]) + '\n'
				else:
					tmp = rules[key][cons_index]
					length = len(tmp)
					if length >= 2 and tmp[length-2] == '%prec':
						tmp = tmp[0:length-2]

					block_content += '\t\tif rule == rules.' + 'R_' + key.upper() + '_' + str(rule_index) + ':\n'
					block_content += '\t\t\t# ' + ' '.join(tmp) + '\n'
					rule_index += 1

			else:
				if rules[key][cons_index] == []:
					# if the rule get NULL
					block_content += '\t\telif rule == rules.' + 'R_' + key.upper() + '__NULL:\n'
					block_content += '\t\t\t# ' + ' '.join(rules[key][cons_index]) + '\n'
				else:
					tmp = rules[key][cons_index]
					length = len(tmp)
					if length >= 2 and tmp[length-2] == '%prec':
						tmp = tmp[0:length-2]

					block_content += '\t\telif rule == rules.' + 'R_' + key.upper() + '_' + str(rule_index) + ':\n'
					block_content += '\t\t\t# ' + ' '.join(tmp) + '\n'
					rule_index += 1

			rule_str += block_content
			rule_str += '\t\t\treturn ' + dreturn + '\n\n'

		error_handle = '\t\telse:\n'
		error_handle += '\t\t\traise ErrorRuleException([\''+ key + '\', rule])\n\n'
		rule_str += error_handle
		fobj_yacc.write(rule_str)
	fobj_yacc.close()

#
#	the interface
#
def generate(targetfile):

	for i in range(1, file_num + 1):
		print sys.argv[i]
		trees[i] = ET.ElementTree(file=sys.argv[i])

	for i in range(1, file_num + 1):
		scanRule(trees[i].getroot())

	generate_code(targetfile, [], '')