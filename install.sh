#!/bin/bash

clear

echo "=================================="
echo "      INSTALLING DRING-VIBE"
echo "=================================="

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

sudo apt update -qq > /dev/null 2>&1

sudo apt install -y 
python3 
python3-pip 
python3-venv 
ffmpeg 
python3-pygame \

> /dev/null 2>&1

python3 -m venv "$PROJECT_DIR/venv" > /dev/null 2>&1

source "$PROJECT_DIR/venv/bin/activate"

pip install --break-system-packages -r "$PROJECT_DIR/requirements.txt" > /dev/null 2>&1

chmod +x "$PROJECT_DIR/dringvibe.py"

sudo rm -f /usr/local/bin/dring-vibe

echo '#!/bin/bash' | sudo tee /usr/local/bin/dring-vibe > /dev/null
echo "cd "$PROJECT_DIR"" | sudo tee -a /usr/local/bin/dring-vibe > /dev/null
echo "exec "$PROJECT_DIR/venv/bin/python3" "$PROJECT_DIR/dringvibe.py" "$@"" | sudo tee -a /usr/local/bin/dring-vibe > /dev/null

sudo chmod +x /usr/local/bin/dring-vibe

clear

echo ""
echo "=================================="
echo " DRING-VIBE INSTALLED SUCCESSFULLY "
echo "=================================="
echo ""
echo "Usage:"
echo ""
echo "   dring-vibe"
echo "   dring-vibe 1"
echo "   dring-vibe 5"
echo ""
echo "Programmer : Abolfazl Nb"
echo ""
