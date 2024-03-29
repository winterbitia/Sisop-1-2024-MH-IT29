#!/bin/bash

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN' -O 'genshin.zip'
unzip genshin.zip && unzip genshin_character.zip

cd genshin_character

for file in *; do
	decrypted_name=$(echo "$file" | xxd -p -r)
	mv "$file" "$decrypted_name"
	echo "File $file telah didekripsi dan diubah menjadi $decrypted_name"
done

cd ..

while IFS=, read -r Nama Region Element Senjata; do
        Nama=$(echo "$Nama")
        Region=$(echo "$Region")
        Element=$(echo "$Element")
        Senjata=$(echo "$Senjata")
        new_name="$Region-$Nama-$Element-$Senjata"

        if [ -e "genshin_character/$Nama" ];then
                mv "genshin_character/$Nama" "genshin_character/$new_name"
                echo "File genshin_character/$Nama telah direname menjadi genshin_character/$new_name"
        else
                echo "File genshin_character/$Nama tidak ditemukan."
        fi
done < list_character.csv


 #Inisialisasi array asosiatif untuk menyimpan jumlah pengguna setiap senjata
declare -A hitung_senjata

 #Loop melalui setiap file di direktori genshin_character
for file in genshin_character/*; do
     #Ambil nama senjata dari nama file
    Senjata=$(basename "$file" | awk -F' - ' '{print $(NF)}') #| awk -F'.' '{print $1}')

     #Tambahkan jumlah pengguna senjata ke dalam array
    if [[ -n "${hitung_senjata[$Senjata]}" ]]; then
        hitung_senjata[$Senjata]=$(( ${hitung_senjata[$Senjata]} + 1 ))
    else
        hitung_senjata[$Senjata]=1
    fi
done

# Tampilkan jumlah pengguna setiap senjata
for Senjata in "${!hitung_senjata[@]}"; do
    echo "$Senjata : ${hitung_senjata[$Senjata]}"
done
