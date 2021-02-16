#!/bin/bash

PORT=2021

echo "Server ABFP"

echo "(1) Listening $PORT"

HEADER=`nc -l -p $PORT`

echo "TEST! $HEADER"

PREFIX=`echo $HEADER | cut -d " " -f 1`
IP_CLIENT=`echo $HEADER | cut -d " " -f 2`

echo "(4) RESPONSE"

if [ $PREFIX != "ABFP" ]; then

	echo "Error en la cabecera"
	
	sleep 1

	echo "KO_CONN" | nc -q 1 $IP_CLIENT $PORT
	
	exit 1

fi

echo "OK_CONN" | nc -q 1 $IP_CLIENT $PORT

echo "(5) LISTEN"

HANDSHAKE=`nc -l -p $PORT`

echo "(8) Comprobar y responder Handshake"
if [ $HANDSHAKE != "THIS_IS_MY_CLASSROOM"  ]; then
	echo "KO_HANDSHAKE"
	exit 2
	
else

	echo "HANDSHAKE OK"

fi

sleep 3
echo "YES_IT_IS" | nc -q 1 $IP_CLIENT $PORT

echo "(9) Listening $PORT"

FILE_NAME=`nc -l -p $PORT`

PREFIX=`echo $FILE_NAME | cut -d " " -f 1`
NAME=`echo $FILE_NAME | cut -d " " -f 2`

echo "TEST FILE_NAME"
if [ "$PREFIX" != "FILE_NAME" ]; then

	echo "Error en el nombre de archivo"

	sleep 1
	echo "KO_FILE_NAME" | nc -q -1 $IP_CLIENT

	exit 3
	
fi

echo "(12) RESPONSE FILE_NAME ()"
sleep 3 
echo "OK_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT

echo "(13) LISTEN DATA"

nc -l -p $PORT < $FILE_NAME



exit 0
