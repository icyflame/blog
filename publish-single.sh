#!/bin/bash

INPUT=$1
if [[ -z "$INPUT" ]];
then
	echo "ERROR: Script needs atleast one argument: ./publish-single.sh <INPUT-ORG-FILE>"
	exit 41
fi

EMACS=$(which emacs)
if [[ ! -x "$EMACS" ]];
then
	echo "ERROR: Emacs does not exist on this system"
	exit 42
fi

$EMACS --batch -l ~/.emacs.d/init.el -l publish.el \
    --eval '(kannan/publish "'"$INPUT"'")'
