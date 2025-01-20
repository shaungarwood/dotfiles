#!/usr/bin/env bash

install_light() {
  # light is backlight control
  sudo apt-get install light
  sudo groupadd -f wheel # may have to reboot to work
  sudo usermod -aG wheel $USER

  if [ ! -f "/etc/sudoers.d/csw-custom-sudoers" ]; then
    {
      echo 'Defaults:%sudo env_keep += "EDITOR"'
      echo 'Defaults:%sudo env_keep += "TERMINFO"'
      echo ""
      echo "%wheel  ALL=(ALL)       NOPASSWD:/usr/bin/light"
    } > /tmp/csw-custom-sudoers

    sudo visudo -c -f /tmp/csw-custom-sudoers && sudo mv /tmp/csw-custom-sudoers /etc/sudoers.d/csw-custom-sudoers
    sudo chmod 440 /etc/sudoers.d/csw-custom-sudoers
    sudo chown root:root /etc/sudoers.d/csw-custom-sudoers
  fi
}

install_and_configure_gammastep() {
    sudo apt install -y gammastep

    # Variables
    SERVICE_FILE="$HOME/.config/systemd/user/gammastep.service"
    CONFIG_DIR="$HOME/.config/gammastep"
    CONFIG_FILE="$CONFIG_DIR/config"
    EXEC_PATH=$(command -v gammastep)

    # Create the gammastep config directory if it doesn't exist
    if [[ ! -d "$CONFIG_DIR" ]]; then
        mkdir -p "$CONFIG_DIR"
        echo "Created directory: $CONFIG_DIR"
    fi

    # Create a default config file if it doesn't exist
    if [[ ! -f "$CONFIG_FILE" ]]; then
        cat << EOF > "$CONFIG_FILE"
[manual]
lat=39.7
lon=-104.9
EOF
        echo "Created default config file: $CONFIG_FILE"
    fi

    # Create the systemd service file
    if [[ ! -f "$SERVICE_FILE" ]]; then
        mkdir -p "$(dirname "$SERVICE_FILE")" # Ensure user systemd directory exists
        cat << EOF > "$SERVICE_FILE"
[Unit]
Description=Gammastep - Adjust screen color temperature
Documentation=https://man.archlinux.org/man/gammastep.1
After=graphical.target

[Service]
ExecStart=$EXEC_PATH -c $CONFIG_FILE
Restart=always

[Install]
WantedBy=default.target
EOF
        echo "Created systemd service file: $SERVICE_FILE"
    fi

    # Reload systemd to pick up changes
    systemctl --user daemon-reload

    # Enable and start the service
    systemctl --user enable gammastep.service
    systemctl --user start gammastep.service

    # Check service status
    if systemctl --user is-active --quiet gammastep.service; then
        echo "Gammastep service is running and enabled."
    else
        echo "Failed to start Gammastep service. Check logs with 'systemctl --user status gammastep.service'."
    fi
}

####################

OS=$(uname)

case $OS in
  "Darwin")
    echo "Not linux, exiting"
    exit 0
    ;;

  "Linux")
    sudo apt-get update
    sudo apt-get install -y sway rofi swaybg swaylock # waybar

    # grimshot is screenshot tool
    sudo apt-get install -y grimshot

    install_light
    install_and_configure_gammastep
    ;;

  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac
