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
echo Menampilkan 3 kategori yang memiliki total profit paling tinggi.
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
### Revisi
Pada bagian 1b terjadi kesalahan dalam menampilkan informasi yang seharusnya menampilkan customer segment namun malah menampilkan nama pelanggan. Untuk memperbaiki kesalahan ini, saya telah merevisi kode yang saya gunakan. Dengan cara mengganti bagian $6 yaitu kolom nama pelanggan menjadi $7 yaitu kolom customer segment. Berikut ini adalah perbaikan kode saya beserta penjelasan rinci setiap kodenya yang saya lampirkan dalam komentar:
 ```sh
echo Menampilkan customer segment yang memiliki profit paling kecil.
awk -F ',' 'NR > 1 { if (min_profit == "" || $20 < min_profit) { min_profit = $20; min_segment = $7; }} END { print min_segment, min_profit }' Sandbox.csv
# -F ',': menetapkan pemisah antar kolom.
# NR > 1: memastikan bahwa proses awk dimulai dari baris kedua, melewati header.
# $7: Kolom customer segment.
# $20: Kolom profit.
# if (min_profit == "" || $20 < min_profit) { min_profit = $20; min_segment = $7; }: memeriksa dan memperbarui nilai profit terkecil dari customer segment.
# END: penanda blok kode yang akan dijalankan setelah semua baris diproses.
# print min_segment, min_profit: perintah menampilkan customer segment dengan profit terkecil.
```
### Hasil Akhir
![alt text](https://cdn.discordapp.com/attachments/1149170089590001815/1223517604778606712/Screenshot_1536.png?ex=661a2490&is=6607af90&hm=8a5db21aca09a0ff138cd252a40e4d9282f63f22b424983e467d4df1b8fdea84&)

## Soal 2

**Dikerjakan oleh : Amoes Noland (5027231028)**

Dalam soal nomor 2, kita disuruh untuk membuat sebuah **sistem identifikasi user**, yang dipenuhi dengan fitur admin untuk manajemen user. Script yang diperlukan oleh soal adalah `register.sh` dan `login.sh`.

### register.sh
Script pertama yang diperlukan adalah **untuk mendaftarkan user baru ke dalam sistem.** Untuk bagian pertama, terdapat perintah kepada pengguna untuk memasukkan email. Sistem mengharuskan pengguna untuk memasukkan email yang valid **(memiliki tanda @)** dan bukan merupakan email yang sudah terdaftar pada users.txt (harus unique; akan dijelaskan lebih lanjut mengenai daftar user yang sudah registered). Bila terjadi kegagalan maka, harus mengeluarkan pesan status kegagalan sesuai waktu percobaan register dilakukan.

```sh
# Welcome message
echo -e "Welcome to the Registration System!\n"

# Email check
echo "Enter your email:" && read email
if echo "$email" | grep -vo "@"; then
    echo -e "\nPlease enter a valid email."
    echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER FAILED] ERROR Failed register attempt with error: "Invalid email": [$email]" >> auth.log
    exit 1
fi
if grep -q "^$email:.*:.*:.*:.*" users.txt; then
    echo -e "\nEmail already exists. Please choose a different one."
    echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER FAILED] ERROR Failed register attempt with error: "Email already exists": [$email]" >> auth.log
    exit 1
fi
```
Berikutnya dalam program register adalah untuk meminta username (bebas), dan security question/answer untuk fitur Forgot Password yang nantinya akan diterapkan pada `login.sh`.
```sh
# Username input
echo "Enter your username:" && read uname

# Security question
echo "Enter a security question:" && read sec_q
echo "Enter a security answer:" && read sec_a
```
Berikutnya dalam program register adalah untuk meminta password dengan kriteria:
* Encrypt dengan base64
* Lebih dari 8 karakter
* Minimal satu huruf uppercase dan lowercase
* Minimal satu angka

Hal ini dilakukan dengan menggunakan if statement yang mengecek jumlah karakter dalam string dan mencari semua kriteria jenis karakter dengan mengapitnya dengan tanda bintang (wild card) dalam perbandingan. Bila password tidak sesuai, maka sistem akan meminta hingga password terisi sesuai kriteria atau program dihentikan.

```sh
# Password check
echo "Enter password:"
echo "(>8 chars, 1 uppercase, 1 lowercase, 1 number)"
read -s pass
while true; do
    if [[ ${#pass} -ge 8
        && "$pass" == *[[:lower:]]*
        && "$pass" == *[[:upper:]]*
        && "$pass" == *[0-9]* ]]; then
        break
    else
        echo "Password does not meet the requirements"
        echo "Enter password:" && read -s pass
    fi
done
```
Enkripsi password yang telah dimasukkan sebelumnya dilakukan dengan command sebagai berikut:
```sh
# Add base64 encryption
encrypt=`echo $pass | base64`
```
Setelah seluruh data terisi, maka hasil akan disimpan ke dalam sebuah file bernama `users.txt` yang berisi catatan seluruh user yang sudah dibuat. Segala keberhasilan/kegagalan juga dilaporkan kepada file `auth.log`.
```sh
# Add to users.txt
echo "$email:$uname:$sec_q:$sec_a:$encrypt" >> users.txt
echo -e "\nREGISTRATION SUCCESSFUL!\nUse login.sh to enter your account.\n"
echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER SUCCESS] user [$uname] register success" >> auth.log
```
Berikut merupakan contoh isi `users.txt` :
```
test1@mail:Bob:date of birth:260907:RUxLQVNKRDIja2phZGYK
test2@mail:John:favorite movie?:shrek:QUtKU0hkaGphc2RoJDQK
test3@mail:Alex:favorite series?:Skibidi Toilet:NzdmZkpKYWtqc2RsZmgK
zolguroth.thedestroyer99@mail:Zolguroth:where is the chicken:the oven:RUVGamRhZmg0NGYK
test5@mail:Ann:favorite video game?:among us:YWtsc2RmamFzO2tkZmxqNDQqSAo=
```
Berikut merupakan contoh register user:

![alt text](https://cdn.discordapp.com/attachments/1071478813566976151/1223670975321735251/image.png?ex=661ab367&is=66083e67&hm=0250ce007f7586a2de8f8ed20c117c56f868cbc1dd5633c563490080d52d2ff7&)


### login.sh
Script berikutnya merupakan sebuah program login untuk para user yang sudah terdaftar. Hal pertama yang seorang pengguna akan lihat adalah interface login yang berisi 2 pilihan yang dibuat dengan menggunakan sistem menu angka switch case.
```sh
# Start program
echo "Welcome to the Login Page. Please select an option:"
echo "1. Login"
echo "2. Forgot Password"
echo "Choose an option: " && read locked

# Select option
case $locked in
1) loginuser ;;
2) i_forgor ;;
*) echo "Invalid option" ;;
esac
```
Fungsi utama dari script ini adalah `loginuser()` yang meminta email dan password yang terhubung dengan email (bila email ditemukan). 

Saat sebuah email ditemukan, dilakukan enkripsi input dengan base64 untuk dibandingkan dengan hasil enkripsi yang tersimpan pada `users.txt` dan terdapat 3 cabang kejadian yang bisa terjadi:
* Login berhasil -> fungsi member dipanggil
* Login berhasil, email memiliki kata admin -> fungsi admin dipanggil
* Login gagal -> keluar dari fungsi

Semua kejadian tersebut akan tercatat pada `auth.log` sesuai dengan hasil yang terjadi dengan mencatat username yang didapat melalui `grep` dan `cut` untuk menghindari kejadian dengan `awk` field separator (:) yang dapat melakukan print dua email yang mengandung 2 substring yang sama.
```sh
loginuser() {
    # Email check
    echo "Enter your email:" && read email
    if ! grep -q "^$email:" users.txt; then    
        echo -e "\nEmail not found."
        return 1
    else
        # Password check
        echo "Enter password:" && read -s pass
        uname=`grep "^$email:" users.txt | cut -d':' -f2`
        encrypt=`echo $pass | base64`

        # Admin login
        if grep -q "^$email:.*:.*:.*:$encrypt" users.txt && echo "$email" | grep -q "admin"; then
                echo -e "\nLogin successful\n"
                echo "$(date '+[%d/%m/%y %H:%M:%S]') [LOGIN SUCCESS] user [$uname] login success" >> auth.log
                admin
        # Member login
        elif grep -q "^$email:.*:.*:.*:$encrypt" users.txt; then
                echo -e "\nLogin successful\n"
                echo "$(date '+[%d/%m/%y %H:%M:%S]') [LOGIN SUCCESS] user [$uname] login success" >> auth.log
                member
        # Fail login
        else
                echo -e "\nPassword is incorrect. Please enter the correct password."
                echo "$(date '+[%d/%m/%y %H:%M:%S]') [LOGIN FAILED] ERROR Failed login attempt on user with email [$email]" >> auth.log
                return 1  
        fi
    fi
}
```
Berikut adalah isi dari fungsi member yang dapat diubah sesuai keperluan:
```sh
member() {
    # Welcome message
    echo -e "\nWelcome! You have member privileges.\n"
    return 0
}
```
Berikut adalah contoh login member berhasil:

![alt text](https://cdn.discordapp.com/attachments/1071478813566976151/1223671601518870528/image.png?ex=661ab3fc&is=66083efc&hm=3ad5dee68c9aa0c750251040c5b1008c6c5bf25a86ee3fd8649f414124455a79&)


Berikutnya terdapat sebuah fungsi yang berfungsi untuk menampilkan password suatu user bila **berhasil menjawab security question** yang sudah dibuat saat registrasi. 

Menggunakan sistem pencarian email yang sama dengan fungsi sebelumnya, fungsi ini menampilkan security question dari email yang tersedia melalui `grep` dan `cut`.

Bila security question terjawab dengan benar, maka password akan dilakukan dekripsi dari base64 menjadi karakter yang sesuai awal dan ditampilkan kepada pengguna.
```sh
i_forgor() {
    # Email check
    echo "Enter your email:" && read email
    if ! grep -q "^$email:" users.txt; then    
        echo -e "\nEmail not found."
        return 1
    else
        # Grab security question
        sec_q=`grep "^$email:" users.txt | cut -d':' -f3`
        echo "Security question: $sec_q"
        # Sec_q check
        echo "Enter your answer:" && read sec_a
        if ! grep -q "^$email:.*:.*:$sec_a" users.txt; then
            echo -e "\nIncorrect answer."
            return 1
        else
            encrypt=`grep "^$email:" users.txt | cut -d':' -f5`
            pass=`echo $encrypt | base64 -d`
            echo -e "\nYour password is: $pass\n"
        fi
    fi
}
```
Berikut adalah contoh tampilan password:

![alt text](https://cdn.discordapp.com/attachments/1071478813566976151/1223671992373477376/image.png?ex=661ab459&is=66083f59&hm=bcfee80ee4fea7c83935badb8d10b7a6ed8dfcd6301c6052625f9b47acb2b42c&)


Fungsi berikutnya adalah menu admin yang hanya dapat diakses ketika email yang telah diregistrasi memiliki kata admin. Menggunakan sistem menu angka switch case yang sama seperti yang telah dibuat sebelumnya, seorang admin dapat memilih untuk add user, edit user, ataupun delete user.

Fungsi ini juga akan mengulang dirinya sendiri bila input tidak sesuai, dan dari ketiga fungsi admin yang tersedia, semua diakhiri dengan fungsi admin agar dapat melakukan beberapa perintah admin secara berturut-turut hingga selesai pekerjaan yang diperlukan.
```sh
admin() {
    # Start admin menu
    echo -e "\nWelcome! You have admin privileges."
    echo "Admin Menu"
    echo "1. Add User"
    echo "2. Edit User"
    echo "3. Delete User"
    echo "4. Exit"
    
    echo -e "\nChoose an option: "
    read locked

    # Select option
    case $locked in
    1) adduser ;;
    2) edituser ;;
    3) deleteuser ;;
    4) echo "Exiting..."
        exit 0 ;;
    *) echo "Invalid option"
        admin ;;
    esac
    
    return 0
}
```
Berikut adalah tampilan admin:

![alt text](https://media.discordapp.net/attachments/1071478813566976151/1223672280392142989/image.png?ex=661ab49e&is=66083f9e&hm=b4457267817c2b56096c6063124392b3136796af29fe2a282aa6e7387a0e06ff&=&format=webp&quality=lossless&width=604&height=525)


Fungsi admin pertama merupakan `adduser()` yang merupakan hal yang identik dengan script `login.sh`
```sh
adduser() {
    # Email check
    echo "Enter your email:" && read email
    if echo "$email" | grep -vo "@"; then
        echo -e "\nPlease enter a valid email."
        echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER FAILED] ERROR Failed register attempt with error: "Invalid email": [$email]" >> auth.log
        return 1
    fi
    if grep -q "^$email:.*:.*:.*:.*" users.txt; then
        echo -e "\nEmail already exists. Please choose a different one."
        echo "$(date '+[%d/%m/%y %H:%M:%S]') [REGISTER FAILED] ERROR Failed register attempt with error: "Email already exists": [$email]" >> auth.log
        return 1
    fi

    # Username input
    echo "Enter your username:" && read uname

    # Security question
    echo "Enter a security question:" && read sec_q
    echo "Enter a security answer:" && read sec_a

    # Password check
    echo -e "Enter password:\n(min 8 chars, 1 uppercase, 1 lowercase, 1 digit)"
    read -s pass
    while true; do
        if [[ ${#pass} -ge 8
            && "$pass" == *[[:lower:]]*
            && "$pass" == *[[:upper:]]*
            && "$pass" == *[0-9]* ]]; then
            break
        else
            echo "Password does not meet the requirements"
            echo "Enter password:"
            read -s pass
        fi
    done

    # Add base64 encryption
    encrypt=`echo $pass | base64`

    # Add to users.txt
    echo "$email:$uname:$sec_q:$sec_a:$encrypt" >> users.txt
    echo -e "\nAdd successful.\n " && admin
}
```
Fungsi admin kedua merupakan `edituser()` yang digunakan untuk membuat ulang isi data sebuah email sesuai keperluan. Menggunakan sistem pencarian email yang sama dengan fungsi sebelumnya, admin dapat mengubah seluruh data pada sebuah user dan bahkan melanggar peraturan password. Pembaharuan data digunakan dengan cara perintah `c` (change) dari `sed` pada baris yang sesuai email yang dimasukkan.
```sh
edituser () {
    # Email check
    echo "Enter your email:" && read email
    if ! grep -q "^$email:" users.txt; then    
        echo -e "\nEmail not found."
        return 1
    else
        # Add new data
        echo "Enter new username:" && read new_uname
        echo "Enter new security question:" && read new_sec_q
        echo "Enter new security answer:" && read new_sec_a
        echo "Enter new password:" && read -s new_pass #Admins can break password rules
        newencrypt=`echo $new_pass | base64`

        # Replace old data
        sed -i "/^$email:/c\\$email:$new_uname:$new_sec_q:$new_sec_a:$newencrypt" users.txt
        echo -e "\nEdit successful.\n" && admin
    fi
}
```
Fungsi admin terakhir merupakan `deleteuser()` yang digunakan untuk menghilangkan user dari email yang disebut. Menggunakan sistem pencarian email yang sama dengan fungsi sebelumnya, menghapus satu user dengan cara perintah `d` (delete) dari `sed` pada baris yang sesuai email yang dimasukkan.
```sh
deleteuser () {
    # Email check
    echo "Enter your email:" && read email
    if ! grep -q "^$email:" users.txt; then    
        echo -e "\nEmail not found."
        return 1
    else
        # Delete selected account
        sed -i "/^$email:/d" users.txt
        echo -e "\nDelete successful.\n" && admin
    fi
}
```
Semua percobaan login dan register, baik berhasil atau gagal, tercatat ke dalam sebuah file `auth.log`, berikut adalah contoh log yang dibuat:
```log
[29/03/24 22:48:37] [REGISTER SUCCESS] user [sus] register success
[29/03/24 22:49:10] [REGISTER SUCCESS] user [adminsus] register success
[30/03/24 00:16:12] [LOGIN FAILED] ERROR Failed login attempt on user with email [sus@among]
[30/03/24 00:16:36] [LOGIN SUCCESS] user [sus] login success
[30/03/24 00:17:47] [REGISTER FAILED] ERROR Failed register attempt with error: Invalid email: [sus]
[30/03/24 00:17:53] [REGISTER FAILED] ERROR Failed register attempt with error: Email already exists: [sus@among]
```


### Kendala
Tidak ada kendala.

## Soal 3

**Dikerjakan oleh : Malvin Putra Rismahardian (5027231048)**
### Isi soal

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
**Bagian 1 : Mengunduh dan mengekstrak data**

     wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'>
     unzip genshin.zip && unzip genshin_character.zip     

**Penjelasan Code**

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

**Penjelasan Code**

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

**Penjelasan Code**

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


## Search.sh
Script berikutnya adalah untuk mencari link tersembunyi di balik foto-foto yang telah di rename sebelumnya. sehingga, untuk lognya adalah
```sh
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
```

Skrip bash di atas bertanggung jawab untuk mendeteksi dan mengekstraksi pesan tersembunyi dari file gambar dalam format .jpg. Berikut adalah penjelasan garis besar mengenai kegunaan skrip tersebut:

	handle_found_message():

* Fungsi ini digunakan untuk menangani pesan tersembunyi yang berhasil ditemukan dalam file gambar.
Ketika pesan tersembunyi berhasil diekstraksi, fungsi ini mencatat waktu, nama file gambar, dan URL yang ditemukan dalam file image.log.
Setelah itu, fungsi ini mengunduh file yang terhubung dengan URL tersebut.

**Loop Tak Terbatas:**
* Skrip ini berjalan dalam sebuah loop tak terbatas menggunakan konstruksi _while true; do ... done._
Ini memastikan bahwa proses pencarian pesan tersembunyi akan terus berjalan hingga skrip dihentikan secara manual.

**Iterasi melalui Setiap File Gambar:**
* Skrip melakukan iterasi melalui setiap file gambar dalam direktori saat ini dengan ekstensi .jpg.

**Ekstraksi Pesan Tersembunyi:**
* Menggunakan perintah steghide, skrip mencoba mengekstraksi pesan tersembunyi dari setiap file gambar.
Output dari perintah ini disalurkan ke /dev/null agar tidak ditampilkan di layar.

**Penanganan Hasil Ekstraksi:**
* Jika ekstraksi berhasil, skrip akan memeriksa keberadaan file secret.txt.
Jika secret.txt ditemukan, fungsi handle_found_message() akan dipanggil untuk menangani pesan tersembunyi yang ditemukan.
Jika secret.txt tidak ditemukan, skrip akan menghapus file yang tidak diinginkan dan mencatat pesan penolakan dalam image.log.

**Pencatatan Pesan dan Tunggu 1 Detik:**
* Setelah proses penanganan file selesai, skrip akan mencatat hasil pencarian dalam image.log.
Skrip kemudian akan menunggu selama 1 detik sebelum melakukan iterasi berikutnya.
Dengan cara ini, skrip tersebut secara otomatis memeriksa setiap file gambar dalam format .jpg untuk mendeteksi dan mengekstraksi pesan tersembunyi, dan kemudian melakukan tindakan yang sesuai berdasarkan hasil ekstraksi tersebut.

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

Untuk memastikan bahwa file log hanya dapat dilihat oleh pemilik, maka semua permission dari *group* dan *others* harus dihilangkan. Selain itu, untuk menutup script, akan dilakukan delete `temp.txt` agar directory milik script dapat menjadi lebih bersih.
```sh
# manage permissions
chmod go-rwx "/home/$user/log/""metrics_$(date +"%Y%m%d%H%M%S").log"    

# delete the temporary text file
rm temp.txt
```
Script ini akan berjalan setiap menit bila menggunakan sistem Cron Jobs dengan setting **at every minute (\* \* \* \* \*)**, yang dilakukan dengan mengubah file crontab dengan cara `crontab -e` untuk memanggil script yang sudah dibuat melalui directory lengkap. Contohnya adalah sebagai berikut:
```
* * * * * /home/winter/Documents/ITS/SISOP/Modul1/soal_4/minute_log.sh
```

### aggregate_minutes_to_hourly_log.sh
Untuk membuat agregasi file log setiap jam, pertama diperlukan mencari semua file log dalam tersimpan dalam folder log sesuai ketentuan. Kode akan mengambil semua file log dengan filter:
* Dibuat **1 jam yang lalu**
* Tidak memiliki kata **agg**

Dari semua file log yang ditemukan, akan diambil seluruh data angkanya menggunakan `awk` dengan field separator tanda koma. Setelah itu, dilakukan konversi ukuran disk menggunakan `numfmt` agar tidak terjadi kasus dimana **900M > 1G** saat dilakukan perbandingan angka. Semua data yang ditemukan akan diprint ke dalam sebuah file text sementara khusus yang dinamakan `temphour.txt` untuk penggunaan lebih lanjut.
```sh
# find all log files located in the log folder
user=`whoami`
range=`date -d '-1 hour' +%Y%m%d%H`
find /home/$user/log -name "*$range*" -not -name '*_agg_*' -exec awk -F "," 'END{cmd=sprintf("numfmt --from=iec %s",$11); cmd | getline conv; close(cmd); print $0","  conv}' {} \; > temphour.txt 
```
Berikut adalah 5 baris contoh `temphour.txt` yang dihasilkan dari kode di atas:
```
15413,5751,7332,101,2760,9661,5000,0,5000,/home/winter,19G,20401094656
15413,5745,7337,101,2760,9667,5000,0,5000,/home/winter,19G,20401094656
15413,5776,7307,99,2758,9637,5000,0,5000,/home/winter,19G,20401094656
15413,5759,7323,101,2760,9653,5000,0,5000,/home/winter,19G,20401094656
15413,5804,7279,101,2760,9608,5000,0,5000,/home/winter,19G,20401094656
```
Hal berikutnya yang harus dilakukan adalah mulai memproses hasil pengambilan data yang sudah tersimpan dalam `temphour.txt` dengan menyimpan variabel menggunakan ternary conditional dalam berbagai command `awk` sehingga dapat ditemukan variabel minimum dan maximum dari setiap kolom. Setelah itu, hasil yang sudah terhitung disimpan dalam sebuah log file khusus yang sesuai format yang diminta dengan mengambil data tanggal/waktu menggunakan `date`.
```sh
# create the hourly log file
echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > /home/$user/log/"metrics_agg_$(date +"%Y%m%d%H").log"
    # minimum
awk -F "," '(NR==1){t = $1} {t = $1<t ? $1:t}  END{print "minimum,"t","}
            (NR==1){a = $2} {a = $2<a ? $2:a}  END{print a","}
            (NR==1){b = $3} {b = $3<b ? $3:b}  END{print b","}
            (NR==1){c = $4} {c = $4<c ? $4:c}  END{print c","}
            (NR==1){d = $5} {d = $5<d ? $5:d}  END{print d","}
            (NR==1){e = $6} {e = $6<e ? $6:e}  END{print e","}
            (NR==1){f = $7} {f = $7<f ? $7:f}  END{print f","}
            (NR==1){g = $8} {g = $8<g ? $8:g}  END{print g","}
            (NR==1){h = $9} {h = $9<h ? $9:h}  END{print h","$10","}
            (NR==1){m = $12}{m = $12<m ? $12:m}END{cmd=sprintf("numfmt --to=iec %d",m); cmd | getline conv; close(cmd); print conv}
            ' temphour.txt | paste -s -d '' >> /home/$user/log/"metrics_agg_$(date +"%Y%m%d%H").log"
    # maximum
awk -F "," '(NR==1){t = $1} {t = $1>t ? $1:t}  END{print "maximum,"t","}
            (NR==1){a = $2} {a = $2>a ? $2:a}  END{print a","}
            (NR==1){b = $3} {b = $3>b ? $3:b}  END{print b","}
            (NR==1){c = $4} {c = $4>c ? $4:c}  END{print c","}
            (NR==1){d = $5} {d = $5>d ? $5:d}  END{print d","}
            (NR==1){e = $6} {e = $6>e ? $6:e}  END{print e","}
            (NR==1){f = $7} {f = $7>f ? $7:f}  END{print f","}
            (NR==1){g = $8} {g = $8>g ? $8:g}  END{print g","}
            (NR==1){h = $9} {h = $9>h ? $9:h}  END{print h","$10","}
            (NR==1){m = $12}{m = $12>m ? $12:m}END{cmd=sprintf("numfmt --to=iec %d",m); cmd | getline conv; close(cmd); print conv}
            ' temphour.txt | paste -s -d '' >> /home/$user/log/"metrics_agg_$(date +"%Y%m%d%H").log"
```
Selain itu, juga diperlukan untuk memproses semua log file yang dicari untuk mencari nilai rata-rata masing-masing kolom, hal ini dilakukan menggunakan `awk` dengan cara membagi total nilai setiap kolom dengan jumlah baris pada kolom. Juga dilakukan konversi nilai disk seperti bagian sebelumnya untuk perhitungan yang benar dari disk size. Setelah itu, hasil yang sudah terhitung disimpan juga dalam sebuah log file yang sama.
```sh
# average
awk -F "," '{t+=$1}  END{print "average,"t/NR","}
            {a+=$2}  END{print a/NR","}
            {b+=$3}  END{print b/NR","}
            {c+=$4}  END{print c/NR","}
            {d+=$5}  END{print d/NR","}
            {e+=$6}  END{print e/NR","}
            {f+=$7}  END{print f/NR","}
            {g+=$8}  END{print g/NR","}
            {h+=$9}  END{print h/NR","$10","}
            {m+=$12} END{cmd=sprintf("numfmt --to=iec %d",m/NR); cmd | getline conv; close(cmd); print conv}
            ' temphour.txt | paste -s -d '' >> /home/$user/log/"metrics_agg_$(date +"%Y%m%d%H").log"
```
Contoh file **metrics_agg_\*.log** yang dihasilkan adalah sebagai berikut:
```log
type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size
minimum,15413,5472,7279,99,2614,9608,0,0,0,/home/winter,19G
maximum,15413,5804,7764,153,2783,9940,5000,0,5000,/home/winter,19G
average,15413,5628.2,7481.3,126.2,2754.1,9784,2500,0,2500,/home/winter,19G
```
Untuk memastikan bahwa file log hanya dapat dilihat oleh pemilik, maka semua permission dari *group* dan *others* harus dihilangkan. Selain itu, untuk menutup script, akan dilakukan delete `temphour.txt` agar directory milik script dapat menjadi lebih bersih.
```sh
# manage permissions
chmod go-rwx "/home/$user/log/"metrics_agg_$(date +"%Y%m%d%H").log""

# delete the temporary text file
rm temphour.txt
```
Script ini akan berjalan setiap jam bila menggunakan sistem Cron Jobs dengan setting **at hour 0 (0 \* \* \* \*)**, dilakukan dengan mengubah file crontab dengan cara `crontab -e` untuk memanggil script yang sudah dibuat melalui directory lengkap. Contohnya adalah sebagai berikut:
```
0 * * * * /home/winter/Documents/ITS/SISOP/Modul1/soal_4/aggregate_minutes_to_hourly_log.sh
```
### Kendala
Tidak ada kendala.
