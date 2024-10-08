#! /bin/sh

if [ $# -ne 1 ];then
	echo "Usage"
	exit 1
fi

PID=$1
DADES=(ps -p $PID -o cputime=,etime=)

CPUTIME=$(echo $DADES | cut -d " " -f1)
ETIME=$(echo $DADES | cut -d " " -f2)

#Calcular CPUtime

HHCPU=$(echo $CPUTIME | cut -d ":" -f1)
MMCPU=$(echo $CPUTIME | cut -d ":" -f2)
SSCPU=$(echo $CPUTIME | cut -d ":" -f3)

SSTCPU=$(($HHCPU * 3600 + $MMCPU * 60 + $SSCPU))

#Calcular Elapse Time

MME
SSE
