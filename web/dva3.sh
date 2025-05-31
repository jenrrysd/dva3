#!/bin/bash

url="$1"
descarga="$2"

echo "Content-type: text/html"
echo ""

# Leer datos enviados por POST
read POST_DATA

# Obtener los parámetros
url=$(echo "$POST_DATA" | grep -oP '(?<=url=)[^&]*')
descarga=$(echo "$POST_DATA" | grep -oP '(?<=descarga=)[^&]*')

url=$(echo "$url" | sed 's/%3A/:/g' | sed 's/%2F/\//g')  # Decodificar URL

if [[ "$descarga" == "Video" ]]; then
#    cd /home/$USER/Vídeos
    yt-dlp --format 'bestvideo+bestaudio/best' --merge-output-format 'mp4' "$url"
    echo "<h1>Video descargado en el directorio /home/$USER/Vídeos.</h1>"
elif [[ "$descarga" == "Audio" ]]; then
#    cd /home/$USER/Música
    yt-dlp --extract-audio --audio-format mp3 --audio-quality 192k -o '%(title)s.%(ext)s' "$url"
    echo "<h1>Audio descargado en el directorio /home/$USER/Música.</h1>"
else
    echo "<h1>Error: Opción no válida.</h1>"
fi

