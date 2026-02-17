#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${HOME}/.local/bin"
CONFIG_DIR="${HOME}/.grago"

echo "[grago] Installing..."

mkdir -p "$INSTALL_DIR" "$CONFIG_DIR"

cp grago.sh "${INSTALL_DIR}/grago"
chmod +x "${INSTALL_DIR}/grago"

if [[ ! -f "${CONFIG_DIR}/config.yaml" ]]; then
  cat > "${CONFIG_DIR}/config.yaml" <<EOF
default_model: gemma
timeout: 30
max_input_chars: 16000
output_format: markdown
# api_base: http://localhost:11434/v1
EOF
  echo "[grago] Created default config: ${CONFIG_DIR}/config.yaml"
fi

echo "[grago] Installed to ${INSTALL_DIR}/grago"
echo "[grago] Make sure ${INSTALL_DIR} is in your PATH"
