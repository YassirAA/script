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

MME=$(echo $ETIME | cut -d ":" -f1)
SSE=$(echo $ETIME | cut -d ":" -f2)

SSET=$(($MME * 60 + $SSE))

#Average time
AVG=$((100 * $SSTCPU / $SSET))
echo "Average CPU usage in PID $PID in the last $ETIME is $AVG%"
