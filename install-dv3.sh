#!/bin/bash
#
if [[ "$(which zenity )" = "/usr/bin/zenity" && "$(which yt-dlp)" = '/usr/bin/yt-dlp' && "$(which ffmpeg)" = '/usr/bin/ffmpeg' ]]; then
echo -e "
         SE COMPRUEBA QUE:
         -----------------
         zenity
         yt-dlp
	 ffmpeg
         -----------------
         SÍ ESTÁN INSTALADOS,
         SE PROCEDE CON LA INSTALCIÓN
	     -----------------
         Esta aplicación nos permite descargar video o el audio del
         video, para su funcionamiento se requiere que esten instalados
         las aplicaciones: yt-dlp, zenity y ffmpeg
         -----------------
         Creado por: Jenrry Soto Dextre
         Correo: dextre1481@gmail.com , jsd@dextre.xyz 
	 "
yo=$(whoami)
icono=$PWD/dva3.svg
ruta=$PWD/dva3.sh
cat > /home/$yo/.local/share/applications/dva3.desktop << EOF
[Desktop Entry]
Type=Application
Categories=Utilitario
Name=DVA3
Comment=Descarga Video Audio
Icon=$icono
Exec=$ruta
Terminal=false
EOF

else

echo -e "
         PORFAVOR INSTALAR:
         ------------------
         zenity
         yt-dlp
	 ffmpeg
         ------------------
         Y LUEGO VOLVER A EJECUTAR ESTE SCRIPT
	 "
fi


