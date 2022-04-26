prompt=">>> "
echo enter file full path "("you can use Tab")"
read -ep $prompt file_name
# 8192バイトまでのバイナリー表示
tmp_file_name=${file_name##*/}
od -t x1 $file_name | head -n 512 | cut -d " " -f 2-17 > binary2bmp_${tmp_file_name}_tmp.txt

header="## ファイルヘッダ ##
42 4d           # ファイルタイプを2バイトで指定。Bitmapは必ず'BM' (16進数で 42 4d)
34 20 00 00     # ファイルサイズを4バイトで指定。TODO: あとで
00 00           # 予約領域1を2バイトで指定。常に0
00 00           # 予約領域2を2バイトで指定。常に0
36 00 00 00     # ファイルの先頭から画像データまでのバイト数を4バイトで指定。 TODO: あとで
## 情報ヘッダ ##
28 00 00 00     # 情報ヘッダサイズを4バイトで指定。
10 00 00 00     # 画像の横幅（単位はピクセル）を4バイトで指定。
00 01 00 00     # 画像の高さ（単位はピクセル）を4バイトで指定。
01 00           # プレーン数を2バイトで指定。常に1
08 00           # 色ビット数を2バイトで指定。今回は白黒2色なので1
00 00 00 00     # 圧縮形式を4バイトで指定。
fe 1f 00 00     # 画像データ部分のサイズを4バイトで指定。 TODO: あとで
C4 1E 00 00     # 横方向の解像度を4バイトで指定。
C4 1E 00 00     # 縦方向の解像度を4バイトで指定。
00 00 00 00     # パレット数を4バイトで指定。
00 00 00 00     # 重要色数を4バイトで指定。
"

echo "$header" > header.txt

cat header.txt binary2bmp_${tmp_file_name}_tmp.txt > binary2bmp_${tmp_file_name}.txt

folder_name="bmp_files"
mkdir -p $folder_name

#bmpファイル作成
cat binary2bmp_${tmp_file_name}.txt | awk -F# '{print $1}' | tr -dc [0-9a-f] | xxd -r -p > ./${folder_name}/${tmp_file_name}.bmp

rm binary2bmp_${tmp_file_name}*.txt
rm header.txt