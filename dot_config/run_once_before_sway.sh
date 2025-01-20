#!/usr/bin/env bash

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


    ;;
esac
