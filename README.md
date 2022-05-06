# Bitmap画像の作成プログラム
## 概要    
[バイナリかるた](https://kozos.jp/binary-karuta/)で扱われる画像をシェルスクリプトで作成
## 使い方
```
bash make_bmp.sh
```
でファイルパスを入力(Tab補完可)  
```
>>>sample.txt
```
→bmpファイルがbmp_files内に作成される
## 注意
make_bmp.sh内のheaderは課題内容と異なる可能性がある  
プログラムファイルには対応不可  
ファイルパス入力で失敗しても適当にbmpファイルが作成されてしまう  
## 検証済み環境
ubuntu 20.04
## 参考
- https://qiita.com/chooyan_eng/items/151e67684e5ef8d1a695
- https://shiro-nekonet/log/2021/04/27/od-command/
