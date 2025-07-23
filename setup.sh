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


initialize_synchronizer() {
    info "Initializing synchronizer configuration (synchronize init)..."
    synchronize init | tee -a "$LOG_FILE"
    success "synchronize init completed."
}


start_synchronizer() {
    info "Starting synchronizer node..."
    synchronize start | tee -a ~/synchronize.log
    success "synchronizer node started (see ~/synchronize.log for output)."
}

info "===== Synchronizer CLI Setup Started at $(date) ====="


update_system
install_npm
install_synchronizer_cli
initialize_synchronizer
start_synchronizer

success "All steps completed successfully!"
info "===== Synchronizer CLI Setup Ended at $(date) ====="

exit 0
