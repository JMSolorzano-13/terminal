#!/bin/bash

# Check if user argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <user_name>"
    exit 1
fi

USER_LOCAL=$1
MANAGER_HOME="/home/$USER_LOCAL"

# Clone the terminal configuration repository if it doesn't exist
if [ ! -d "/tmp/terminal-config" ]; then
    git clone --single-branch https://gitlab.com/HomebrewSoft/facturadmin/terminal_config.git -b 16.0 /tmp/terminal-config
fi

# Update and upgrade system packages
apt update -y && apt upgrade -y

# Install essential packages
apt install -y git

# Install Docker
apt install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add user to docker and sudo groups
usermod -aG docker "$USER_LOCAL"
usermod -aG sudo "$USER_LOCAL"

# Enable passwordless sudo for the user
echo "$USER_LOCAL ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

# Disable password authentication for SSH
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
systemctl restart sshd
sed -i 's/^#PasswordAuthentication no/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
systemctl restart sshd.service

# Add GitHub and GitLab hosts to known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts
ssh-keyscan gitlab.com >> ~/.ssh/known_hosts

# Increase SSH timeout
sed -i 's/#ClientAliveInterval 0/ClientAliveInterval 3600/g' /etc/ssh/sshd_config
sed -i 's/#ClientAliveCountMax 3/ClientAliveCountMax 24/g' /etc/ssh/sshd_config

# Install Micro editor
curl https://getmic.ro | bash
sudo chown root:root micro
sudo mv micro /usr/bin

# Install Fish shell and Ranger file manager
sudo -u "$USER_LOCAL" apt install -y fish ranger

# Change the user's default shell to Fish
sudo -u "$USER_LOCAL" chsh -s "$(which fish)" "$USER_LOCAL"

# Install Starship prompt for Fish
sudo -u "$USER_LOCAL" sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -f
sudo -u "$USER_LOCAL" fish -c "starship init fish | source"

# Copy configuration files
sudo rm -rf "$MANAGER_HOME/.config/fish"
sudo rm -rf "$MANAGER_HOME/.config/starship.toml"
sudo -u "$USER_LOCAL" mkdir -p "$MANAGER_HOME/.config/ranger"
sudo -u "$USER_LOCAL" mkdir -p "$MANAGER_HOME/.config/micro"
sudo chmod -R 777 "$MANAGER_HOME/.config/ranger"
sudo chmod -R 777 "$MANAGER_HOME/.config/micro"
sudo chmod -R 777 "$MANAGER_HOME/.config/fish"
sudo chmod -R 777 /tmp
sudo -u "$USER_LOCAL" cp -r /tmp/terminal-config/* "$MANAGER_HOME/.config/fish"
sudo -u "$USER_LOCAL" cp "$MANAGER_HOME/.config/fish/starship.toml" "$MANAGER_HOME/.config/starship.toml"
sudo -u "$USER_LOCAL" cp "$MANAGER_HOME/.config/fish/commands.py" "$MANAGER_HOME/.config/ranger/commands.py"
sudo -u "$USER_LOCAL" cp "$MANAGER_HOME/.config/fish/commands_full.py" "$MANAGER_HOME/.config/ranger/commands_full.py"
sudo -u "$USER_LOCAL" cp "$MANAGER_HOME/.config/fish/rc.conf" "$MANAGER_HOME/.config/ranger/rc.conf"
sudo -u "$USER_LOCAL" cp "$MANAGER_HOME/.config/fish/rifle.conf" "$MANAGER_HOME/.config/ranger/rifle.conf"
sudo -u "$USER_LOCAL" cp "$MANAGER_HOME/.config/fish/scope.sh" "$MANAGER_HOME/.config/ranger/scope.sh"
sudo -u "$USER_LOCAL" cp "$MANAGER_HOME/.config/fish/settings.json" "$MANAGER_HOME/.config/micro/settings.json"
sudo -u "$USER_LOCAL" cp "$MANAGER_HOME/.config/fish/bindings.json" "$MANAGER_HOME/.config/micro/bindings.json"
sudo chmod -R 777 "$MANAGER_HOME/.config"

# Add kernel parameters for Docker requirements
echo "Adding kernel parameters to GRUB configuration..."
echo "GRUB_CMDLINE_LINUX=\"apparmor=1 lsm=lockdown,yama,apparmor,bpf\"" | sudo tee -a /etc/default/grub

# Regenerate GRUB configuration
echo "Regenerating GRUB configuration..."
sudo update-grub

# Add permission for Docker socket
sudo chmod 777 /var/run/docker.sock