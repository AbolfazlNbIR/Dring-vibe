#!/bin/bash

clear

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
WHITE='\033[1;37m'
NC='\033[0m'

print_line() {
    printf "${CYAN}==================================${NC}\n"
}

print_step() {
    printf "${BLUE}[%s*${BLUE}]${NC} %b\n" "${WHITE}" "$1"
}

print_ok() {
    printf "${GREEN}[%s+${GREEN}]${NC} %b\n" "${WHITE}" "$1"
}

print_err() {
    printf "${RED}[%s!${RED}]${NC} %b\n" "${WHITE}" "$1"
}

print_line
printf "${MAGENTA}      INSTALLING DRING-VIBE${NC}\n"
print_line

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

print_step "Updating package list..."
sudo apt update -qq > /dev/null 2>&1
if [ $? -ne 0 ]; then
    print_err "Failed to update package list"
    exit 1
fi
print_ok "Package list updated"

print_step "Installing system packages..."
sudo apt install -y python3 python3-pip python3-venv ffmpeg python3-pygame > /dev/null 2>&1
if [ $? -ne 0 ]; then
    print_err "Failed to install system packages"
    exit 1
fi
print_ok "System packages installed"

print_step "Creating virtual environment..."
python3 -m venv "$PROJECT_DIR/venv" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    print_err "Failed to create virtual environment"
    exit 1
fi
print_ok "Virtual environment created"

print_step "Installing python requirements..."
"$PROJECT_DIR/venv/bin/pip" install --break-system-packages -r "$PROJECT_DIR/requirements.txt" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    print_err "Failed to install python requirements"
    exit 1
fi
print_ok "Python requirements installed"

print_step "Setting permissions..."
chmod +x "$PROJECT_DIR/dringvibe.py" > /dev/null 2>&1
print_ok "Permissions updated"

print_step "Creating command launcher..."
sudo rm -f /usr/local/bin/dring-vibe > /dev/null 2>&1

sudo tee /usr/local/bin/dring-vibe > /dev/null << EOF
#!/bin/bash
cd "$PROJECT_DIR"
exec "$PROJECT_DIR/venv/bin/python3" "$PROJECT_DIR/dringvibe.py" "\$@"
EOF

sudo chmod +x /usr/local/bin/dring-vibe > /dev/null 2>&1
if [ $? -ne 0 ]; then
    print_err "Failed to create launcher"
    exit 1
fi
print_ok "Launcher created"

clear
print_line
printf "${GREEN} DRING-VIBE INSTALLED SUCCESSFULLY ${NC}\n"
print_line
printf "\n"
printf "${YELLOW}Usage:${NC}\n\n"
printf "   ${WHITE}dring-vibe${NC}\n
