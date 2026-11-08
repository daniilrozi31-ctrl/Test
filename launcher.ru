import json
import subprocess
import tkinter as tk
from pathlib import Path
from tkinter import filedialog, messagebox

APP_DIR = Path(__file__).resolve().parent
CONFIG_FILE = APP_DIR / "config.json"


def load_game_folder() -> str:
    try:
        data = json.loads(CONFIG_FILE.read_text(encoding="utf-8"))
        return data.get("game_folder", "")
    except (OSError, json.JSONDecodeError):
        return ""


def save_game_folder(folder: str) -> None:
    CONFIG_FILE.write_text(
        json.dumps({"game_folder": folder}, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )


class Launcher:
    def __init__(self, root: tk.Tk) -> None:
        self.root = root
        self.root.title("Test — лаунчер GTA V")
        self.root.geometry("520x210")
        self.root.resizable(False, False)
        self.game_folder = load_game_folder()

        tk.Label(root, text="Папка с GTA V:", font=("Segoe UI", 11)).pack(pady=(20, 6))

        self.path_var = tk.StringVar(value=self.game_folder)
        tk.Entry(root, textvariable=self.path_var, width=65).pack(padx=18)

        buttons = tk.Frame(root)
        buttons.pack(pady=14)
        tk.Button(buttons, text="Выбрать папку", command=self.select_folder).pack(side=tk.LEFT, padx=6)
        tk.Button(
            buttons,
            text="Запустить GTA V",
            command=self.launch_game,
            bg="#2e8b57",
            fg="white",
            padx=10,
        ).pack(side=tk.LEFT, padx=6)

        self.status_var = tk.StringVar(value="Выберите папку, где находится GTA5.exe.")
        tk.Label(root, textvariable=self.status_var, wraplength=480).pack(pady=6)

    def select_folder(self) -> None:
        folder = filedialog.askdirectory(title="Выберите папку GTA V")
        if not folder:
            return

        if not (Path(folder) / "GTA5.exe").is_file():
            messagebox.showerror("GTA5.exe не найден", "Выберите папку, в которой непосредственно находится GTA5.exe.")
            return

        self.game_folder = folder
        self.path_var.set(folder)
        try:
            save_game_folder(folder)
        except OSError as error:
            messagebox.showerror("Ошибка сохранения", str(error))
            return
        self.status_var.set("Папка игры сохранена.")

    def launch_game(self) -> None:
        folder = self.path_var.get().strip().strip('"')
        exe_path = Path(folder) / "GTA5.exe"
        if not exe_path.is_file():
            messagebox.showerror("Игра не найдена", "Выберите папку с файлом GTA5.exe.")
            return

        try:
            save_game_folder(folder)
            self.game_folder = folder
            subprocess.Popen([str(exe_path)], cwd=str(exe_path.parent))
            self.status_var.set("Команда запуска отправлена.")
        except (OSError, subprocess.SubprocessError) as error:
            messagebox.showerror("Не удалось запустить игру", str(error))


if __name__ == "__main__":
    app_root = tk.Tk()
    Launcher(app_root)
    app_root.mainloop()
