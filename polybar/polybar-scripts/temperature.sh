#!/usr/bin/sh

echo -e "+$(sensors | grep '+' | awk '{print $2}' | tr -d '+=' | tail -n1)°C"
