#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Linux" ]]; then
  exit 0
fi

if ! command -v zsh >/dev/null 2>&1; then
  echo "==> zsh unavailable; skipping Oh My Zsh installation"
  exit 0
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "==> curl unavailable; skipping Oh My Zsh installation"
  exit 0
fi

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  echo "==> Oh My Zsh already installed"
  exit 0
fi

echo "==> Installing Oh My Zsh"

RUNZSH=no \
CHSH=no \
KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "==> Oh My Zsh installed"
