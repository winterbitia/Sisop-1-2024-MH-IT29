#!/bin/bash

# Fungsi untuk menangani pesan tersembunyi yang ditemukan
handle_found_message() {
    local image="$1"
    local url=$(xxd -p -c 9999 secret.txt | tr -d '\n' | xxd -r -p)
    echo "[$(date +'%d/%m/%y %H:%M:%S')] [FOUND] [$image]" >> image.log
    echo "URL yang ditemukan: $url"
    # Download file berdasarkan URL yang ditemukan
    wget "$url"
    exit 0
}

# Loop tak terbatas untuk mencari pesan tersembunyi
while true; do
    # Iterasi melalui setiap file gambar jpg
    for image in *.jpg; do
        # Ekstraksi pesan tersembunyi dari file gambar
        steghide extract -sf "$image" &> /dev/null

        # Periksa apakah ekstraksi berhasil
        if [ $? -eq 0 ]; then
            # Jika berhasil, periksa apakah file secret.txt ada
            if [ -f "secret.txt" ]; then
                # Jika secret.txt ada, panggil fungsi untuk menangani pesan tersembunyi yang ditemukan
                handle_found_message "$image"
            else
                # Jika secret.txt tidak ada, hapus file yang tidak diinginkan dan catat pesan penolakan
                rm -f secret.txt
                echo "[$(date +'%d/%m/%y %H:%M:%S')] [REJECTED] [secret.txt]" >> image.log
            fi
        else
            # Jika ekstraksi gagal, catat pesan bahwa pesan tersembunyi tidak ditemukan
            echo "[$(date +'%d/%m/%y %H:%M:%S')] [NOT FOUND] [$image]" >> image.log
        fi
    done
    # Tunggu 1 detik sebelum iterasi berikutnya
    sleep 1
done

