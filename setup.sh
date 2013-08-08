#!/bin/bash
# IDENTIFICATION
#	setup.sh

if [ -z $1 ]; then
	cd ./tools/yayaccc
	make 
	cd ../../parser
	make
elif [ $1 == "all" ]; then
	cd ./tools/yayaccc
	make
	cd ../../parser
	make all
elif [ $1 == "tools" ]; then
	cd ./tools/yayaccc
	make
elif [ $1 == "parser" ]; then
	cd ./parser
	make all
fi
