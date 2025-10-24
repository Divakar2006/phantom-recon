#!/bin/bash

# Quick setup script for reconnaissance tool
echo "Setting up reconnaissance tool requirements..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install Go
sudo apt install -y golang-go
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
source ~/.bashrc

# Install tools
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/tomnomnom/httprobe@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/s0md3v/Arjun@latest

# Install Python tools
sudo apt install -y python3 python3-pip
pip3 install LinkFinder JSParser xnLinkFinder

# Create directories
mkdir -p ~/tools
mkdir -p ~/recon

# Clone LinkFinder
git clone https://github.com/GerbenJavado/LinkFinder.git ~/tools/LinkFinder
cd ~/tools/LinkFinder
pip3 install -r requirements.txt

echo "Setup complete! Please restart your terminal or run 'source ~/.bashrc' to update your PATH."