#!/bin/bash

PORT=2021
IP_CLIENT="127.0.0.1"
IP_SERVER="127.0.0.1"
FILE_NAME="vaca_salida.txt"
FLIE_MD5=`echo $FILE_NAME | md5sum | cut -d " " -f 1`


echo "Cliente de ABFP"

echo "(2) Sending Headers"

echo "ABFP $IP_CLIENT" | nc -q 1 $IP_SERVER $PORT

echo "(3) Listening $PORT"

RESPONSE1=`nc -l -p $PORT`
if [ "$RESPONSE1" != "OK_CONN"  ]; then

	echo "No se ha podido connectar con el servidor"
	exit 1

fi

echo "(6) HANDSHAKE"

sleep 1 
echo "THIS_IS_MY_CLASSROOM" | nc -q 1 $IP_SERVER $PORT

echo "(7) Listening $PORT"
RESPONSE2=`nc -l -p $PORT`
if [ "$RESPONSE2" != "YES_IT_IS" ]; then
	echo "KO_HANDSHAKE"
	exit 2
fi

echo "(10) Sending NAME $FILE_NAME"
sleep 1
echo "FILE_NAME $FILE_NAME $FILE_MD5" | nc -q 1 $IP_SERVER $PORT

echo "(11) LISTEN FILE_NAME RESPONSE"
FILT_TEST=`nc -l -p $PORT`

if [ "$FILE_TEST" != "OK_FILE_NAME" ]; then

	echo "Error al enviar el nombre del archivo"

	exit 3
fi

echo "(14) SENDING DATA"

sleep 1
cat $FILE_NAME | nc -q 1 $IP_SERVER $PORT



exit 0
