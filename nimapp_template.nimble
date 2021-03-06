# Package

packageName   = "nimapp_template"
version       = "0.1.0"
author        = "input your name"
description   = "sample app with nimble"
license       = "MIT"           

srcDir        = "src"                     # ソースフォルダ
binDir        = "bin"                     # 実行モジュールを配置するフォルダ
bin           = @[ "nimapp_template" ]    # アプリケーションファイル名
skipDirs      = @[ "tests" , "util" ]     # nimble install時にスキップするフォルダ
backend       = "c"                       # デフォルトはc

# Dependencies

requires "nim >= 1.0.0"
requires "docopt >= 0.6.7"

task run, "アプリケーションを実行します":
  exec "nimble build"
  exec "bin/" & packageName & " nim"

task test2, "テスト実行":                  # デフォルトのtestコマンドは、backendの値を参照しない
  # キャッシュファイルをクリア
  exec "nimble clean"
  # テスト実行開始
  exec "nim " & backend & " -r tests/alltest"

task clean, "キャッシュのクリア":
  rmDir "src/nimcache"
  rmDir "tests/nimcache"
  rmDir "util/nimcache"

task rename, "プロジェクト名を伴うファイル名・内容を置換します":
  rmDir ".git"
  mkDir "bin"
  exec "nim c -r --hints:off --verbosity:0 --out:bin/rename_app util/rename_app.nim . " & packageName
  rmDir "src/" & packageName & "pkg"
  #exec "rm nimapp_template_*.nims"
  exec "nimble clean"

task rename_test, "リネームテスト用":
  mkDir "bin"
  rmDir "../nimapp_template2"
  exec "cp -rp . ../nimapp_template2"
  exec "nim c -r --hints:off --verbosity:0 --out:bin/rename_app util/rename_app.nim ../nimapp_template2 " & packageName
  rmDir "../nimapp_template2/src/" & packageName & "pkg"
  exec "rm ../nimapp_template2/nimapp_template_*.nims"

task pretty, "ソースの整形" :
  exec "nim c -r --hints:off --verbosity:0 --out:bin/test util/pretty_files"
