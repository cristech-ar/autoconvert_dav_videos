#!/bin/bash
# Ruta del directorio donde se encuentran los videos originales
original_dir="/home/quick/10.11.12.252"

# Itera a través de todos los archivos .mp4 dentro del directorio y sus subdirectorios
find "$original_dir" -type f -name "*.mp4" | while read file; do
    # extrae la fecha de creación del nombre del archivo
    date=$(echo $file | grep -oE '[[:digit:]]{8}')
    echo $file
    # extrae el año, mes y día de la fecha
    year=${date:0:4}
    month=${date:4:2}
    day=${date:6:2}

    # crea la estructura de carpetas si aún no existe
    mkdir -p $finaldirectory/$year/$month/$day

    # mueve el archivo a la carpeta correspondiente
    mv $file $finaldirectory/$year/$month/$day
done
