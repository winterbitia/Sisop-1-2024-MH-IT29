#wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN' -O genshin_character.zip
#unzip genshin_character.zip 
#unzip genshin_character.zip 

#cd genshin_character
#for file in *; do
#    if [ -f "$file" ]; then
#        decoded_name=$(echo "$file" | xxd -r -p)
#        mv "$file" "$decoded_name"
#    fi
#done

while IFS=',' read -r Nama Region Element Senjata; do 
    mkdir -p "$Region" 
    new_name="${Region} - ${Nama} - ${Element} - ${Senjata}.jpg" 
    mv "${Nama}.jpg" "${Region}/${new_name}" 
    echo "File ${Nama}.jpg telah direname menjadi ${Region}/${new_name}" 
done < "list_character.csv"
