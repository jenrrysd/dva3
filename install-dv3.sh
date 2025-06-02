#!/bin/bash

# Creado por: Jenrry Soto Dextre
# Correo: dextre1481@gmail.com , web: https://dextre.xyz 

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
Exec=/usr/bin/python3 $ruta
Terminal=false
EOF

echo -e "
Porfavor ahora busca la aplicación DVA3.
No te olvides de hacer login en Firefox
en Youtube y Facebook, este programa
funciona con los cookies del navegador.
"
