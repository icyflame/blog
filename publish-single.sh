#!/bin/bash

set -euo pipefail

INPUT=${1:-}
OUTPUT_DIR=${2:-}
if [[ -z "$INPUT" || -z "$OUTPUT_DIR" ]];
then
	echo "ERROR: Script needs atleast 2 arguments: ./publish-single.sh <INPUT-ORG-FILE> <OUTPUT-DIRECTORIES>"
	exit 41
fi

EMACS=$(which emacs)
if [[ ! -x "$EMACS" ]];
then
	echo "ERROR: Emacs does not exist on this system"
	exit 42
fi

$EMACS --batch -l ~/.emacs.d/init.el -l publish.el \
    --eval '(kannan/publish "'"$INPUT"'" "'"$OUTPUT_DIR"'")'
