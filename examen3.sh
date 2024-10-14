#!/bin/sh

DIR="/"

if [ $# -gt 1]
then
	echo Usage..
	exit 1
fi

if [$# -eq 1]

then
	if [ ! -d $1 ]
	then
		echo No existeix el directori
		exit 2
	fi
	DIR=$1
fi

for FILE in $(find $DIR -type f )
do
	
	cat $FILE | grep "Password" > /dev/null
done
