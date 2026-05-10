#!/bin/bash

# ╔══════════════════════════════════════════════╗
# ║       🇹🇲 TM BEGO — Awtomatik Gurnamak       ║
# ║     Professional VPN Dolandyryş Paneli       ║
# ╚══════════════════════════════════════════════╝

set -e

# ── Reňkler ──
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# ── Nyşanlar ──
CHECK="✅"
CROSS="❌"
ARROW="➜"
STAR="⭐"
WARN="⚠️"

# ── Wersiýa ──
VERSION="0.8.4"
INSTALL_DIR="/opt/tmbego"
COMPOSE_FILE="docker-compose.yml"

# ══════════════════════════════════════════
# FUNKSIÝALAR
# ══════════════════════════════════════════

print_banner() {
    echo ""
    echo -e "${GREEN}"
    echo "  ╔══════════════════════════════════════════╗"
    echo "  ║                                          ║"
    echo "  ║     🇹🇲  TM BEGO VPN Panel  🇹🇲            ║"
    echo "  ║     Professional Dolandyryş Paneli       ║"
    echo "  ║     Wersiýa: ${VERSION}                       ║"
    echo "  ║                                          ║"
    echo "  ╚══════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

log_info() {
    echo -e "${BLUE}${ARROW}${NC} $1"
}

log_success() {
    echo -e "${GREEN}${CHECK}${NC} $1"
}

log_error() {
    echo -e "${RED}${CROSS}${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}${WARN}${NC} $1"
}

# ── Root barlagy ──
check_root() {
    if [ "$EUID" -ne 0 ]; then
        log_error "Bu skripti root hökmünde işlediň! (sudo bash install.sh)"
        exit 1
    fi
    log_success "Root ygtyýarlygy barlandy"
}

# ── OS barlagy ──
check_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
        log_success "Ulgam: ${OS} ${VER}"
    else
        log_warn "Ulgam kesgitlenip bilinmedi, dowam edilýär..."
    fi
}

# ── Docker gurnamak ──
install_docker() {
    if command -v docker &> /dev/null; then
        DOCKER_VER=$(docker --version | awk '{print $3}' | tr -d ',')
        log_success "Docker eýýäm gurnalypdyr: ${DOCKER_VER}"
    else
        log_info "Docker gurnalyar..."
        curl -fsSL https://get.docker.com | sh
        systemctl enable docker
        systemctl start docker
        log_success "Docker üstünlikli gurnalydy"
    fi
}

# ── Docker Compose barlagy ──
install_docker_compose() {
    if docker compose version &> /dev/null; then
        COMPOSE_VER=$(docker compose version --short)
        log_success "Docker Compose eýýäm bar: ${COMPOSE_VER}"
    elif command -v docker-compose &> /dev/null; then
        COMPOSE_VER=$(docker-compose --version | awk '{print $3}' | tr -d ',')
        log_success "Docker Compose (standalone) bar: ${COMPOSE_VER}"
        COMPOSE_FILE="docker-compose"
    else
        log_info "Docker Compose gurnalyar..."
        apt-get install -y docker-compose-plugin 2>/dev/null || {
            curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            chmod +x /usr/local/bin/docker-compose
        }
        log_success "Docker Compose üstünlikli gurnalydy"
    fi
}

# ── Zerur paketler ──
install_dependencies() {
    log_info "Zerur paketler gurnalyar..."
    apt-get update -qq
    apt-get install -y -qq curl git jq > /dev/null 2>&1
    log_success "Zerur paketler gurnalydy"
}

# ── Proýekti klonlamak / ýenilemek ──
setup_project() {
    if [ -d "$INSTALL_DIR" ]; then
        log_info "Öňki gurama tapyldy, ýenilenýär..."
        cd "$INSTALL_DIR"
        git pull origin master 2>/dev/null || true
    else
        log_info "Proýekt klonlanýar..."
        git clone https://github.com/tmbego/tmbego-panel.git "$INSTALL_DIR"
        cd "$INSTALL_DIR"
    fi
    log_success "Proýekt faýllary taýýar: ${INSTALL_DIR}"
}

# ── .env faýlyny döretmek ──
setup_env() {
    echo ""
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}  ${STAR} Sazlamalary giriziň  ${STAR}${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Sudo Admin
    read -p "$(echo -e ${CYAN}${ARROW}${NC} Sudo admin ady [admin]: )" SUDO_USER
    SUDO_USER=${SUDO_USER:-admin}

    # Parol
    while true; do
        read -s -p "$(echo -e ${CYAN}${ARROW}${NC} Sudo admin paroly: )" SUDO_PASS
        echo ""
        if [ -z "$SUDO_PASS" ]; then
            log_warn "Parol boş bolup bilmez!"
        elif [ ${#SUDO_PASS} -lt 6 ]; then
            log_warn "Parol azyndan 6 simwol bolmaly!"
        else
            break
        fi
    done

    # Telegram (islege görä)
    echo ""
    read -p "$(echo -e ${CYAN}${ARROW}${NC} Telegram Bot Token [boş goýup bilersiňiz]: )" TG_TOKEN
    read -p "$(echo -e ${CYAN}${ARROW}${NC} Telegram Admin ID [boş goýup bilersiňiz]: )" TG_ADMIN_ID

    # Port
    read -p "$(echo -e ${CYAN}${ARROW}${NC} Dashboard porty [8000]: )" PANEL_PORT
    PANEL_PORT=${PANEL_PORT:-8000}

    # .env faýlyny ýazmak
    cat > .env << ENVEOF
# TM BEGO — Ulgam Sazlamalary
# Döredilen wagt: $(date '+%Y-%m-%d %H:%M:%S')

# ── Baş dolandyryjy ──
SUDO_USERNAME=${SUDO_USER}
SUDO_PASSWORD=${SUDO_PASS}

# ── Serwer ──
UVICORN_HOST=0.0.0.0
UVICORN_PORT=${PANEL_PORT}

# ── Maglumat bazasy ──
SQLALCHEMY_DATABASE_URL=sqlite:///db.sqlite3

# ── Telegram (hökmany däl) ──
TELEGRAM_API_TOKEN=${TG_TOKEN}
TELEGRAM_ADMIN_ID=${TG_ADMIN_ID}

# ── Google Drive (hökmany däl) ──
GOOGLE_DRIVE_CREDENTIALS_PATH=./data/credentials.json
GOOGLE_DRIVE_FOLDER=TM_BEGO_Backups

# ── Howpsuzlyk ──
DOCS=true
XRAY_SUBSCRIPTION_PATH=sub

# ── Goşmaça ──
CUSTOM_TEMPLATES_DIRECTORY=/var/lib/marzban/templates/
XRAY_SUBSCRIPTION_URL_PREFIX=
ENVEOF

    log_success ".env faýly döredildi"
}

# ── Data katalogyny döretmek ──
setup_data_dir() {
    mkdir -p data
    mkdir -p data/temp
    log_success "Data katalogy döredildi"
}

# ── Docker Compose bilen başlamak ──
start_services() {
    echo ""
    log_info "Hyzmatlar başladylýar..."
    
    if docker compose version &> /dev/null; then
        docker compose up -d --build
    else
        docker-compose up -d --build
    fi

    log_success "Hyzmatlar üstünlikli başladyldy!"
}

# ── Netije ──
print_result() {
    # Serweriň IP adresini almak
    SERVER_IP=$(curl -s -4 ifconfig.me 2>/dev/null || curl -s -4 icanhazip.com 2>/dev/null || echo "SERVER_IP")

    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}  ${CHECK} TM BEGO üstünlikli gurnalydy! ${CHECK}${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  ${CYAN}${ARROW}${NC} Dashboard:  ${WHITE}http://${SERVER_IP}:${PANEL_PORT}/dashboard/${NC}"
    echo -e "  ${CYAN}${ARROW}${NC} API Docs:   ${WHITE}http://${SERVER_IP}:${PANEL_PORT}/docs${NC}"
    echo -e "  ${CYAN}${ARROW}${NC} Admin:      ${WHITE}${SUDO_USER}${NC}"
    echo -e "  ${CYAN}${ARROW}${NC} Katalog:    ${WHITE}${INSTALL_DIR}${NC}"
    echo ""
    echo -e "  ${YELLOW}Peýdaly buýruklar:${NC}"
    echo -e "    ${ARROW} Loglary görmek:    ${WHITE}cd ${INSTALL_DIR} && docker compose logs -f${NC}"
    echo -e "    ${ARROW} Täzeden başlamak:  ${WHITE}cd ${INSTALL_DIR} && docker compose restart${NC}"
    echo -e "    ${ARROW} Ýenilemek:         ${WHITE}cd ${INSTALL_DIR} && git pull && docker compose up -d --build${NC}"
    echo -e "    ${ARROW} Durdurmak:         ${WHITE}cd ${INSTALL_DIR} && docker compose down${NC}"
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${PURPLE}  🇹🇲 TM BEGO — Professional VPN Dolandyryş Paneli 🇹🇲${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# ══════════════════════════════════════════
# BAŞ FUNKSIÝA
# ══════════════════════════════════════════

main() {
    print_banner
    check_root
    check_os
    install_dependencies
    install_docker
    install_docker_compose
    setup_project
    setup_env
    setup_data_dir
    start_services
    print_result
}

main "$@"
