#!/bin/bash

CATEGORY_DIR="/usr/share/desktop-directories"
APPLICATIONS_DIR="/usr/share/applications"

# Fungsi untuk mengekstrak nama teknis kategori dari nama file .directory
# Contoh: leakos-intelligent-gather.directory -> intelligent-gather
function get_technical_category_name() {
    local directory_file="$1"
    # Memotong path, membuang 'leakos-', dan membuang '.directory'
    basename "$directory_file" | sed -E 's/leakos-(.*)\.directory/\1/'
}

# --- Fungsi Utama 1: Menampilkan Kategori ---
function show_categories() {
    categories=()
    category_map="" # Untuk memetakan Nama Cantik ke Nama Teknis

    for category_file in "$CATEGORY_DIR"/*.directory; do
        if [ -f "$category_file" ]; then
            # Ambil Nama Cantik (untuk ditampilkan di Rofi)
            category_name=$(grep -m 1 "^Name=" "$category_file" | cut -d'=' -f2)
            
            # Ambil Nama Teknis (untuk pencocokan file .desktop)
            category_technical_name=$(get_technical_category_name "$category_file")
            
            category_icon=$(grep -m 1 "^Icon=" "$category_file" | cut -d'=' -f2)
            [ -z "$category_icon" ] && category_icon="applications-system"
            
            categories+=("$category_name")
            categories+=("$category_icon")
            
            # Buat Peta (Mapping): Nama Cantik|Nama Teknis
            category_map+="$category_name|$category_technical_name\n"
        fi
    done

    # Tampilkan menu dan ambil Nama Cantik yang dipilih
    selected_category_display=$(printf "%s\0icon\x1f%s\n" "${categories[@]}" | \
        rofi -dmenu -i -show-icons -icon-theme "blackarch" -p "Select category")
    
    # Ambil Nama Teknis yang sesuai dari Peta
    selected_category_technical=$(echo -e "$category_map" | grep -F "$selected_category_display|" | cut -d'|' -f2)

    echo "$selected_category_technical" # Kembalikan nama teknis (misalnya: intelligent-gather)
}

# --- Fungsi Utama 2: Menampilkan Aplikasi ---
function show_applications() {
    local category_technical_name="$1" # Berisi nama teknis (misalnya: intelligent-gather)
    local search_string="LEAKOS-$category_technical_name;" # String yang dicari (misalnya: LEAKOS-intelligent-gather;)

    apps=()

    for app_file in "$APPLICATIONS_DIR"/*.desktop; do
        if [ -f "$app_file" ]; then
            no_display=$(grep -m 1 "^NoDisplay=" "$app_file" | cut -d'=' -f2)
            [ "$no_display" = "true" ] && continue

            app_name=$(grep -m 1 "^Name=" "$app_file" | cut -d'=' -f2)
            app_icon=$(grep -m 1 "^Icon=" "$app_file" | cut -d'=' -f2)
            app_categories=$(grep -m 1 "^Categories=" "$app_file" | cut -d'=' -f2)

            # PENCARIAN DIPERBAIKI: Mencocokkan string teknis yang lengkap
            if [[ "$app_categories" == *"$search_string"* ]]; then
                [ -z "$app_icon" ] && app_icon="applications-other"
                apps+=("$app_name")
                apps+=("$app_icon")
            fi
        fi
    done

    selected_app=$(printf "%s\0icon\x1f%s\n" "${apps[@]}" | \
        rofi -dmenu -i -show-icons -icon-theme "blackarch" -p "Select application")

    echo "$selected_app"
}

# --- Fungsi Utama 3: Menjalankan Aplikasi ---
# Tidak ada perubahan besar yang diperlukan, tetapi ditambahkan fitur terminal yang lebih aman
function run_application() {
    local app_name="$1"
    # Cari file .desktop berdasarkan nama aplikasi
    app_file=$(grep -rl -m 1 "^Name=$app_name" "$APPLICATIONS_DIR" 2>/dev/null)
    [ -z "$app_file" ] && app_file=$(grep -rl -m 1 "^Name=.*$app_name" "$APPLICATIONS_DIR" 2>/dev/null | head -1)

    if [ -n "$app_file" ]; then
        # Ekstrak perintah Exec dan bersihkan kode field
        exec_command=$(grep -m 1 "^Exec=" "$app_file" | cut -d'=' -f2- | sed -e 's/ %.//g' -e 's/%[fFuUdDnNickvm]//g')
        terminal_app=$(grep -m 1 "^Terminal=" "$app_file" | cut -d'=' -f2)
        
        if [ "$terminal_app" = "true" ]; then
            # Menggunakan xterm atau terminal default Anda
            # Ganti 'urxvt' jika Anda menggunakan terminal lain (misalnya 'xterm' atau 'xfce4-terminal')
            urxvt -e bash -c "$exec_command; exec bash"
        else
            eval "$exec_command" &
        fi
    else
        echo "Error: Could not find .desktop file for '$app_name'"
        exit 1
    fi
}

# --- Eksekusi Program ---
selected_category_technical=$(show_categories)

if [ -n "$selected_category_technical" ]; then
    selected_app=$(show_applications "$selected_category_technical")
    if [ -n "$selected_app" ]; then
        run_application "$selected_app"
    else
        echo "No application selected. Exiting."
        exit 1
    fi
else
    echo "No category selected. Exiting."
    exit 1
fi
