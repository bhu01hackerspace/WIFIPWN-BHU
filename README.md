# 🔒 WIFIPWN-BHU v.4.0f - PenTest Framework

<p align="center">
  <img src="https://img.shields.io/badge/Version-4.0f-red?style=for-the-badge&logo=github"/>
  <img src="https://img.shields.io/badge/License-MIT%20with%20Ethics-blue?style=for-the-badge&logo=opensourceinitiative"/>
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Termux%20%7C%20BlackArch%20%7C%20Kali-green?style=for-the-badge&logo=linux"/>
  <img src="https://img.shields.io/badge/Purpose-Educational%20Only-orange?style=for-the-badge&logo=bookstack"/>
</p>

<p align="center">
  <b>⚠️ FERRAMENTA EDUCACIONAL PARA PROFISSIONAIS DE SEGURANÇA ⚠️</b><br>
  <i>Use apenas em redes autorizadas. O uso não autorizado é CRIME (Art. 154-A do Código Penal)</i>
</p>

---

## 🎯 Sobre

**WIFIPWN-BHU** é um framework profissional de auditoria de segurança para redes WiFi públicas e privadas. Desenvolvido para profissionais de segurança cibernética, o sistema automatiza o processo de identificação de vulnerabilidades em dispositivos conectados à rede local, com foco especial em:

- 🔍 Dispositivos IoT vulneráveis
- 📷 Câmeras IP com senhas padrão
- 🏭 Equipamentos Intel Bras, Hikvision, TP-Link
- 🔐 Credenciais fracas ou padrão
- 🌐 Serviços expostos indevidamente

> **💡 Filosofia:** Conhecimento é poder, mas responsabilidade é obrigação. Esta ferramenta existe para ENSINAR e PROTEGER, não para atacar.

---

## ⚡ Funcionalidades

### 🔍 Módulos de Reconhecimento

| Módulo | Descrição | Status |
|--------|-----------|--------|
| **Scan Completo de Rede** | ARP scan + Nmap para descobrir todos dispositivos ativos | ✅ |
| **Scan de Portas** | Varredura de 30+ portas comuns e serviços | ✅ |
| **Identificação por MAC** | Detecção de fabricante via endereço MAC | ✅ |
| **Mapeamento de Rede** | Traceroute e topologia de rede | 🚧 |

### 🚨 Módulos de Ataque e Exploração

| Módulo | Descrição | Status |
|--------|-----------|--------|
| **Teste de Senhas Padrão** | 200+ combinações de credenciais de fábrica | ✅ |
| **Ataque MITM** | ARP Spoofing + DNS Spoofing | 🚧 |
| **Deauth Attack** | Desconexão forçada de dispositivos WiFi | 🚧 |
| **Captura de Handshake** | Coleta de handshake WPA2/WPA3 | 🚧 |
| **Cracking de Senhas** | Online (Hydra) + Offline (John) | 🚧 |
| **Auto Exploit** | Searchsploit + CVE database | 🚧 |

### 📡 Módulos IoT Específicos

| Módulo | Descrição | Status |
|--------|-----------|--------|
| **Scanner de Câmeras IP** | Detecção RTSP + HTTP de câmeras | ✅ |
| **Intel Bras Detector** | Identificação e exploração de equipamentos Intel Bras | ✅ |
| **Hikvision Hunter** | Scanner específico para câmeras Hikvision | ✅ |
| **Smart TV Hunter** | Detecção de TVs via UPNP/DLNA | 🚧 |
| **Printer Scanner** | Identificação de impressoras vulneráveis | 🚧 |

### 📊 Módulos de Relatório

| Módulo | Descrição | Status |
|--------|-----------|--------|
| **Relatório HTML** | Relatório detalhado com formatação profissional | ✅ |
| **Relatório PDF** | Versão PDF para compartilhamento | ✅ |
| **Exportação CSV** | Dados brutos para análise externa | ✅ |
| **Screenshots Auto** | Captura automática de painéis web | ✅ |
| **Evidências Forenses** | Coleta de provas para auditoria | ✅ |

### ⚡ Módulos Avançados

| Módulo | Descrição | Status |
|--------|-----------|--------|
| **Ataque Automático** | Execução de todas as fases em sequência | ✅ |
| **Evasão de Detecção** | MAC Changer + Proxy + Delay | 🚧 |
| **Reverse Shell** | Obtenção de acesso remoto | 🚧 |
| **Persistência** | Instalação de backdoor em dispositivos | 🚧 |

---

## 📸 Demonstração

```bash
┌─────────────────────────────────────────────────────────────┐
│  🎯 WIFIPWN-BHU v.4.0f - Menu Principal                     │
├─────────────────────────────────────────────────────────────┤
│  1) Scan Completo de Rede                                   │
│  2) Scan de Portas e Serviços                               │
│  5) Teste de Senhas Padrão (200+ combos)                   │
│  11) Scanner de Câmeras IP                                  │
│  12) Detecção Intel Bras/Hikvision                         │
│  15) Gerar Relatório Detalhado                             │
│  19) ATAQUE AUTOMÁTICO COMPLETO                            │
│  0) Sair                                                    │
└─────────────────────────────────────────────────────────────┘

👉 Escolha uma opção: 19

[+] Iniciando sequência de ataque automatizado...
[1/7] Realizando descoberta de rede...
[+] Encontrados 12 dispositivos ativos

[2/7] Escaneando portas e serviços...
[!] CÂMERA RTSP detectada em 192.168.1.105:554
[!] Painel Web detectado em 192.168.1.1:80

[5/7] Testando senhas padrão...
🔓 CREDENCIAL VÁLIDA: admin:admin em 192.168.1.1

[7/7] Gerando relatório final...
✅ Relatório gerado: wifipwn_bhu_20260329_143022/relatorio_completo.html
```

## 🔧 Personalização

Você pode modificar o script para:

- Adicionar novos scripts NSE
- Personalizar timing padrão
- Configurar diretório de logs
- Adicionar integração com outras ferramentas

🤝 Contribuições

Contribuições são bem-vindas! Por favor, leia o CONTRIBUTING.md para detalhes.

📄 Licença

Este projeto está sob a licença MIT - veja o arquivo LICENSE para detalhes.

👤 Autor

· GitHub: @bhu01hackerspace

⚠️ Aviso Legal

Esta ferramenta deve ser usada APENAS em sistemas autorizados. O uso não autorizado é estritamente proibido e pode violar leis locais. O autor não se responsabiliza por uso indevido.

🌟 Suporte

Se este projeto ajudou você, considere dar uma ⭐️ no GitHub!

---

Feito com ❤️ para a comunidade de segurança
