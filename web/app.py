from flask import Flask, render_template, request, redirect
import os
import subprocess

# Asegúrate de que 'templates' sea una ruta válida.
app = Flask(__name__, template_folder='/home/jsd/dva3/web/templates')

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        url = request.form.get('url')
        tipo = request.form.get('tipo')

        # Ejecutar el script de descarga con subprocess
        if tipo == 'video':
            command = f"yt-dlp --format 'bestvideo+bestaudio/best' --merge-output-format 'mp4' {url}"
        elif tipo == 'audio':
            command = f"yt-dlp --extract-audio --audio-format mp3 --audio-quality 192k -o '%(title)s.%(ext)s' {url}"
        else:
            return "Error: Tipo de descarga no válido."

        try:
            # Ejecutar el comando en bash
            subprocess.run(command, shell=True, check=True)
            return "Descarga completada."
        except subprocess.CalledProcessError:
            return "Error en la descarga."

    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

