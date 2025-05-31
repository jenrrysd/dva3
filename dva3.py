import tkinter as tk
from tkinter import ttk, messagebox
import subprocess
import threading
import webbrowser
import os


class DownloaderApp:
    def __init__(self, root):
        self.root = root
        self.root.title("DVA3 - Descarga Audio/Video")

        # Widgets
        tk.Label(root, text="INGRESAR LA URL DEL VIDEO O AUDIO:").pack(pady=5)
        self.url_entry = tk.Entry(root, width=50)
        self.url_entry.pack(pady=8, padx=10)

        # Habilitar menú contextual
        self.setup_context_menu()

        self.option_var = tk.StringVar(value="Audio")
        tk.Radiobutton(root, text="Video.mp4",
                       variable=self.option_var, value="Video").pack()
        tk.Radiobutton(root, text="Audio.mp3",
                       variable=self.option_var, value="Audio").pack()

        self.progress = ttk.Progressbar(root, length=300, mode='indeterminate')

        tk.Button(root, text="Descargar",
                  command=self.start_download).pack(pady=10)

        tk.Button(root, text="Limpiar casilla url",
                  command=self.start_limpiar).pack(pady=10)

        # Créditos en la parte inferior (Nuevo bloque agregado)
        footer = tk.Frame(root)
        footer.pack(side=tk.BOTTOM, pady=10)

        tk.Label(footer, text="Creado por: Jenrry Soto Dextre").pack()

        link = tk.Label(footer, text="Web: https://dextre.xyz",
                        fg="blue", cursor="hand2")
        link.pack()
        link.bind("<Button-1>", lambda e: webbrowser.open("https://dextre.xyz"))

    def setup_context_menu(self):
        """Habilita el menú contextual para copiar/pegar/cortar"""
        menu = tk.Menu(self.root, tearoff=0)
        menu.add_command(
            label="Cortar", command=lambda: self.url_entry.event_generate("<<Cut>>"))
        menu.add_command(
            label="Copiar", command=lambda: self.url_entry.event_generate("<<Copy>>"))
        menu.add_command(
            label="Pegar", command=lambda: self.url_entry.event_generate("<<Paste>>"))

        def show_menu(event):
            menu.tk.call("tk_popup", menu, event.x_root, event.y_root)

        self.url_entry.bind("<Button-3>", show_menu)

    def start_limpiar(self):
        self.url_entry.delete(0, tk.END)

    def start_download(self):
        url = self.url_entry.get()
        if not url:
            messagebox.showerror("Error", "Ingrese una URL válida")
            return

        self.progress.pack(pady=10)
        self.progress.start()

        # Ejecutar en hilo para no bloquear la interfaz
        threading.Thread(
            target=self.run_download,
            args=(url, self.option_var.get()),
            daemon=True
        ).start()

    def run_download(self, url, media_type):
        try:
            # Cambio realizado: Usar la carpeta Descargas por defecto
            download_dir = os.path.expanduser("~/Descargas")
            # Asegura que la carpeta exista
            os.makedirs(download_dir, exist_ok=True)
            os.chdir(download_dir)

            if media_type == "Video":
                cmd = [
                    'yt-dlp',
                    '--cookies-from-browser', 'firefox',
                    '-f', 'bestvideo+bestaudio',
                    '--merge-output-format', 'mp4',
                    '-o', '%(title)s.%(ext)s',
                    url
                ]
            else:
                cmd = [
                    'yt-dlp',
                    '--cookies-from-browser', 'firefox',
                    '--extract-audio',
                    '--audio-format', 'mp3',
                    '--audio-quality', '192k',
                    '-o', '%(title)s.%(ext)s',
                    url
                ]

            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                universal_newlines=True
            )

            while True:
                output = process.stdout.readline()
                if output == '' and process.poll() is not None:
                    break
                if output:
                    print(output.strip())

            self.progress.stop()
            self.progress.pack_forget()

            if process.returncode == 0:
                messagebox.showinfo(
                    "Listo",
                    f"Descarga completada en:\n{download_dir}",
                    detail="Presione 'Finalizado' para cerrar"
                )
            else:
                messagebox.showerror(
                    "Error",
                    "Ocurrió un error en la descarga",
                    detail=process.stderr.read()
                )

        except Exception as e:
            self.progress.stop()
            messagebox.showerror("Error crítico", str(e))


if __name__ == "__main__":
    root = tk.Tk()
    app = DownloaderApp(root)
    root.mainloop()
