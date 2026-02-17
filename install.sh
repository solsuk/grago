#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${HOME}/.local/bin"
CONFIG_DIR="${HOME}/.gerago"

echo "[gerago] Installing..."

mkdir -p "$INSTALL_DIR" "$CONFIG_DIR"

cp gerago.sh "${INSTALL_DIR}/gerago"
chmod +x "${INSTALL_DIR}/gerago"

if [[ ! -f "${CONFIG_DIR}/config.yaml" ]]; then
  cat > "${CONFIG_DIR}/config.yaml" <<EOF
default_model: gemma
timeout: 30
max_input_chars: 16000
output_format: markdown
# api_base: http://localhost:11434/v1
EOF
  echo "[gerago] Created default config: ${CONFIG_DIR}/config.yaml"
fi

echo "[gerago] Installed to ${INSTALL_DIR}/gerago"
echo "[gerago] Make sure ${INSTALL_DIR} is in your PATH"
