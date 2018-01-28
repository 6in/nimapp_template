# Package

packageName   = "sample"
version       = "0.1.0"
author        = "input your name"
description   = "sample app with nimble"
license       = "MIT"           

srcDir        = "src"                     # ソースフォルダ
binDir        = "bin"                     # 実行モジュールを配置するフォルダ
bin           = @[ "sample" ]    # アプリケーションファイル名
skipDirs      = @[ "tests" , "util" ]     # nimble install時にスキップするフォルダ
backend       = "cpp"                     # デフォルトはC

# Dependencies

requires "nim >= 0.17.2"

task test2, "テスト実行":                  # デフォルトのtestコマンドは、backendの値を参照しない
  # キャッシュファイルをクリア
  exec "nimble clean"
  # テスト実行開始
  exec "nim " & backend & " -r tests/alltest"

task clean, "キャッシュのクリア":
  rmDir "bin"
  rmDir "src/nimcache"
  rmDir "tests/nimcache"
  rmDir "util/nimcache"
  mkDir "bin"

task rename, "プロジェクト名を伴うファイル名・内容を置換します":
  rmDir "../sample2"
  exec "cp -rp . ../sample2"
  exec "nim c -r --out:bin/rename_app util/rename_app.nim ../sample2 " & packageName
  
