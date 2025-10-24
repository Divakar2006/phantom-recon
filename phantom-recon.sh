#!/bin/bash

# Enhanced Recon Automation Tool with Cool Features
# Performs comprehensive reconnaissance on a target domain

set -e

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
ORANGE='\033[0;33m'
PINK='\033[1;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Phantom Recon - Advanced Reconnaissance Suite
show_banner() {
    clear
    echo -e "${CYAN}┌──────────────────────────────────────────────────────────────┐"
    echo -e "│                                                              │"
    echo -e "│${BOLD}${WHITE}           ⚡ P H A N T O M   R E C O N ⚡                    ${NC}${CYAN}│"
    echo -e "│${PURPLE}          Advanced Reconnaissance & Analysis Suite            ${NC}${CYAN}│"
    echo -e "│                                                              │"
    echo -e "│     ${WHITE}[ Target Acquisition ]${NC}${CYAN} ❯ ${ORANGE}[ Asset Discovery ]${NC}${CYAN} ❯ ${GREEN}[ Analysis ]${NC}${CYAN}│"
    echo -e "│                                                              │"
    echo -e "├──────────────────────────────────────────────────────────────┤"
    echo -e "│  ${WHITE}🔍 Subdomain Enumeration     🎯 Parameter Discovery${NC}${CYAN}         │"
    echo -e "│  ${WHITE}⚡ Live Host Detection       🔮 JavaScript Analysis${NC}${CYAN}         │"
    echo -e "│  ${WHITE}🌐 Asset Reconnaissance      🛡️ Vulnerability Scanning${NC}${CYAN}      │"
    echo -e "│                                                              │"
    echo -e "├──────────────────────────────────────────────────────────────┤"
    echo -e "│                                                              │"
    echo -e "│  ${PINK}Created by:${NC} ${WHITE}Divu${NC}${CYAN}                                            │"
    echo -e "│  ${CYAN}Cybersecurity Specialist & Red Team Operator${NC}${CYAN}                │"
    echo -e "│  ${ORANGE}https://github.com/Divakar2006${NC}${CYAN}                              │"
    echo -e "│                                                              │"
    echo -e "└──────────────────────────────────────────────────────────────┘${NC}"
    
    # Animated welcome message
    echo -e "\n${YELLOW}"
    echo "Initializing reconnaissance framework..."
    sleep 0.5
    echo "Loading security modules..."
    sleep 0.5
    echo "Preparing attack surface analysis..."
    sleep 0.5
    echo -e "${GREEN}✓ All systems ready!${NC}"
    echo
}

# Enhanced progress indicator
progress_indicator() {
    local message=$1
    echo -e "\n${YELLOW}┌──────────────────────────────────────┐${NC}"
    echo -e "${YELLOW}│${NC} 🚀 $message"
    echo -e "${YELLOW}└──────────────────────────────────────┘${NC}"
    
    # Improved spinner
    local spinstr='⣾⣽⣻⢿⡿⣟⣯⣷'
    local temp
    echo -n "  "
    for i in {1..15}; do
        temp=${spinstr#?}
        printf " ${CYAN}[%c]${NC} " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep 0.1
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Enhanced section header
section_header() {
    local title="$1"
    local title_length=${#title}
    local padding=$(( (50 - title_length) / 2 ))
    local pad_str=$(printf '%*s' "$padding" '')
    
    echo -e "\n${PURPLE}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
    echo -e "┃${pad_str}${BOLD}${WHITE}$title${NC}${PURPLE}${pad_str}        ┃"
    echo -e "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${NC}"
}

# Enhanced status messages
print_status() {
    echo -e "${BLUE}[♦] ${BOLD}INFO${NC}    ❯ $1"
}

print_success() {
    echo -e "${GREEN}[♦] ${BOLD}SUCCESS${NC} ❯ $1"
}

print_warning() {
    echo -e "${YELLOW}[♦] ${BOLD}WARNING${NC} ❯ $1"
}

print_error() {
    echo -e "${RED}[♦] ${BOLD}ERROR${NC}   ❯ $1"
}

# Check dependencies
check_dependencies() {
    section_header "DEPENDENCY CHECK"
    
    tools=("subfinder" "assetfinder" "gau" "waybackurls" "katana" "arjun")
    missing=()
    
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing+=("$tool")
        fi
    done
    
    # Check for either httpx or httprobe
    if ! command -v "httpx" &> /dev/null && ! command -v "httprobe" &> /dev/null; then
        missing+=("httpx or httprobe")
    fi
    
    if [ ${#missing[@]} -gt 0 ]; then
        print_error "Missing dependencies: ${missing[*]}"
        print_status "Please install missing tools before proceeding"
        exit 1
    fi
    
    # Check for optional tools
    if [ ! -f "$HOME/tools/LinkFinder/linkfinder.py" ]; then
        print_warning "LinkFinder not found. JS endpoint extraction will be limited."
    fi
    
    if [ ! -f "$HOME/tools/JSParser/JSParser.py" ]; then
        print_warning "JSParser not found. JS endpoint extraction will be limited."
    fi
    
    if ! command -v "xnLinkFinder" &> /dev/null; then
        print_warning "xnLinkFinder not found. JS endpoint extraction will be limited."
    fi
    
    print_success "All required dependencies are available"
}

# Setup directories
setup_directories() {
    section_header "INITIALIZATION"
    
    TARGET=$1
    RECON_DIR="$HOME/recon/$TARGET"
    
    if [ -d "$RECON_DIR" ]; then
        print_warning "Directory $RECON_DIR already exists. Continuing with existing directory."
    else
        mkdir -p "$RECON_DIR"
        print_success "Created workspace: $RECON_DIR"
    fi
    
    cd "$RECON_DIR"
    print_status "Working directory set to: $(pwd)"
}

# Subdomain enumeration
subdomain_enum() {
    section_header "SUBDOMAIN ENUMERATION"
    
    print_status "Running subfinder..."
    subfinder -d "$TARGET" -silent -o subfinder.txt
    
    print_status "Running assetfinder..."
    assetfinder --subs-only "$TARGET" > assetfinder.txt
    
    print_status "Combining and sorting results..."
    cat subfinder.txt assetfinder.txt | sort -u > all_subs.txt
    
    SUBDOMAIN_COUNT=$(wc -l < all_subs.txt)
    print_success "Discovered $SUBDOMAIN_COUNT unique subdomains"
    
    # Show top 5 subdomains
    echo -e "\n${CYAN}Top 5 subdomains:${NC}"
    head -n 5 all_subs.txt | nl
}

# Live host discovery
live_host_discovery() {
    section_header "LIVE HOST DISCOVERY"
    
    # Check if httpx is available and supports long-form flags
    if command -v "httpx" &> /dev/null; then
        print_status "Probing for live hosts with httpx..."
        # Try with long-form flags first
        if cat all_subs.txt | httpx --silent --status-code --title --tech-detect -o alive_subs.txt 2>/dev/null; then
            print_success "httpx with long-form flags worked"
        else
            # Fallback to basic httpx
            print_warning "httpx long-form flags failed, trying basic mode"
            cat all_subs.txt | httpx -o alive_subs.txt
        fi
    elif command -v "httprobe" &> /dev/null; then
        print_status "Probing for live hosts with httprobe..."
        cat all_subs.txt | httprobe -c 50 > alive_subs.txt
    else
        print_error "Neither httpx nor httprobe is available"
        exit 1
    fi
    
    ALIVE_COUNT=$(wc -l < alive_subs.txt)
    print_success "Found $ALIVE_COUNT live hosts"
    
    # Show top 5 live hosts
    echo -e "\n${CYAN}Top 5 live hosts:${NC}"
    head -n 5 alive_subs.txt | awk '{print $1}' | nl
}

# URL collection
url_collection() {
    section_header "URL COLLECTION"
    
    print_status "Fetching URLs with GAU..."
    cat alive_subs.txt | awk '{print $1}' | gau --threads 50 --blacklist png,jpg,gif,svg > gau_urls.txt
    
    print_status "Fetching URLs with Wayback Machine..."
    cat alive_subs.txt | awk '{print $1}' | waybackurls > wayback.txt
    
    print_status "Crawling with Katana..."
    katana -list alive_subs.txt -d 5 -js-crawl -o katana_urls.txt
    
    print_status "Combining and sorting results..."
    cat gau_urls.txt wayback.txt katana_urls.txt | sort -u > all_urls.txt
    
    URL_COUNT=$(wc -l < all_urls.txt)
    print_success "Collected $URL_COUNT unique URLs"
    
    # Show URL statistics
    echo -e "\n${CYAN}URL Statistics:${NC}"
    echo "• GAU URLs: $(wc -l < gau_urls.txt)"
    echo "• Wayback URLs: $(wc -l < wayback.txt)"
    echo "• Katana URLs: $(wc -l < katana_urls.txt)"
}

# JS endpoint extraction
js_endpoint_extraction() {
    section_header "JAVASCRIPT ANALYSIS"
    
    print_status "Extracting JavaScript files..."
    cat all_urls.txt | grep -Ei "\.js$" | sort -u > jsfiles.txt
    
    JS_COUNT=$(wc -l < jsfiles.txt)
    print_success "Found $JS_COUNT JavaScript files"
    
    # LinkFinder
    if [ -f "$HOME/tools/LinkFinder/linkfinder.py" ]; then
        print_status "Running LinkFinder..."
        python3 "$HOME/tools/LinkFinder/linkfinder.py" -i jsfiles.txt -o cli > linkfinder_endpoints.txt
    fi
    
    # JSParser
    if [ -f "$HOME/tools/JSParser/JSParser.py" ]; then
        print_status "Running JSParser..."
        cat jsfiles.txt | while read url; do 
            python3 "$HOME/tools/JSParser/JSParser.py -u \"$url\"" 
        done > jsparser_endpoints.txt
    fi
    
    # xnLinkFinder
    if command -v "xnLinkFinder" &> /dev/null; then
        print_status "Running xnLinkFinder..."
        cat jsfiles.txt | xnLinkFinder -stdin -o xn_endpoints.txt
    fi
}

# Parameter discovery
parameter_discovery() {
    section_header "PARAMETER DISCOVERY"
    
    print_status "Preparing URLs for parameter discovery..."
    cat all_urls.txt | grep "=" | cut -d "=" -f1 | sort -u > urls_for_arjun.txt
    
    print_status "Running Arjun for parameter discovery..."
    arjun -i urls_for_arjun.txt -t 50 -oT arjun_params.txt
    
    PARAM_COUNT=$(wc -l < arjun_params.txt)
    print_success "Discovered $PARAM_COUNT parameters"
    
    # Show top 5 parameters
    echo -e "\n${CYAN}Top 5 discovered parameters:${NC}"
    head -n 5 arjun_params.txt | nl
}

# Cleanup and merge
cleanup_and_merge() {
    section_header "RESULTS AGGREGATION"
    
    print_status "Merging all endpoints..."
    cat linkfinder_endpoints.txt jsparser_endpoints.txt xn_endpoints.txt arjun_params.txt 2>/dev/null | sort -u > final_endpoints.txt
    
    print_status "Filtering endpoints with parameters..."
    cat final_endpoints.txt | grep "=" > endpoints_with_params.txt
    
    ENDPOINT_COUNT=$(wc -l < final_endpoints.txt)
    PARAM_ENDPOINT_COUNT=$(wc -l < endpoints_with_params.txt)
    
    print_success "Merged $ENDPOINT_COUNT unique endpoints"
    print_success "Found $PARAM_ENDPOINT_COUNT endpoints with parameters"
}

# Generate report
generate_report() {
    section_header "REPORT GENERATION"
    
    REPORT_FILE="recon_summary_$(date +%Y%m%d_%H%M%S).txt"
    
    {
        echo "╔══════════════════════════════════════════════════════════════╗"
        echo "║                    RECONNAISSANCE SUMMARY                     ║"
        echo "╠══════════════════════════════════════════════════════════════╣"
        echo "║ Target: $TARGET"
        echo "║ Date: $(date)"
        echo "║ Duration: $DURATION seconds"
        echo "╠══════════════════════════════════════════════════════════════╣"
        echo "║ Subdomains Found: $(wc -l < all_subs.txt)"
        echo "║ Live Hosts: $(wc -l < alive_subs.txt)"
        echo "║ URLs Collected: $(wc -l < all_urls.txt)"
        echo "║ JavaScript Files: $(wc -l < jsfiles.txt)"
        echo "║ Endpoints Discovered: $(wc -l < final_endpoints.txt)"
        echo "║ Endpoints with Parameters: $(wc -l < endpoints_with_params.txt)"
        echo "╚══════════════════════════════════════════════════════════════╝"
        echo ""
        echo "TOP SUBDOMAINS:"
        head -n 10 all_subs.txt | nl
        echo ""
        echo "TOP LIVE HOSTS:"
        head -n 10 alive_subs.txt | awk '{print $1}' | nl
        echo ""
        echo "TOP ENDPOINTS:"
        head -n 10 final_endpoints.txt | nl
        echo ""
        echo "========================================"
        echo "Report generated by Reconnaissance Automator"
        echo "Created by Divu - Cybersecurity Specialist"
        echo "========================================"
    } > "$REPORT_FILE"
    
    print_success "Report saved to: $REPORT_FILE"
}

# Final summary with creator signature
show_summary() {
    section_header "MISSION COMPLETE"
    
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗"
    echo -e "║                   RECONNAISSANCE COMPLETED                   ║"
    echo -e "╠══════════════════════════════════════════════════════════════╣"
    echo -e "║ Target: ${CYAN}$TARGET${NC}${GREEN}                                          ║"
    echo -e "║ Duration: ${CYAN}$DURATION seconds${NC}${GREEN}                                   ║"
    echo -e "║ Results: ${CYAN}$HOME/recon/$TARGET${NC}${GREEN}                                 ║"
    echo -e "╚══════════════════════════════════════════════════════════════╝${NC}"
    
    echo -e "\n${YELLOW}Key Findings:${NC}"
    echo "• Subdomains: $(wc -l < all_subs.txt)"
    echo "• Live Hosts: $(wc -l < alive_subs.txt)"
    echo "• URLs: $(wc -l < all_urls.txt)"
    echo "• Endpoints: $(wc -l < final_endpoints.txt)"
    echo "• Parameters: $(wc -l < endpoints_with_params.txt)"
    
    echo -e "\n${BLUE}Next Steps:${NC}"
    echo "1. Review endpoints_with_params.txt for potential vulnerabilities"
    echo "2. Analyze JavaScript files for sensitive information"
    echo "3. Test live hosts for common vulnerabilities"
    echo "4. Check for subdomain takeovers"
    
    # Creator signature
    echo -e "\n${PINK}╔══════════════════════════════════════════════════════════════╗"
    echo -e "║  ${BOLD}TOOL CREATED BY${NC}${PINK}                                          ║"
    echo -e "║                                                              ║"
    echo -e "║  ${GREEN}████  ████  █████  ███   ███  ████████ ███████ ████████  ║"
    echo -e "║  ${GREEN}█   █ █   █ █   ██ █  █ █  █    █    █     ██    ██   ║"
    echo -e "║  ${GREEN}████  ████  ██████ █   █   █    █    █████ ██████    ║"
    echo -e "║  ${GREEN}█   █ █   █ █   ██ █       █    █    █     ██   ██   ║"
    echo -e "║  ${GREEN}████  █   █ █   ██ █       █    █    ███████ ██   ██   ║"
    echo -e "║                                                              ║"
    echo -e "║  ${CYAN}Cybersecurity Specialist & Tool Developer${NC}${PINK}              ║"
    echo -e "║  ${ORANGE}github.com/divu${NC}${PINK}                                      ║"
    echo -e "╚══════════════════════════════════════════════════════════════╝${NC}"
    
    echo -e "\n${YELLOW}Thank you for using ${BOLD}Reconnaissance Automator${NC}${YELLOW}!${NC}"
    echo -e "${CYAN}Stay curious, stay secure! 🔒${NC}"
}

# Main function
main() {
    if [ -z "$1" ]; then
        print_error "No target specified. Usage: $0 <target-domain>"
        exit 1
    fi
    
    TARGET=$1
    START_TIME=$(date +%s)
    
    show_banner
    check_dependencies
    setup_directories "$TARGET"
    
    progress_indicator "Subdomain Enumeration"
    subdomain_enum
    
    progress_indicator "Live Host Discovery"
    live_host_discovery
    
    progress_indicator "URL Collection"
    url_collection
    
    progress_indicator "JavaScript Analysis"
    js_endpoint_extraction
    
    progress_indicator "Parameter Discovery"
    parameter_discovery
    
    progress_indicator "Results Aggregation"
    cleanup_and_merge
    
    generate_report
    
    END_TIME=$(date +%s)
    DURATION=$((END_TIME - START_TIME))
    
    show_summary
}

# Execute main function
main "$@"