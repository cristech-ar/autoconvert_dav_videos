#!/bin/bash

# Función para la conversión de video
convert_videos() {

    # Ruta del directorio donde se encuentran los videos originales
    original_dir="/home/quick/10.11.12.252"

    # Ruta del directorio donde se almacenarán los videos convertidos
    converted_dir="/home/quick/quick/src/public/videos"

   
    # Itera a través de todos los archivos .DAV dentro del directorio y sus subdirectorios
    find "$original_dir" -type f -name "*.dav" | while read file; do
        # Verifica si el archivo ya se ha convertido
        if [ ! -f "${file%.*}.mp4" ]; then
            # Si el archivo no se ha convertido, realiza la conversión
            ffmpeg -nostdin -i "$file" -c:v libxvid -b:v 1000k -vcodec h264 -preset ultrafast "${file%.*}.mp4"

            # Espera a que termine la conversión o hasta que se alcance el tiempo máximo de espera
            # Esperar a que el comando termine
            wait $!

            # Mueve el archivo convertido al directorio correspondiente
            mv "${file%.*}.mp4" "$converted_dir"
            rm "$file"
        fi
    done
}

# Tiempo máximo de espera en segundos para el script completo
    timeout=3540 # 59 minutos

# Ejecuta la función de conversión de video dentro del comando timeout
timeout $timeout sh -c "$(declare -f convert_videos); convert_videos"
