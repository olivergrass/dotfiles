# System update
sudo apt update

# Install Rust
curl https://sh.rustup.rs -sSf | sh

# Apps
sudo apt install -y exa
sudo apt install -y zoxide
sudo apt install -y chezmoi
sudo apt install -y thefuck

cargo install git-delta

# Glow .md renderer
# sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install glow

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh

# Install node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install TMUX package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
