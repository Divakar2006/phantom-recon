

# P H A N T O M - R E C O N

![Version](https://img.shields.io/badge/version-1.0-blue)
![Build](https://img.shields.io/badge/build-passing-brightgreen)
![Platform](https://img.shields.io/badge/platform-linux-yellow)

<p align="center">
  <img src="https://github.com/Divakar2006/phantom-recon/img/logo.png" alt="Phantom Recon Logo" width="200">
</p>

<p align="center">
  <b>Advanced reconnaissance automation tool for security professionals</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Built%20with-Bash-1f425f.svg">
  <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg">
  <img src="https://img.shields.io/badge/Open%20Source-%F0%9F%91%8D-blue.svg">
</p>

---

## 🌟 Features

- 🔍 **Comprehensive Subdomain Enumeration** - Discover all subdomains using multiple tools
- 🌐 **Live Host Discovery** - Identify active hosts with detailed information
- 📜 **Historical URL Collection** - Gather URLs from archived sources
- 📄 **JavaScript Analysis** - Extract endpoints from JavaScript files
- 🔧 **Parameter Discovery** - Find hidden parameters in URLs
- 📊 **Detailed Reporting** - Generate comprehensive reconnaissance reports
- 🎨 **Attractive UI** - Enjoy a visually appealing interface with progress indicators
- ⚡ **High Performance** - Optimized for speed and efficiency

## 🚀 Installation

### Quick Setup (Recommended)

1. Clone the repository:
   ```bash
   git clone https://github.com/divu/phantom-recon.git
   cd phantom-recon
   ```

2. Run the setup script to install all required tools:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. Make the main tool executable:
   ```bash
   chmod +x phantom-recon.sh
   ```

### Manual Installation (If setup.sh fails)

If the automated setup encounters any issues, please install the tools manually:

1. **Install Go** (required for many tools):
   ```bash
   sudo apt update
   sudo apt install -y golang-go
   echo 'export GOPATH=$HOME/go' >> ~/.bashrc
   echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
   source ~/.bashrc
   ```

2. **Install required tools**:
   ```bash
   go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
   go install -v github.com/tomnomnom/assetfinder@latest
   go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
   go install -v github.com/tomnomnom/httprobe@latest
   go install -v github.com/lc/gau/v2/cmd/gau@latest
   go install -v github.com/tomnomnom/waybackurls@latest
   go install -v github.com/projectdiscovery/katana/cmd/katana@latest
   go install -v github.com/s0md3v/Arjun@latest
   ```

3. **Install Python tools**:
   ```bash
   sudo apt install -y python3 python3-pip
   pip3 install LinkFinder JSParser xnLinkFinder
   ```

4. **Create directories**:
   ```bash
   mkdir -p ~/tools
   mkdir -p ~/recon
   ```

5. **Clone LinkFinder** (if not installed via pip):
   ```bash
   git clone https://github.com/GerbenJavado/LinkFinder.git ~/tools/LinkFinder
   cd ~/tools/LinkFinder
   pip3 install -r requirements.txt
   ```

## 📋 Usage

### Before Running

Make sure you have completed the installation steps above. All required tools must be installed and available in your PATH.

### Running the Tool

```bash
./phantom-recon.sh <target-domain>
```

Example:
```bash
./phantom-recon.sh example.com
```

### Output Structure

The tool creates the following directory structure for each target:
```
~/recon/example.com/    # At your home path
├── all_subs.txt               # All discovered subdomains
├── alive_subs.txt             # Live hosts
├── all_urls.txt               # URLs from archives
├── jsfiles.txt                # JavaScript files
├── linkfinder_endpoints.txt   # JS endpoints via LinkFinder
├── jsparser_endpoints.txt     # JSParser output
├── xn_endpoints.txt           # xnLinkFinder output
├── arjun_params.txt           # Parameters discovered
├── final_endpoints.txt        # Merged endpoints list
├── endpoints_with_params.txt  # URLs with parameters
└── recon_summary_YYYYMMDD_HHMMSS.txt  # Summary report
```

## 🛠 Tool Requirements

- **Operating System**: Linux (Kali, Ubuntu, etc.)
- **Memory**: 2GB RAM minimum (4GB recommended)
- **Storage**: 10GB free space
- **Internet**: Stable connection for reconnaissance

### Required Tools

- `subfinder` - Subdomain discovery
- `assetfinder` - Subdomain enumeration
- `httpx` or `httprobe` - HTTP probing
- `gau` - URL collection
- `waybackurls` - Historical URL fetching
- `katana` - Web crawling
- `arjun` - Parameter discovery

### Optional Tools

- `LinkFinder` - JavaScript endpoint extraction
- `JSParser` - JavaScript analysis
- `xnLinkFinder` - Advanced endpoint discovery

## 📸 Screenshots

<p align="center">
  <img src="https://raw.githubusercontent.com/Divakar2006/phantom-recon/img/banner.png" alt="Phantom Recon Banner" width="800">
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Divakar2006/phantom-recon/img/results.png" alt="Results Summary" width="800">
</p>


## ⚠️ Disclaimer

This tool is for educational purposes and authorized security testing only. Users are responsible for obtaining proper authorization before testing any target. The creators are not responsible for any misuse or illegal activity.

## 👨‍💻 Created by Divu

<p align="center">
  <img src="https://raw.githubusercontent.com/divu/phantom-recon/main/assets/creator.png" alt="Created by Divu" width="300">
</p>

<p align="center">
  <b>Cybersecurity Specialist & Tool Developer</b>
</p>

<p align="center">
  <a href="https://github.com/Divakar2006">
    <img src="https://img.shields.io/badge/Github-divu-brightgreen?style=for-the-badge&logo=github">
  </a>

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/Divakar2006">Divu</a>
</p>