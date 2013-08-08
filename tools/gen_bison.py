#!/usr/bin/env python
#
#	File: gen_bison.py
#	Author: Wei Tong
#	Generate the bison code to construct a syntax tree by simplify rules.
#
#	IDENTIFICATION
#		tools/gen_bison.py
#
#
#	call the generate() function to do the job
#

import sys
import xml.etree.cElementTree as ET

XML_PATH = "./"
GENERATE_PATH = "./generate-file/"

file_num = len(sys.argv) - 1

ws = [' ', '\n', '\t']
types = []
rules = {}
final_types = []
trees = {}

for i in range(1, file_num + 1):
	print XML_PATH + sys.argv[i]
	trees[i] = ET.ElementTree(file=sys.argv[i])


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






#
#	generate_types
#		generate the types declaration
#
def generate_types():
	fobj_types = open(GENERATE_PATH + "types/" + sys.argv[1].split('.')[0] + ".y.gc", "w")
	for i in final_types:
		fobj_types.write("%type <node_type> " + i + "\n")
	fobj_types.close()

#
#	generate_ids 
#		generate the ids enumeration
#
def generate_ids(fileout):
	fobj_ids = open(fileout, "w")
	fobj_ids.write("enum __ids {")
	for i in range(0, len(final_types)):
		if i == 0:
			fobj_ids.write('\n\tID_' + final_types[i].upper())
		else:
			fobj_ids.write(',\n\tID_' + final_types[i].upper())
	fobj_ids.write("\n};")
	fobj_ids.close()

#
#	generate_rules
#		generate the rules enumeration
#
def generate_rules(fileout):
	fobj_rules = open(fileout, "w")
	fobj_const = open("const.py", "w")
	fobj_rules.write("enum __rules {")
	flag = 0
	index = 0
	for key in rules.keys():
		rule_index = 1
		for cons  in rules[key]:
			index += 1
			if flag == 0:
				if cons == []:
					fobj_rules.write('\n\tR_' + (key.upper() + "__NULL = " + str(index)))
				else:
					fobj_rules.write('\n\tR_' + (key.upper() + "_" + str(rule_index))  + " = "+ str(index))#"__" + "_".join(cons).upper()))
			else:
				if cons == []:
					fobj_rules.write(',\n\tR_' + (key.upper() + "__NULL = " + str(index)))
				else:
					fobj_rules.write(',\n\tR_' + (key.upper() + "_" + str(rule_index) + " = " + str(index))) #"__" + "_".join(cons).upper()))

			if cons == []:
				fobj_const.write('\nR_' + (key.upper() + "__NULL = " + str(index)))
			else:
				fobj_const.write('\nR_' + (key.upper() + "_" + str(rule_index) + " = " + str(index)))

			rule_index += 1
			flag += 1


	fobj_rules.write("\n};")
	fobj_rules.close()


#
#	generate_code
#		generate the bison rule/action code to construct the AST
#
def generate_code(fileout):
	fobj_yacc = open(fileout, "w")
	for key in rules.keys():
		rule_str = key + "\n"
		rule_index = 1
		for cons_index in range(0, len(rules[key])):
			block_content = ""

			if rules[key][cons_index] == []:
				block_content += "\t\tJOUT(\"SYN: " + key + " -> NULL \\n\");\n"

				block_content += "\t\t$$ = cons_subtree(1, NULL);\n"
				
				block_content += "\t\tset_content(&$$, @$.first_line, " + "\"" + key + "\", " + \
					"ID_" + key.upper()  + ", " + \
					"R_" + key.upper() + "__NULL" + ");\n"

			else:
				tmp = rules[key][cons_index]
				length = len(tmp)
				if length >= 2 and tmp[length-2] == '%prec':
					tmp = tmp[0:length-2]

				block_content += "\t\tJOUT(\"SYN: " + key + " -> " + "_".join(tmp) + " \\n\");\n"

				block_content += "\t\t$$ = cons_subtree("
				
				nodes_num = len(tmp)
				block_content += str(nodes_num) + ", " + \
					", ".join(["$" + str(i) for i in range(1, nodes_num + 1)]) + ");\n"
				
				block_content += "\t\tset_content(&$$, @$.first_line, " + "\"" + key + "\", " + \
					"ID_" + key.upper() + ", " + \
					"R_" + key.upper() + "_" + str(rule_index) + ");\n"; #"_".join(tmp).upper() + ");\n"
			
			rule_index += 1

			if cons_index == 0:
				rule_nodes = ""
				if rules[key][cons_index] == []:
					rule_nodes = "/* empty */"
				else:
					rule_nodes = " ".join(rules[key][cons_index])
				
				rule_str = rule_str + "\t: " + rule_nodes + " {\n" + block_content + \
					"\t}\n" 
			else:
				rule_nodes = ""
				if rules[key][cons_index] == []:
					rule_nodes = "/* empty */"
				else:
					rule_nodes = " ".join(rules[key][cons_index])

				rule_str = rule_str + "\t| " + rule_nodes + " {\n" + block_content + \
					"\t}\n"

		rule_str += "\t;\n\n"
		fobj_yacc.write(rule_str)
	fobj_yacc.close()

#
#	the interface
#
def generate():
	for i in range(1, file_num+1):
		scanRule(trees[i].getroot())
	final_types = {}.fromkeys(types).keys()
	#
	#
	#
	#