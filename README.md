## 概要

nimble を利用したnimアプリケーション開発用テンプレートです。
以下の特徴があります。

* nimbleの標準的なファイル・フォルダ構成によるサンプルソース
* ユニットテストのサンプル
* cloneしたファイルの置換

### 利用方法

githubからclone後、```nimble rename```コマンドを実行すると、元のテンプレート名に関連する構成ファイル名やソース内のパッケージ名等を置換します。

```
# アプリケーション名をsampleとします
git clone https://github.com/6in/nimapp_template.git sample

# フォルダに入ります
cd sample

# 内部ファイルをリネームします
nimble rename
```

### nimbleコマンド

clean
test
test2
build
install

### ファイル・フォルダ構成

### デバッグビルド
```nimble build```

### リリースビルド
```nimble install```

インストールしたモジュールは.nimble/pkgs/配下に格納され、実行モジュールは~/.nimble/bin配下にシンボリックリンクが作成されます

```
6in% ls -la ~/.nimble/bin        
合計 0
drwxr-xr-x. 2 6in 6in  83  1月 26 10:50 .
drwxr-xr-x. 4 6in 6in 103  3月 24  2016 ..
lrwxrwxrwx  1 6in 6in  61  1月 26 10:09 sample -> /home/6in/.nimble/pkgs/sample-0.1.0/sample
```

```
~/.nimble/pkgs/sample-0.1.0
├── sample
├── sample.nim
├── sample.nimble
├── samplepkg
│   ├── main.nim
│   └── private
│       └── main_impl.nim
└── nimblemeta.json
```

テスト実行

```tests/``` ファイル名に 't'で始まるディレクトリtest内のすべてのファイルをコンパイルして実行する

