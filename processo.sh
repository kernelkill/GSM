#!/bin/bash

#Script para verificar processo de um programa em execuçao.

PID=$(ps -eo pid,comm | awk '$2 =="firefox"{print $1}')

echo $PID >> firefox.pid
 
if [ -z "$PID" ];then
	echo "processo não esta em execuçao!"
else
	echo "processo esta em execuçao"
	cat firefox.pid
fi

rm firefox.pid