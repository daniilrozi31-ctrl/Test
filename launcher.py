import json
import subprocess
import tkinter as tk
from pathlib import Path
from tkinter import filedialog, messagebox

CONFIG_FILE = Path(__file__).resolve().with_name("config.json")


def load_folder():
    try:
        return json.loads(CONFIG_FILE.read_text(encoding="utf-8")).get("game_folder", "")
    except (OSError, json.JSONDecodeError):
        return ""


def save_folder(folder):
    CONFIG_FILE.write_text(
        json.dumps({"game_folder": folder}, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )


class Launcher:
    def __init__(self, root):
        self.root = root
        root.title("Test — лаунчер GTA V")
        root.geometry("520x210")
        root.resizable(False, False)

        tk.Label(root, text="Папка GTA V (где находится GTA5.exe):", font=("Segoe UI", 11)).pack(pady=(20, 6))
        self.path = tk.StringVar(value=load_folder())
        tk.Entry(root, textvariable=self.path, width=65).pack(padx=18)

        buttons = tk.Frame(root)
        buttons.pack(pady=14)
        tk.Button(buttons, text="Выбрать папку", command=self.select_folder).pack(side=tk.LEFT, padx=6)
        tk.Button(buttons, text="Запустить GTA V", command=self.launch, bg="#2e8b57", fg="white", padx=10).pack(side=tk.LEFT, padx=6)

        self.status = tk.StringVar(value="Выберите папку с игрой.")
        tk.Label(root, textvariable=self.status, wraplength=480).pack(pady=6)

    def select_folder(self):
        folder = filedialog.askdirectory(title="Выберите папку GTA V")
        if not folder:
            return
        if not (Path(folder) / "GTA5.exe").is_file():
            messagebox.showerror("GTA5.exe не найден", "Выберите папку, где непосредственно находится GTA5.exe.")
            return
        self.path.set(folder)
        try:
            save_folder(folder)
            self.status.set("Папка игры сохранена.")
        except OSError as error:
            messagebox.showerror("Ошибка сохранения", str(error))

    def launch(self):
        folder = self.path.get().strip().strip('"')
        exe = Path(folder) / "GTA5.exe"
        if not exe.is_file():
            messagebox.showerror("Игра не найдена", "Выберите папку с файлом GTA5.exe.")
            return
        try:
            save_folder(folder)
            subprocess.Popen([str(exe)], cwd=str(exe.parent))
            self.status.set("Команда запуска отправлена.")
        except OSError as error:
            messagebox.showerror("Не удалось запустить игру", str(error))


if __name__ == "__main__":
    window = tk.Tk()
    Launcher(window)
    window.mainloop()
