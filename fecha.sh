#!/bin/bash

# define el directorio donde se encuentran los archivos a ordenar
directory="/home/quick/quick/src/public/videos"
# define el directorio donde se deben ordenar
finaldirectory="/home/quick/quick/videos/alisos"
# itera a través de cada archivo en el directorio
for file in $directory/*; do

    # extrae la fecha de creación del nombre del archivo
    date=$(echo $file | grep -oE '[[:digit:]]{8}')

    # extrae el año, mes y día de la fecha
    year=${date:0:4}
    month=${date:4:2}
    day=${date:6:2}

   

    # crea la estructura de carpetas si aún no existe
    mkdir -p $finaldirectory/$year/$month/$day

    # mueve el archivo a la carpeta correspondiente
    mv $file $finaldirectory/$year/$month/$day
    # sincroniza con AWS
    aws s3 sync /home/quick/quick/videos s3://quick-monitoring-videos/
done
