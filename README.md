# Sisop-1-2024-MH-IT29
## Anggota Kelompok:
- Dian Anggraeni Putri (5027231016)
- Amoes Noland (5027231028)
- Malvin Putra Rismahardian (5027231048)

## Soal 1

**Dikerjakan oleh : Dian Anggraeni Putri (5027231016)**

Pertama, saya menggunakan perintah wget untuk mengunduh file "Sandbox.csv" dari Google Drive. Dalam perintah tersebut, saya menggunakan opsi --no-check-certificate untuk mendownload tanpa memeriksa sertifikat SSL, sehingga mempercepat proses download. Saya juga menggunakan opsi -O untuk mengontrol nama file yang akan didownload, yaitu dengan nama "Sandbox.csv".
```shell
wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0' -O Sandbox.csv
```
Kedua, saya ingin memastikan file "Sandbox.csv" sudah ada dan berhasil terdownload dengan perintah ls.
```shell
ls 
```
Ketiga, saya ingin mencoba menampilkan isi file CSV "Sandbox.csv" secara langsung di terminal menggunakan perintah cat.
```shell
cat Sandbox.csv 
```
### 1a
Saya menggunakan perintah `awk` untuk menganalisis file "Sandbox.csv" yang berisi data penjualan. Tujuan saya adalah untuk mengidentifikasi pelanggan yang paling berkontribusi dalam total penjualan. Selama proses, saya mengakumulasi total penjualan untuk setiap pelanggan dalam array, dan saya secara terus-menerus memperbarui nilai tertinggi saat total penjualan yang baru lebih besar. Dengan demikian, setelah seluruh file diproses, saya menampilkan hasilnya, yaitu pelanggan dengan total penjualan tertinggi dan jumlah total penjualannya. Berikut ini adalah kode saya beserta penjelasan rinci setiap kodenya yang saya lampirkan dalam komentar:
 ```sh
echo Menampilkan pelanggan dengan total sales paling tinggi.
awk -F ',' 'NR > 1  {sales[$6] += $17; if (sales[$6] > highest_sales) highest_sales = sales[$6]} END {for (buyer in sales) if (sales[buyer] == highest_sales) print buyer, sales[buyer]}' Sandbox.csv

# -F ',': menetapkan pemisah antar kolom.
# NR > 1: memastikan bahwa proses awk dimulai dari baris kedua, melewati header.
# $6: kolom nama pelanggan.
# $17: kolom total penjualan.
# {sales[$6] += $17;: menghitung total penjualan untuk setiap pelanggan, apabila beberapa entri penjualan ditujukan untuk pelanggan yang sama, jumlah penjualan akan diakumulasikan untuk pelanggan tersebut.
# if (sales[$6] > highest_sales) highest_sales = sales[$6]}: membandingkan total penjualan tertinggi untuk setiap pelanggan dan memperbarui nilai total penjualan tertinggi jika diperlukan. 
# END: penanda blok kode yang akan dijalankan setelah semua baris diproses.
# {for (buyer in sales) if (sales[buyer] == highest_sales) print buyer, sales[buyer]}: loop yang mengiterasi setiap pelanggan dalam data total penjualan, serta menampilkan nama pelanggan yang memiliki total penjualan tertinggi.
 ```
### 1b
Saya menggunakan perintah `awk` untuk menganalisis file "Sandbox.csv" yang berisi data penjualan. Dalam proses ini, saya mencari segmentasi pelanggan yang memberikan profit paling kecil. Dengan menghitung total profit untuk setiap segmentasi pelanggan dan membandingkannya satu sama lain, saya berhasil mengidentifikasi segmentasi yang memiliki profit terendah. Dengan demikian, hasil akhirnya adalah menampilkan pelanggan yang memiliki profit paling kecil beserta jumlah profitnya. Berikut ini adalah kode saya beserta penjelasan rinci setiap kodenya yang saya lampirkan dalam komentar:
 ```sh
echo Menampilkan customer segment atau pelanggan yang memiliki profit paling kecil.
awk -F ',' 'NR > 1 {profits[$6] += $20; if (profits[$6] < min_profit || min_profit == "") min_profit = profits[$6]} END {for (buyer in profits) if (profits[buyer] == min_profit) print buyer, profits[buyer]}' Sandbox.csv

# -F ',': menetapkan pemisah antar kolom.
# NR > 1: memastikan bahwa proses awk dimulai dari baris kedua, melewati header.
# $6: kolom nama pelanggan.
# $20: kolom profit.
# {profits[$6] += $20;: menghitung total profit untuk setiap pelanggan, apabila beberapa entri profit ditujukan untuk pelanggan yang sama, jumlah profit akan diakumulasikan untuk pelanggan tersebut.
# if (profits[$6] < min_profit || min_profit == "") min_profit = profits[$6]}: membandingkan total profit terendah untuk setiap pelanggan dan memperbarui nilai total profit terendah jika diperlukan. 
# END: penanda blok kode yang akan dijalankan setelah semua baris diproses.
# {for (buyer in profits) if (profits[buyer] == min_profit) print buyer, profits[buyer]}: loop yang mengiterasi setiap pelanggan dalam data profit, serta menampilkan nama pelanggan yang memiliki total profit terendah.
```
### 1c
Saya menggunakan perintah `awk` untuk menganalisis file "Sandbox.csv" yang berisi data penjualan. Tujuannya adalah untuk mengidentifikasi tiga kategori dengan total profit paling tinggi. Selama proses, saya mengumpulkan total profit untuk setiap kategori dalam array `profits`. Setelah seluruh file diproses, saya mengatur pengurutan kategori berdasarkan profit dalam urutan menurun, dan kemudian saya memilih tiga kategori teratas dengan total profit tertinggi. Jika sudah ada tiga kategori teratas yang teridentifikasi, saya memeriksa apakah profit kategori saat ini lebih tinggi daripada yang paling rendah di antara tiga kategori teratas. Jika ya, saya menggantinya dengan kategori saat ini. Dengan demikian, hasil akhirnya adalah menampilkan nama kategori dan total profitnya untuk tiga kategori teratas tersebut. Berikut ini adalah kode saya beserta penjelasan rinci setiap kodenya yang saya lampirkan dalam komentar:
 ```sh
echo Menampilkan 3 kategori yang memiliki total profit paling tinggi
awk -F ',' 'NR > 1 {profits[$14] += $20} END {PROCINFO["sorted_in"] = "@val_num_desc"; count = 0; for (category in profits) { if (count < 3) { top_categories[category] = profits[category]; count++; } else { for (top in top_categories) { if (profits[category] > top_categories[top]) { delete top_categories[top]; top_categories[category] = profits[category]; break; } } } } for (category in top_categories) print category, top_categories[category] }' Sandbox.csv

# -F ',': menetapkan pemisah antar kolom.
# NR > 1: memastikan bahwa proses awk dimulai dari baris kedua, melewati header.
# $14: kolom kategori.
# $20: kolom profit.
# {profits[$14] += $20}: menghitung total profit untuk setiap kategori, apabila beberapa entri profit ditujukan untuk kategori yang sama, jumlah profit akan diakumulasikan untuk kategori tersebut.
# END: penanda blok kode yang akan dijalankan setelah semua baris diproses.
# {PROCINFO["sorted_in"] = "@val_num_desc"; ...}: mengatur pengurutan kategori berdasarkan profit dalam urutan menurun atau dari nilai besar ke kecil.
# count = 0;: Inisialisasi variabel count ke 0 untuk melacak jumlah kategori teratas yang sudah diidentifikasi.
# for (category in profits) { ... }: loop yang mengiterasi setiap kategori dalam array profit.
# if (count < 3) { ... }: memeriksa apakah sudah ada tiga kategori teratas yang teridentifikasi. Jika belum, maka kategori saat ini ditambahkan ke top_categories.
# else { ... }: jika sudah ada tiga kategori teratas yang teridentifikasi, maka kode ini akan memeriksa apakah profit kategori saat ini lebih tinggi daripada yang paling rendah di antara tiga kategori teratas.
# delete top_categories[top]: menghapus kategori terendah dari top_categories.
# top_categories[category] = profits[category];: menambahkan kategori saat ini ke top_categories.
# break;: menghentikan loop setelah menambahkan kategori saat ini ke top_categories.
# for (category in top_categories) print category, top_categories[category]: mencetak nama kategori dan profitnya untuk setiap kategori yang termasuk dalam top_categories, yaitu tiga kategori teratas dengan total profit tertinggi.
```
### 1d
Pertama, saya menggunakan perintah `awk` untuk mencari semua baris yang mengandung kata "Adriaens" dari file CSV "Sandbox.csv".
 ```sh
awk '/Adriaens/ {print}' Sandbox.csv
```
Kedua, saya menggunakan perintah `grep` untuk menyaring baris yang mengandung kata "Adriaens" dari file "Sandbox.csv". Kemudian, saya menggunakan perintah `awk` untuk menampilkan kolom ke-2 yaitu purchase date, ke-6 yaitu nama pelanggan, dan ke-17 yaitu amount/quantity. Dengan cara ini, saya berhasil menampilkan purchase date dan amount (quantity) dari pembeli dengan nama "Adriaens" dari file "Sandbox.csv".  Berikut ini adalah kode saya beserta penjelasan rinci setiap kodenya yang saya lampirkan dalam komentar:
 ```sh
echo Menampilkan purchase date dan amount (quantity) dari nama adriaens
grep 'Adriaens' Sandbox.csv | awk -F ',' '{print $2, $6, $17}' 
# $2: kolom purchase date atau tanggal pembelian.
# $6: kolom nama pelanggan.
# $17: kolom sales atau amount (quantity).
# grep 'Adriaens' Sandbox.csv: Ini akan menyaring baris yang mengandung kata "Adriaens" dari file Sandbox.csv
# | : pipe sebagai jembatan output dari perintah pertama (grep) menjadi input dari perintah kedua (awk).
# awk -F ',' '{print $2, $6, $17}': memerintahkan awk untuk mencetak kolom ke-2 (order date), ke-6 (nama konsumen), dan ke-17 (kolom sales, atau jumlah penjualan) dari setiap baris yang ditemukan.
```
###  Screenshot Hasil Pengerjaan
![alt text](https://cdn.discordapp.com/attachments/1223171682500350062/1223171738532188331/tugas_sisop.png?ex=6618e273&is=66066d73&hm=7bcff634d731c093218a31bcb0d8ef4e000db8b6e13463266c2eac54ddaca4d2&)
### Kendala
Tidak ada kendala.

## Soal 2

**Dikerjakan oleh : Amoes Noland (5027231028)**

### register.sh
**(work in progress)**

### login.sh
**(work in progress)**

### Kendala
Tidak ada kendala.

## Soal 3

**Dikerjakan oleh : Malvin Putra Rismahardian (5027231048)**
### isi soal

Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.

a. Alyss membuat script bernama awal.sh, untuk download file yang diberikan oleh Yanuar dan unzip terhadap file yang telah diunduh dan decode setiap nama file yang terenkripsi dengan hex . Karena pada file list_character.csv terdapat data lengkap karakter, Alyss ingin merename setiap file berdasarkan file tersebut. Agar semakin rapi, Alyss mengumpulkan setiap file ke dalam folder berdasarkan region tiap karakter
* Format: Region - Nama - Elemen - Senjata.jp

b. Karena tidak mengetahui jumlah pengguna dari tiap senjata yang ada di folder "genshin_character".Alyss berniat untuk menghitung serta menampilkan jumlah pengguna untuk setiap senjata yang ada
* Format: [Nama Senjata] : [jumlah]
	 Untuk menghemat penyimpanan. Alyss menghapus file - file yang tidak ia       gunakan, yaitu genshin_character.zip, list_character.csv, dan genshin.zip

c. Namun sampai titik ini Alyss masih belum menemukan clue dari the secret picture yang disinggung oleh Yanuar. Dia berpikir keras untuk menemukan pesan tersembunyi tersebut. Alyss membuat script baru bernama search.sh untuk melakukan pengecekan terhadap setiap file tiap 1 detik. Pengecekan dilakukan dengan cara meng-ekstrak sebuah value dari setiap gambar dengan menggunakan command steghide. Dalam setiap gambar tersebut, terdapat sebuah file txt yang berisi string. Alyss kemudian mulai melakukan dekripsi dengan hex pada tiap file txt dan mendapatkan sebuah url. Setelah mendapatkan url yang ia cari, Alyss akan langsung menghentikan program search.sh serta mendownload file berdasarkan url yang didapatkan.

d. Dalam prosesnya, setiap kali Alyss melakukan ekstraksi dan ternyata hasil ekstraksi bukan yang ia inginkan, maka ia akan langsung menghapus file txt tersebut. Namun, jika itu merupakan file txt yang dicari, maka ia akan menyimpan hasil dekripsi-nya bukan hasil ekstraksi. Selain itu juga, Alyss melakukan pencatatan log pada file image.log untuk setiap pengecekan gambar
* Format: [date] [type] [image_path]
* Ex:
[24/03/20 17:18:19] [NOT FOUND] [image_path]

[24/03/20 17:18:20] [FOUND] [image_path]

e. Hasil akhir : 
* genshin_character
* search.sh
* awal.sh
* image.log
* [filename].txt
* [image].jpg

### Penyelesaian
**Bagian 1 : Mengunduh dan mengekstract data**

     wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'>
     unzip genshin.zip && unzip genshin_character.zip     

**Penjelasan code**

     wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'
- Perintah ini digunakan untuk mengunduh file genshin.zip dan genshin_character.zip dari Google Drive.

      unzip genshin.zip && unzip genshin_character.zip
* Perintah ini digunakan untuk mengekstrak file genshin.zip dan genshin_character.zip.


**Bagian 2: Menambahkan Nama Region, Elemen, dan Senjata ke Nama File Bash**

     for file in *; do
          decrypted_name=$(echo "$file" | xxd -p -r)
          mv "$file" "$decrypted_name"
          echo "File $file telah didekripsi dan diubah menjadi $decrypted_n>
     done   
     cd ..

**Penjelasan code**

          for file in *; do
* Perintah ini digunakan untuk iterasi melalui setiap file di direktori genshin_character.

          decrypted_name=$(echo "$file" | xxd -p -r).
* Perintah ini digunakan untuk mendekripsi nama file.

          mv "$file" "$decrypted_name".
* Perintah ini digunakan untuk mengganti nama file dengan nama yang didekripsi.

          echo "File $file telah didekripsi dan diubah menjadi $decrypted_n>.
* Perintah ini digunakan untuk mencetak pesan ke konsol.

          cd ...
* Perintah ini digunakan untuk berpindah ke direktori sebelumnya.


          while IFS=, read -r Nama Region Element Senjata; do
               Nama=$(echo "$Nama")
               Region=$(echo "$Region")
               Element=$(echo "$Element")
               Senjata=$(echo "$Senjata")
               new_name="$Region-$Nama-$Element-$Senjata"

               if [ -e "genshin_character/$Nama" ];then
                         mv "genshin_character/$Nama" "genshin_character/$new_nam>
                         echo "File genshin_character/$Nama telah direname menjad>
               else
                         echo "File genshin_character/$Nama tidak ditemukan."
               fi
          done < list_character.csv

          declare -A hitung_senjata


          for file in genshin_character/*; do
 
               Senjata=$(basename "$file" | awk -F' - ' '{print $(NF)}') #| awk -F'.>

               if [[ -n "${hitung_senjata[$Senjata]}" ]]; then
                    hitung_senjata[$Senjata]=$(( ${hitung_senjata[$Senjata]} + 1 ))
               else
                    hitung_senjata[$Senjata]=1
               fi
          done

          for Senjata in "${!hitung_senjata[@]}"; do
               echo "$Senjata : ${hitung_senjata[$Senjata]}"
          done

**Penjelasan code**

     while IFS=, read -r Nama Region Element Senjata; do.

* Perintah ini digunakan untuk membaca file list_character.csv dan memisahkan setiap baris berdasarkan karakter setiap kolom disimpan dalam variabel Nama, Region, Element, dan Senjata.

          Nama=$(echo "$Nama").
* Perintah ini digunakan untuk membersihkan variabel Nama.

          Region=$(echo "$Region").
* Perintah ini digunakan untuk membersihkan variabel Region.

          Element=$(echo "$Element").
* Perintah ini digunakan untuk membersihkan variabel Element.

          Senjata=$(echo "$Senjata").
* Perintah ini digunakan untuk membersihkan variabel Senjata.

          new_name="$Region-$Nama-$Element-$Senjata".
* Perintah ini digunakan untuk membuat nama file baru dengan format Region-Nama-Elemen-Senjata.

          if [ -e "genshin_character/$Nama" ];then.
* Perintah ini digunakan untuk memeriksa apakah file dengan nama Nama ada di direktori genshin_character.

          mv "genshin_character/$Nama" "genshin_character/$new_name".
* Perintah ini digunakan untuk mengganti nama file Nama dengan new_name.

          echo "File genshin_character/$Nama telah direname menjadi $new_name".
* Perintah ini digunakan untuk mencetak pesan ke konsol.

          else.
* Perintah ini digunakan jika file dengan nama Nama tidak ada di direktori genshin_character.

          echo "File genshin_character/$Nama tidak ditemukan.".
* Perintah ini digunakan untuk mencetak pesan ke konsol.

          done < list_character.csv.
* Perintah ini digunakan untuk mengakhiri loop while dan membaca file selanjutnya di list_character.csv.

          declare -A hitung_senjata.
* Perintah ini digunakan untuk mendeklarasikan array asosiatif hitung_senjata untuk menyimpan jumlah pengguna setiap senjata.

          for file in genshin_character/*; do.
* Perintah ini digunakan untuk iterasi melalui setiap file di direktori genshin_character.

          Senjata=$(basename "$file" | awk -F' - ' '{print $(NF)}') #| awk -F'.>.
* Perintah ini digunakan untuk mengekstrak nama senjata dari nama file.

          if [[ -n "${hitung_senjata[$Senjata]}" ]]; then.
* Perintah ini digunakan untuk memeriksa apakah nama senjata sudah ada di array hitung_senjata.

          hitung_senjata[$Senjata]=$(( ${hitung_senjata[$Senjata]} + 1 )).
* Perintah ini digunakan untuk menambahkan 1 ke nilai hitung_senjata[$Senjata] jika nama senjata sudah ada di array.

          else.
* Perintah ini digunakan jika nama senjata belum ada di array hitung_senjata.

          hitung_senjata[$Senjata]=1.
* Perintah ini digunakan untuk menambahkan nama senjata ke array hitung_senjata dengan nilai 1.

          fi.
* Perintah ini digunakan untuk mengakhiri loop if.

          done.
* Perintah ini digunakan untuk mengakhiri loop for.



**Bagian 5: Menampilkan Jumlah Pengguna Setiap Senjata**

          for Senjata in "${!hitung_senjata[@]}"; do.
* Perintah ini digunakan untuk iterasi melalui setiap elemen dalam array hitung_senjata.

          echo "$Senjata : ${hitung_senjata[$Senjata]}".
* Perintah ini digunakan untuk mencetak nama senjata dan jumlah penggunanya ke konsol.

### Kendala
Kendala yang saya alami dalam menyelesaikan soal nomor 3 adalah akibat kehilangan file yang telah selesai dikodekan saat hendak diunggah ke GitHub. Saya telah melaporkan insiden ini kepada asisten, Mas Adfi, pada waktu yang sama ketika kejadian terjadi. Meskipun telah direncanakan untuk melakukan kembali pengkodean, namun keterbatasan waktu menghalangi penyelesaian tepat waktu.

## Soal 4

**Dikerjakan oleh : Amoes Noland (5027231028)**

Di dalam soal nomor 4, kita disuruh untuk membuat program untuk monitoring RAM dan penggunaan disk pada home user directory. Terdapat dua script yang digunakan, `minute_log.sh` yang berjalan setiap menit untuk mencatat data, dan `aggregate_minutes_to_hourly_log.sh` yang berjalan setiap jam untuk menyimpulkan data yang sudah tercatat.

### minute_log.sh
Untuk memperoleh data mentah penggunaan RAM dan disk, digunakan beberapa perintah yang sudah disebut dalam modul, dan akan tersimpan dalam sebuah satu file text sementara, sehingga bisa dimanipulasi untuk pembuatan log. 
```sh
# extracting memory usage to a temporary text file
free -m > temp.txt

# extracting disk usage from the user home directory to THE temporary text file
user=`whoami` && du -sh /home/$user >> temp.txt
```
Contoh file **temp.txt** yang terbuat adalah sebagai berikut:
```
               total        used        free      shared  buff/cache   available
Mem:           15413        5022        8122          66        2663       10391
Swap:              0           0           0
18G	/home/winter
```
Hal berikutnya yang harus dilakukan adalah untuk menampilkan hasil pengambilan data mentah penggunaan RAM dan disk ke dalam sebuah log file yang sudah tertulis secara rapi. Ini dilakukan dengan cara mengambil data dari `temp.txt` yang sesuai dengan jenis data yang ingin dicatat melalui fungsi print `awk` pada setiap kolom yang relevan.

Semua hasil print digabung dalam satu baris menggunakan fungsi `paste` dan semua tulisan disimpan dalam sebuah log file yang sesuai format yang diminta dengan mengambil data tanggal/waktu menggunakan `date`.
```sh
# print results using echo and awk
echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > /home/$user/log/"metrics_$(date +"%Y%m%d%H%M%S").log"
awk '/Mem/ {print $2","$3","$4","$5","$6","$7","};
     /Swa/ {print $2","$3","$4","};
     /home/ {print $2","$1}
     ' temp.txt | paste -s -d '' >> /home/$user/log/"metrics_$(date +"%Y%m%d%H%M%S").log"
```
Contoh file **metrics_\*.log** yang dihasilkan adalah sebagai berikut:
```log
mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size
15413,5814,5814,65,4179,9599,5000,0,5000,/home/winter,18G
```
Script ini akan berjalan setiap menit bila menggunakan sistem Cron Jobs yang dilakukan dengan mengubah file crontab dengan cara `crontab -e` untuk memanggil script yang sudah dibuat melalui directory lengkap. Contohnya adalah sebagai berikut:
```
* * * * * /home/winter/Documents/ITS/SISOP/Modul1/soal_4/minute_log.sh
```

### aggregate_minutes_to_hourly_log.sh
**(work in progress)**


### Kendala
Tidak ada kendala.
