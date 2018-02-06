## 概要

nimble を利用したnimアプリケーション開発用テンプレートです。

以下の特徴があります。

* nimbleの標準的なファイル・フォルダ構成によるサンプルソース
* ユニットテストのサンプルソース
* cloneしたファイルの置換
* .nimbleのカスタムタスクのサンプル

### 諸注意

* windowsで実行する際は、[こちら](https://qiita.com/yufu/items/86a455f948a3e1c0ef97)を参考に、コマンドプロンプトの設定を行ってください。
* nimのコンパイルモードはC++を指定しています。c言語に戻したいときは、*.nimble の backend を cに変更してください。

```nim:nimapp_template.nimble
backend = "c"
```

### テンプレートの利用方法

githubからclone後、```nimble rename```タスクを実行すると、元のテンプレート名に関連する構成ファイル名やソース内のパッケージ名等を置換します。

```
# アプリケーション名を sample とします
$ git clone https://github.com/6in/nimapp_template.git sample

# フォルダに入ります
$ cd sample

# 内部のフォルダ・ファイル等をアプリケーション名に変換します
$ nimble rename

# アプリケーションをビルドし、実行します
$ nimble run
{{hello [[nim]]}}

```

### 利用できるnimbleタスク一覧

| タスク | 説明 |
| ------- | ---- |
| clean | bin,nimcacheを削除します |
| test | ユニットテストの実行を行います |
| test2 | nimbleに記述されている backend に基づきユニットテストを実行します |
| run | アプリケーションを実行します |
| build | デバッグビルドを行います |
| install | リリースビルドを行います |
| rename | テンプレートを置換します |

### renameタスクについて

renameタスクは、nimapp_template.nimbleに記述されている```packageName```の内容を取得し、nimbleを起動した**カレントディレクトリの名前**に変換します。
変換対象は、以下の３つです。
* フォルダ
* ファイル名
* ファイルの中身

### ファイル・フォルダ構成

#### clone直後
```
sample
├── nimapp_template.nimble        # nimbleファイル
├── README.md                     # アプリケーション用のREADME.md
├── TEMPLATE-README.md            # このテンプレートのREADME.md
├── src                           # ソースフォルダ
│   ├── nimapp_template.nim       # 起動ファイル(docoptによるパース)
│   └── nimapp_templatepkg        # パッケージフォルダ
│       ├── main.nim              # mainソースファイル
│       └── private
│           └── main_impl.nim     # メイン実装用？お好きに利用ください
├── tests                         # ユニットテストフォルダ
│   ├── alltest.nim               # nimble test2タスクが呼び出すソース
│   ├── nim.cfg                   # テスト用コンパイルオプション
│   ├── test1.nim                 # ユニットテストソース(サンプル)
│   └── test2.nim
└── util                          # nimbleから呼び出すツール
    └── rename_app.nim            # テンプレートファイル置換ツール
```

#### rename後

```
sample
├── sample.nimble                 # ファイル名・内容が変更
├── README.md                     # 内容が変更
├── TEMPLATE-README.md
├── src
│   ├── sample.nim                # ファイル名・内容が変更
│   └── samplepkg                 # フォルダ名が変更
│       ├── main.nim              
│       └── private
│           └── main_impl.nim
├── tests
│   ├── alltest.nim               # 内容が変更
│   ├── nim.cfg       
│   ├── test1.nim                 # 内容が変更
│   └── test2.nim                 # 内容が変更
└── util
    └── rename_app.nim
```

### ビルドについて

* デバッグビルドの場合は```nimble build```を実行します
* リリースビルドの場合は```nimble install```を実行します

リリースビルドしたモジュールは ```~/.nimble/pkgs/```配下に格納され、実行モジュールは```~/.nimble/bin/```配下に実行ファイルへのシンボリックリンクが作成されます。

```
% nimble install

% ls -la ~/.nimble/bin        
合計 0
drwxr-xr-x. 2 6in 6in  83  1月 26 10:50 .
drwxr-xr-x. 4 6in 6in 103  3月 24  2016 ..
lrwxrwxrwx  1 6in 6in  61  1月 26 10:09 sample -> ~/.nimble/pkgs/sample-0.1.0/sample
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

### アプリケーション実行について

#### runタスク

*.nimbleに記述されている


### ユニットテストについて

#### test タスク

nimble の testタスクを実行すると
```tests/``` ファイル名に **t** で始まるディレクトリtest内のすべてのファイルをコンパイルして実行します。

#### test2 タスク

nimble の testタスクは、.nimbleファイルの **backend** の値を参照していないようなので、backendを指定し、tests/alltest.nim を呼び出す**test2**タスクを作成しています。

test/alltest.nimでは、ユニットテストが記述されているソースをimportしているのみです。

test2 タスクにすると、tests/alltest.nimソースの、ユニットテストソースのimport文をコメントON/OFFにするだけで制御できるので、使い勝手が良いかもしれません。
