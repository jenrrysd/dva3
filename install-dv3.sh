#!/bin/bash
#
if [[ "$(which python )" = "/usr/bin/python" "$(which python3 )" = "/usr/bin/python3"  && "$(which yt-dlp)" = '/usr/bin/yt-dlp' && "$(which tkinter)" =  ]]; then

echo -e "
         SE COMPRUEBA QUE:
         -----------------
         python ó
         python3
         yt-dlp
         tkinter
         firefox (hacer login a youtube)
         -----------------
         SÍ ESTÁN INSTALADOS,
         SE PROCEDE CON LA INSTALCIÓN
	     -----------------
         Esta aplicación nos permite descargar video o el audio del
         video, para su funcionamiento se requiere que esten instalados
         las aplicaciones: yt-dlp, python y firefox.
         -----------------
         Creado por: Jenrry Soto Dextre
         Correo: dextre1481@gmail.com , web: https://dextre.xyz 
	 "
yo=$(whoami)
icono=$PWD/dva3.svg
ruta=$PWD/dva3.py
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
         sudo dnf install python3-tkinter ó
         sudo apt install python3-tk
         yt-dlp
	 ffmpeg
         firefix (hacer sesion en youtube para emplear las cookies)

         ------------------
         Y LUEGO VOLVER A EJECUTAR ESTE SCRIPT
	 "
fi


