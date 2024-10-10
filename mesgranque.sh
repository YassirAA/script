#!/bin/sh

if [ $# -lt 2 ], then
	exit 1
fi

MAX=$1
shift

while [ $# -gt 0 ]
do
	FILE=$1
	FILESIZE=$(du -b $FILE | cut -f1)

	if [ ! -f $FILE ]
	then
		echo El fitxer no existeix
	elif [ $FILESIZE -gt $MAX ]
	then
		echo El fixer es sobrepasa $(($FILESIZE-$MAX)) del limit
	fi

	shift
done 
