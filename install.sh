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

sudo tee /usr/local/bin/dring-vibe > /dev/null << EOF
#!/bin/bash

cd "$PROJECT_DIR"

exec "$PROJECT_DIR/venv/bin/python3" 
"$PROJECT_DIR/dringvibe.py" "$@"
EOF

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
