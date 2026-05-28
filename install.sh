#!/bin/bash

clear

echo "=================================="
echo "      INSTALLING DRING-VIBE"
echo "=================================="

PROJECT_DIR="$(pwd)"

sudo apt update -qq > /dev/null 2>&1
sudo apt install -y python3-pip python3-venv ffmpeg python3-pygame > /dev/null 2>&1

python3 -m venv venv > /dev/null 2>&1

source venv/bin/activate

pip install --break-system-packages -r requirements.txt > /dev/null 2>&1

chmod +x dringvibe.py

sudo bash -c "cat > /usr/local/bin/dring-vibe" << EOF
#!/bin/bash

cd $PROJECT_DIR

exec $PROJECT_DIR/venv/bin/python 
$PROJECT_DIR/dringvibe.py "$@"
EOF

sudo chmod +x /usr/local/bin/dring-vibe

clear

echo ""
echo "=================================="
echo " DRING-VIBE INSTALLED SUCCESSFULLY "
echo "=================================="
echo ""
echo "Run with:"
echo ""
echo "   dring-vibe"
echo ""
echo "Programmer : Abolfazl Nb"
echo ""
