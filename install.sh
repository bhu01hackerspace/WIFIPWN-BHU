#!/bin/bash
# ==============================================
# install.sh - Instalador do WIFIPWN-BHU v.4.0f
# ==============================================
# Uso: chmod +x install.sh && ./install.sh
# ==============================================

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Banner
show_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗                                                             ║
║                    INSTALADOR AUTOMÁTICO                      ║
║                          v.4.0f                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo ""
}

# Detectar sistema operacional
detect_os() {
    echo -e "${BLUE}[*] Detectando sistema operacional...${NC}"
    
    if [[ "$OSTYPE" == "linux-android"* ]] || [[ -d "/data/data/com.termux" ]]; then
        OS="termux"
        echo -e "${GREEN}[+] Termux detectado${NC}"
    elif command -v pacman &> /dev/null; then
        OS="arch"
        echo -e "${GREEN}[+] Arch Linux/BlackArch detectado${NC}"
    elif command -v apt &> /dev/null; then
        OS="debian"
        echo -e "${GREEN}[+] Debian/Ubuntu/Kali detectado${NC}"
    else
        OS="unknown"
        echo -e "${RED}[!] Sistema não suportado para instalação automática${NC}"
    fi
}

# Instalar no Termux
install_termux() {
    echo -e "${BLUE}[*] Instalando para Termux...${NC}"
    
    # Atualizar pacotes
    echo -e "${YELLOW}[→] Atualizando repositórios...${NC}"
    pkg update && pkg upgrade -y
    
    # Instalar root-repo
    echo -e "${YELLOW}[→] Instalando root-repo...${NC}"
    pkg install root-repo -y
    
    # Instalar dependências
    echo -e "${YELLOW}[→] Instalando dependências...${NC}"
    pkg install -y \
        arp-scan \
        nmap \
        curl \
        netcat-openbsd \
        grep \
        sed \
        awk \
        jq \
        tsu \
        termux-api
    
    # Permissões extras
    echo -e "${YELLOW}[→] Configurando permissões...${NC}"
    chmod +x wifipwn-bhu.sh
    
    echo -e "${GREEN}[+] Instalação Termux concluída!${NC}"
}

# Instalar no Arch/BlackArch
install_arch() {
    echo -e "${BLUE}[*] Instalando para Arch Linux/BlackArch...${NC}"
    
    # Atualizar sistema
    echo -e "${YELLOW}[→] Atualizando repositórios...${NC}"
    sudo pacman -Syu --noconfirm
    
    # Instalar dependências
    echo -e "${YELLOW}[→] Instalando dependências...${NC}"
    sudo pacman -S --noconfirm \
        arp-scan \
        nmap \
        curl \
        netcat \
        aircrack-ng \
        hydra \
        john \
        macchanger \
        ettercap \
        dsniff \
        cutycapt \
        wkhtmltopdf \
        ffmpeg \
        tcpdump \
        wireshark-cli
    
    # Instalar ferramentas adicionais do BlackArch
    if [[ -f /usr/bin/blackarch-install ]]; then
        echo -e "${YELLOW}[→] Instalando ferramentas BlackArch...${NC}"
        sudo blackarch-install -y nmap arp-scan aircrack-ng hydra john ettercap
    fi
    
    echo -e "${GREEN}[+] Instalação Arch/BlackArch concluída!${NC}"
}

# Instalar no Debian/Ubuntu/Kali
install_debian() {
    echo -e "${BLUE}[*] Instalando para Debian/Ubuntu/Kali...${NC}"
    
    # Atualizar repositórios
    echo -e "${YELLOW}[→] Atualizando repositórios...${NC}"
    sudo apt update
    
    # Atualizar sistema
    echo -e "${YELLOW}[→] Atualizando sistema...${NC}"
    sudo apt upgrade -y
    
    # Instalar dependências principais
    echo -e "${YELLOW}[→] Instalando dependências principais...${NC}"
    sudo apt install -y \
        arp-scan \
        nmap \
        curl \
        netcat-openbsd \
        grep \
        sed \
        awk \
        jq \
        build-essential
    
    # Instalar ferramentas de ataque (opcionais)
    echo -e "${YELLOW}[→] Instalando ferramentas avançadas (pode demorar)...${NC}"
    echo -e "${CYAN}Deseja instalar ferramentas avançadas? (s/N)${NC}"
    read -r install_advanced
    
    if [[ "$install_advanced" =~ ^[Ss]$ ]]; then
        sudo apt install -y \
            aircrack-ng \
            hydra \
            john \
            macchanger \
            ettercap \
            ettercap-graphical \
            dsniff \
            tcpdump \
            wireshark \
            cutycapt \
            wkhtmltopdf \
            ffmpeg
    else
        echo -e "${YELLOW}[→] Pulando ferramentas avançadas...${NC}"
    fi
    
    echo -e "${GREEN}[+] Instalação Debian/Ubuntu/Kali concluída!${NC}"
}

# Verificar instalação
verify_installation() {
    echo ""
    echo -e "${BLUE}[*] Verificando instalação...${NC}"
    echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
    
    local missing=()
    local installed=()
    
    # Lista de comandos para verificar
    commands=("arp-scan" "nmap" "curl" "nc")
    
    for cmd in "${commands[@]}"; do
        if command -v $cmd &> /dev/null; then
            echo -e "${GREEN}✅ $cmd - Instalado${NC}"
            installed+=($cmd)
        else
            echo -e "${RED}❌ $cmd - Não encontrado${NC}"
            missing+=($cmd)
        fi
    done
    
    echo -e "${CYAN}─────────────────────────────────────────────────${NC}"
    
    if [ ${#missing} -eq 0 ]; then
        echo -e "${GREEN}✅ Todas as dependências essenciais estão instaladas!${NC}"
    else
        echo -e "${YELLOW}⚠️ Dependências faltando: ${missing[*]}${NC}"
        echo -e "${YELLOW}Execute novamente o instalador ou instale manualmente${NC}"
    fi
}

# Clonar repositório (se não estiver dentro dele)
clone_repo() {
    if [[ ! -f "wifipwn-bhu.sh" ]]; then
        echo -e "${BLUE}[*] Clonando repositório...${NC}"
        git clone https://github.com/bhu01hackerspace/WIFIPWN-BHU.git
        cd WIFIPWN-BHU
        echo -e "${GREEN}[+] Repositório clonado com sucesso!${NC}"
    else
        echo -e "${GREEN}[+] Já está no diretório do repositório${NC}"
    fi
}

# Dar permissão ao script
set_permissions() {
    echo -e "${BLUE}[*] Configurando permissões...${NC}"
    chmod +x wifipwn-bhu.sh 2>/dev/null
    chmod +x install.sh 2>/dev/null
    echo -e "${GREEN}[+] Permissões configuradas${NC}"
}

# Menu de seleção de instalação
installation_menu() {
    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                    🚀 MODO DE INSTALAÇÃO                       ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${GREEN}1) Instalação COMPLETA (Todas as ferramentas)${NC}"
    echo -e "${YELLOW}2) Instalação BÁSICA (Apenas essenciais)${NC}"
    echo -e "${BLUE}3) Apenas verificar dependências${NC}"
    echo -e "${RED}0) Sair${NC}"
    echo ""
    echo -ne "${BOLD}👉 Escolha uma opção: ${NC}"
    read -r install_option
    
    case $install_option in
        1)
            echo -e "${GREEN}[+] Modo COMPLETO selecionado${NC}"
            install_advanced_flag=true
            ;;
        2)
            echo -e "${YELLOW}[+] Modo BÁSICO selecionado${NC}"
            install_advanced_flag=false
            ;;
        3)
            verify_installation
            exit 0
            ;;
        0)
            echo -e "${RED}[!] Instalação cancelada${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}[!] Opção inválida. Usando modo BÁSICO.${NC}"
            install_advanced_flag=false
            ;;
    esac
}

# Resumo final
show_summary() {
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                    ✅ INSTALAÇÃO CONCLUÍDA                     ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}📁 Diretório: $(pwd)${NC}"
    echo -e "${CYAN}📄 Script principal: wifipwn-bhu.sh${NC}"
    echo ""
    echo -e "${YELLOW}🚀 Para executar:${NC}"
    echo -e "   ${BOLD}sudo ./wifipwn-bhu.sh${NC}"
    echo ""
    echo -e "${YELLOW}📖 Para ajuda:${NC}"
    echo -e "   ${BOLD}cat README.md${NC}"
    echo ""
    echo -e "${RED}⚠️  LEMBRE-SE: Use apenas em redes autorizadas!${NC}"
    echo ""
}

# ==============================================
# MAIN
# ==============================================
main() {
    show_banner
    
    # Verificar se é root (opcional, só avisa)
    if [ "$EUID" -eq 0 ]; then
        echo -e "${YELLOW}⚠️  Executando como root. Continuando...${NC}"
    else
        echo -e "${CYAN}ℹ️  Executando como usuário normal. Alguns comandos podem pedir sudo.${NC}"
    fi
    
    echo ""
    detect_os
    
    case $OS in
        termux)
            installation_menu
            install_termux
            set_permissions
            verify_installation
            show_summary
            ;;
        arch)
            installation_menu
            install_arch
            set_permissions
            verify_installation
            show_summary
            ;;
        debian)
            installation_menu
            install_debian
            set_permissions
            verify_installation
            show_summary
            ;;
        unknown)
            echo -e "${RED}[!] Sistema não suportado para instalação automática${NC}"
            echo -e "${YELLOW}Por favor, instale as dependências manualmente:${NC}"
            echo -e "  - arp-scan"
            echo -e "  - nmap"
            echo -e "  - curl"
            echo -e "  - netcat"
            exit 1
            ;;
    esac
}

# Executar
main
