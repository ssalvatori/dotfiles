#!/usr/bin/env bash

set -e
set -o pipefail

TARGET_PATH="${HOME}/.local/neovim-nightly"
DOWNLOAD_PATH="/tmp/nvim-macos-arm64.tar.gz"

# Clean up any previous installation
rm -rf "${TARGET_PATH}" || true
mkdir -p "${TARGET_PATH}"
rm -rf "${DOWNLOAD_PATH}" || true

# Download and install Neovim nightly build for macOS ARM64

curl -fLo "${DOWNLOAD_PATH}" https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
xattr -c "${DOWNLOAD_PATH}"
tar xzvf "${DOWNLOAD_PATH}" -C "${TARGET_PATH}" --strip-components=1
ln  -sf "${TARGET_PATH}/bin/nvim" "${HOME}/.local/bin/nvim"

# Clean up nvim
rm -rf ${HOME}/.local/share/nvim || true
