#!/bin/bash

url=$(zenity --entry --width=500 --title="DVA3" --text "Ingrese la URL del video o audio a descargar"  )
descarga=$(zenity --list --column Selectione --column "VIDEO O AUDIO" FALSE Video TRUE Audio --radiolist --title="DVA3" --text "Escoga Video o Audio para descargar")

if [[ "$descarga" == "Video" ]]; then
	cd /home/$USER/Vídeos || cd /home/$USER/Videos
	if yt-dlp --format 'bestvideo+bestaudio/best' --merge-output-format 'mp4' "$url" | zenity --progress --pulsate; then
		echo "descarga completa"
		zenity --text="DESCARGA COMPLETA\nEl video descaragdo está en el directorio Vídeos o Videos" --info
	else
		echo "Error de Descarga"
		zenity --text="ERROR EN LA DESCARGA DEL VIDEO" --error
	fi
fi

if [[ "$descarga" == "Audio" ]]; then
	cd /home/$USER/Música || cd /home/$USER/Music
	if yt-dlp --extract-audio --audio-format mp3 --audio-quality 192k -o '%(title)s.%(ext)s' "$url" | zenity --progress --pulsate; then
		echo "descarga terminada"
		zenity --text="DESCARGA COMPLETA\nEl audio descaragdo está en el directorio Música o Music" --info
	else
		echo "Error de la descarga"
		zenity --text="ERROR EN LA DESCARGA DEL AUDIO" --error
	fi
fi
