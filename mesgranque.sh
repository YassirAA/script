#!/bin/sh

#revisar que els variables estan be
if [ $# -lt 2 ], then
	exit 1
fi

MAX=$1
#shift per entrar el bucle
shift

while [ $# -gt 0 ]
do
	FILE=$1
	FILESIZE=$(du -b $FILE | cut -f1)

#mirar si existeix

	if [ ! -f $FILE ]
	then
		echo El fitxer no existeix
	elif [ $FILESIZE -gt $MAX ]
	then
		ARRAYFILE=$((echo $FILE $FILESIZE-$MAX))
		echo El fixer es sobrepasa $(($FILESIZE-$MAX)) del limit
	fi

#shift per agafar el seguent valor del bucle
	shift
done
echo $ARRAYFILE
