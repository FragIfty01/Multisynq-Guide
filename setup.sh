#!/bin/bash

set -euo pipefail

SCRIPT_NAME="$(basename "$0")"
LOG_FILE="/var/log/${SCRIPT_NAME%.sh}.log"

info() {
    printf "\e[34m[INFO]\e[0m %s\n" "$1"
}

success() {
    printf "\e[32m[SUCCESS]\e[0m %s\n" "$1"
}

error() {
    printf "\e[31m[ERROR]\e[0m %s\n" "$1" >&2
}

is_package_installed() {
    dpkg -s "$1" &> /dev/null
}

check_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        if [[ "${ID,,}" != "ubuntu" ]]; then
            error "Unsupported operating system: $NAME. This script is intended for Ubuntu."
            exit 1
        elif [[ "${VERSION_ID,,}" != "22.04" && "${VERSION_ID,,}" != "20.04" ]]; then
            error "Unsupported OS version: $VERSION. This script is for Ubuntu 20.04 or 22.04."
            exit 1
        else
            info "Operating System: $PRETTY_NAME"
        fi
    else
        error "/etc/os-release not found. Unable to determine the operating system."
        exit 1
    fi
}

update_system() {
    info "Updating package list..."
    sudo apt update -y | tee -a "$LOG_FILE"
    success "System updated."
}

install_npm() {
    if command -v npm &>/dev/null; then
        info "npm is already installed. Skipping."
    else
        info "Installing npm..."
        sudo apt install -y npm | tee -a "$LOG_FILE"
        success "npm installed."
    fi
}

install_synchronizer_cli() {
    if command -v synchronize &>/dev/null; then
        info "synchronizer-cli already installed. Skipping."
    else
        info "Installing synchronizer-cli globally with npm..."
        sudo npm install -g synchronizer-cli | tee -a "$LOG_FILE"
        success "synchronizer-cli installed globally."
    fi
}

install_screen() {
    if command -v screen &>/dev/null; then
        info "screen is already installed. Skipping."
    else
        info "Installing screen utility..."
        sudo apt install -y screen | tee -a "$LOG_FILE"
        success "screen installed."
    fi
}

start_synchronizer_in_screen() {
    info "Starting synchronizer in a detached screen session named 'synq'..."
    # Kill any existing 'synq' session to avoid conflict
    if screen -list | grep -q "\.synq"; then
        info "An old 'synq' screen session exists. Killing it."
        screen -S synq -X quit || true
    fi
    # Start a new detached screen and run synchronize start inside it
    screen -dmS synq bash -c 'synchronize start | tee -a ~/synchronize.log'
    success "synchronizer started in screen session 'synq'."
    info "To attach to this session, run: screen -r synq"
    info "To detach: Press Ctrl+A then D"
    info "Logs are saved to ~/synchronize.log"
}

info "===== Synchronizer CLI Setup Started at $(date) ====="

check_os
update_system
install_npm
install_synchronizer_cli
install_screen
start_synchronizer_in_screen

success "All steps completed successfully!"
info "===== Synchronizer CLI Setup Ended at $(date) ====="

exit 0
