#!/bin/bash
#
if [[ "$(which zenity )" = "/usr/bin/zenity" && "$(which yt-dlp)" = '/usr/bin/yt-dlp' ]]; then
echo -e "
         SE COMPRUEBA QUE:
         -----------------
         zenity
         yt-dlp
         -----------------
         SÍ ESTÁN INSTALADOS,
         SE PROCEDE CON LA INSTALCIÓN
	 -----------------
	 Esta aplicación nos permite descargar video o el audio del video
	 para su funcionamiento se requiere que esten instalados las
	 aplicaciones de yt-dlp y zenity.
	 -----------------
	 Creado por: Jenrry Soto Dextre
	 Correo: dextre1481@gmail.com , jsd@dextre.xyz 
	 "

icono=$PWD/dva3.svg
ruta=$PWD/dva3.sh
sudo bash -c  'cat > /usr/share/applications/dva3.desktop << EOF
[Desktop Entry]
Type=Application
Categories=Utilitario
Name=DVA3
Comment=Descarga Video Audio
Icon='$icono'
Exec='$ruta'
MimeType=image/jpeg;image/png;image/svg;
Terminal=false
EOF'

else

echo -e "
         PORFAVOR INSTALAR:
         ------------------
         zenity
         yt-dlp
         ------------------
         Y LUEGO VOLVER A EJECUTAR ESTE SCRIPT
	 "
fi


