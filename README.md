

ツリー構造
```
mkdir nimble_test
cd nimble_test
nimble init
```

```nim: nimble_test.nimble
# Package

version       = "0.1.0"
author        = "input your name"
description   = "nimble sample"
license       = "MIT"

# Dependencies

requires "nim >= 0.17.2"
```

```
mkdir src
mkdir bin
echo "echo \"hello nim\"" > src/nimble_test.nim
```

```nim: nimble_test.nimble
# Package

version       = "0.1.0"
author        = "6in"
description   = "nimble sample"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @[ "nimble_test" ]

# Dependencies

requires "nim >= 0.17.2"
```

ビルドしてみる
```
nimble build

ls -la bin
drwxrwxr-x 2 6in 6in   60  1月 25 14:47 .
drwxrwxr-x 4 6in 6in  120  1月 25 14:42 ..
-rwxr-xr-x 1 6in 6in 181K  1月 25 14:46 nimble_test
```

デバッグビルド
```nimble build```

リリースビルド
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

