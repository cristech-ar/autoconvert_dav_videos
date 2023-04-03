#!/bin/bash

# Define el directorio a limpiar y el límite de antigüedad (en segundos)
DIR="/home/quick/10.11.12.252"
LIMITE_ANTIGUEDAD=$((2*24*60*60)) # 2 días en segundos

# Busca los archivos que cumplan la condición y los borra
find "$DIR" -type f -mtime +$((LIMITE_ANTIGUEDAD/60)) -delete


