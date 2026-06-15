#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f /proc/version ]] || ! grep -qiE "microsoft|wsl" /proc/version; then
  exit 0
fi

echo "==> Enabling WSL interoperability"

sudo python3 <<'PY'
from configparser import ConfigParser
from pathlib import Path
from tempfile import NamedTemporaryFile
import os

path = Path("/etc/wsl.conf")

config = ConfigParser()
config.optionxform = str

if path.exists():
    config.read(path)

if not config.has_section("interop"):
    config.add_section("interop")

config.set("interop", "enabled", "true")
config.set("interop", "appendWindowsPath", "false")

with NamedTemporaryFile("w", delete=False, dir=str(path.parent)) as file:
    config.write(file, space_around_delimiters=False)
    temporary_path = Path(file.name)

os.replace(temporary_path, path)
PY

echo "==> WSL interoperability enabled"
echo "==> Restart WSL from Windows for changes to apply:"
echo "    wsl --shutdown"
