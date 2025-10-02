#!/bin/bash

# Nama direktori tempat file .desktop akan disimpan
DIR_NAME="leakos_real_tools"

# Membuat direktori kerja dan masuk ke dalamnya
mkdir -p "$DIR_NAME"
cd "$DIR_NAME"

echo "Membuat direktori kerja: $DIR_NAME"
echo "Membuat file *.desktop untuk alat keamanan dan umum di LEAKOS..."

# Fungsi untuk membuat file .desktop
create_desktop_file() {
    FILE_NAME="$1"
    NAME="$2"
    COMMENT="$3"
    EXEC_CMD="$4"
    ICON="$5"
    CATEGORY="$6"

    cat > "$FILE_NAME" << EOF
[Desktop Entry]
Name=$NAME
Comment=$COMMENT
Exec=$EXEC_CMD
Icon=$ICON
Terminal=true
Type=Application
Categories=LEAKOS-$CATEGORY;
EOF
}

# -----------------------------------------------------------
# ALAT PENTEST (13 KATEGORI)
# -----------------------------------------------------------

# 1. Intelligent Gathering
create_desktop_file \
    "nmap.desktop" \
    "Nmap" \
    "Network exploration tool and security scanner." \
    "xterm -e nmap" \
    "nmap" \
    "intelligent-gather"
echo "  - nmap.desktop (IG) Selesai"

# 2. Vulnerability Assessment
create_desktop_file \
    "burpsuite.desktop" \
    "Burp Suite Community Edition" \
    "Platform for testing web application security." \
    "/usr/bin/burpsuite" \
    "burpsuite" \
    "vuln-assess"
echo "  - burpsuite.desktop (VA) Selesai"

# 3. Exploitation Testing
create_desktop_file \
    "msfconsole.desktop" \
    "Metasploit Console" \
    "The world's most used penetration testing framework." \
    "xfce4-terminal --command=/usr/bin/msfconsole" \
    "metasploit-framework" \
    "exploit-test"
echo "  - msfconsole.desktop (Exploit) Selesai"

# 4. Wireless, Bluetooth & Radio
create_desktop_file \
    "airgeddon.desktop" \
    "airgeddon" \
    "Multi-use bash script for wireless network auditing." \
    "xterm -e airgeddon" \
    "network-wireless" \
    "wireless"
echo "  - airgeddon.desktop (Wireless) Selesai"

# 5. Password Attack
create_desktop_file \
    "hashcat.desktop" \
    "Hashcat" \
    "Advanced password recovery utility." \
    "xterm -e hashcat" \
    "security-password" \
    "password"
echo "  - hashcat.desktop (Password) Selesai"

# 6. Social Engineering
create_desktop_file \
    "setoolkit.desktop" \
    "Social Engineering Toolkit (SET)" \
    "Toolkit for web and human-based attacks." \
    "xterm -e setoolkit" \
    "security-social-engineering" \
    "social"
echo "  - setoolkit.desktop (Social) Selesai"

# 7. Man In The Middle Attack (MITM)
create_desktop_file \
    "ettercap.desktop" \
    "Ettercap" \
    "Comprehensive suite for man-in-the-middle attacks." \
    "xterm -e ettercap" \
    "network-error" \
    "mitm"
echo "  - ettercap.desktop (MITM) Selesai"

# 8. Stress Testing
create_desktop_file \
    "slowloris.desktop" \
    "Slowloris" \
    "HTTP Denial of Service attack tool (Placeholder)." \
    "xterm -e slowloris" \
    "network-error-no-internet" \
    "stress"
echo "  - slowloris.desktop (Stress) Selesai"

# 9. Maintaining Access
create_desktop_file \
    "weevely.desktop" \
    "Weevely" \
    "Stealthy PHP web shell for post-exploitation." \
    "xterm -e weevely" \
    "security-persistence" \
    "maintain"
echo "  - weevely.desktop (Maintain) Selesai"

# 10. Forensics Analysis
create_desktop_file \
    "autopsy.desktop" \
    "Autopsy" \
    "Graphical interface to The Sleuth Kit (digital forensics)." \
    "/usr/bin/autopsy" \
    "security-forensics" \
    "forensic"
echo "  - autopsy.desktop (Forensics) Selesai"

# 11. Reverse Engineering
create_desktop_file \
    "ghidra.desktop" \
    "Ghidra" \
    "Software Reverse Engineering Framework by NSA." \
    "/usr/bin/ghidra" \
    "security-reverse" \
    "reverse"
echo "  - ghidra.desktop (Reverse) Selesai"

# 12. Malware Analysis
create_desktop_file \
    "cuckoo.desktop" \
    "Cuckoo Sandbox" \
    "Automated malware analysis system." \
    "xterm -e cuckoo" \
    "security-malware" \
    "malware"
echo "  - cuckoo.desktop (Malware) Selesai"

# 13. Covering Track
create_desktop_file \
    "torbrowser.desktop" \
    "Tor Browser" \
    "Anonymous browsing tool (Privacy and Anonymity)." \
    "/usr/bin/torbrowser" \
    "security-anonymity" \
    "cover"
echo "  - torbrowser.desktop (Cover) Selesai"


# -----------------------------------------------------------
# ALAT UMUM (4 KATEGORI MISC)
# -----------------------------------------------------------

# 14. Service
create_desktop_file \
    "systemctl.desktop" \
    "Systemctl Service Manager" \
    "Manage and inspect the state of the system and services." \
    "xterm -e systemctl" \
    "applications-system" \
    "service"
echo "  - systemctl.desktop (Service) Selesai"

# 15. Internet
create_desktop_file \
    "firefox.desktop" \
    "Firefox Web Browser" \
    "Browse the World Wide Web." \
    "/usr/bin/firefox" \
    "applications-internet" \
    "internet"
echo "  - firefox.desktop (Internet) Selesai"

# 16. Multimedia
create_desktop_file \
    "vlc.desktop" \
    "VLC Media Player" \
    "Play multimedia files and streams." \
    "/usr/bin/vlc" \
    "applications-multimedia" \
    "multimedia"
echo "  - vlc.desktop (Multimedia) Selesai"

# 17. File & Games
create_desktop_file \
    "thunar.desktop" \
    "Thunar File Manager" \
    "Manage files and directories." \
    "/usr/bin/thunar" \
    "folder-documents" \
    "file-games"
echo "  - thunar.desktop (File & Games) Selesai"


echo "----------------------------------------------------------------------"
echo "Semua 17 file *.desktop telah berhasil dibuat di direktori: $(pwd)"
echo ""

### **Langkah Pemasangan Terakhir**

Setelah Anda menjalankan skrip ini, Anda perlu menempatkan file-file baru tersebut di direktori sistem:

1.  **Pemasangan File Desktop:** Salin file-file yang dibuat ke direktori aplikasi sistem:
    ```bash
    sudo cp leakos_real_tools/*.desktop /usr/share/applications/
    ```

2.  **Pembaruan Database:** Pada beberapa lingkungan desktop, Anda mungkin perlu menjalankan perintah ini agar sistem langsung mengenali aplikasi baru:
    ```bash
    sudo update-desktop-database
    ```

3.  **Verifikasi:** Pastikan Anda telah menyalin file `.menu` dan `.directory` sebelumnya ke lokasi yang benar. Setelah itu, *restart* sesi desktop Anda untuk melihat menu LEAKOS yang lengkap.
