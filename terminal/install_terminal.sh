#!/bin/bash
set -e  # Detener el script si algo falla

echo "[INFO] Instalando dependencias..."
sudo apt update
sudo apt install -y zsh git curl unzip fonts-powerline

echo "[INFO] Instalando Oh My Zsh..."
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "[INFO] Instalando Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "[INFO] Copiando archivos de configuración..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
cp "$SCRIPT_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

echo "[INFO] Instalando JetBrains Mono Nerd Font..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
cd ~

echo "[INFO] Instalando zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

echo "[INFO] Estableciendo zsh como shell por defecto..."
chsh -s "$(which zsh)"

# GNOME Terminal configuración visual
echo "[INFO] Configurando GNOME Terminal..."
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
PROFILE_PATH="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/"

# Usar JetBrainsMono Nerd Font y fondo negro
gsettings set "$PROFILE_PATH" use-system-font false
gsettings set "$PROFILE_PATH" font 'JetBrainsMono Nerd Font 12'
gsettings set "$PROFILE_PATH" use-theme-colors false
gsettings set "$PROFILE_PATH" background-color '#1E1E1E'
gsettings set "$PROFILE_PATH" foreground-color '#C0C0C0'

echo "✅ Instalación completada."
echo "ℹ️ Por favor cierra la sesión o reinicia el sistema para aplicar todos los cambios."
