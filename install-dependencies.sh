#! /bin/sh

# Fetch Tmux plugins.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install babashka.
curl -sLO https://raw.githubusercontent.com/babashka/babashka/master/install;
chmod +x install;
./install;
rm install;

# Install uv.
curl -LsSf https://astral.sh/uv/install.sh | sh;

