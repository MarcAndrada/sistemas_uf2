#!/bin/bash
PORT=2021

echo"Server ABFP"

echo "listening $PORT"

nc -l -p $PORT
