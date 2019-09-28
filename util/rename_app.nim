# プロジェクト名を取得し、ディレクトリ・ファイル・内容を置換します

import os
import strutils

type
  file_change_result = tuple[file: string, changed: bool]

proc get_files(path: string, dir: bool): seq[string] =
  result = @[]
  let path_len = path.len()
  for file in walkDirRec(path):
    var
      new_file = file
      skip_flag = false

    # 探索スキップチェック
    for name in file.split(DirSep):
      if name.startsWith("nimcache") or name.startsWith("bin") or
          name.startsWith(".git") or name.endsWith(".nims"):
        skip_flag = true
        break

    if skip_flag:
      continue

    if dir:
      new_file = os.splitPath(new_file).head
      if result.contains(new_file) == true:
        continue
    result.add new_file[path_len+1 .. new_file.len()-1]

proc move_file(src, dst: string): bool =
  result = false
  # dstのフォルダを生成する
  let dstParent = dst.splitPath().head.split(DirSep)
  # echo dstParent
  var workPath = ""
  if not dstParent[0].endsWith(":"):
    workPath = repeat(DirSep, 1)
  # ディレクトリを作成する
  for p in dstParent:
    workPath = joinPath(workPath, p)
    if workPath != "" and workPath.existsDir() == false:
      discard workPath.existsOrCreateDir()

  if dst.existsFile():
    os.removeFile(dst)
  os.moveFile(src, dst)

  result = true

proc replace_file_content(file, findStr, repStr: string): file_change_result =
  result = (file, false)
  var buff: seq[string] = @[]
  # ファイル読み込み
  for line in file.lines():
    var newLine = line
    let findIndex = line.find(findStr)
    if findIndex >= 0:
      result.changed = true
      # replace word
      newLine = line.replace(findStr, repStr)
    # add line to seq
    buff.add newLine

  # output file to temp dir
  if result.changed:
    let
      tmp = os.getTempDir()
      s_file = file.splitPath()
    result.file = joinPath(tmp, s_file.tail)
    let f = open(result.file, FileMode.fmWrite)
    defer:
      f.close()
    for line in buff:
      f.writeLine line

when isMainModule:
  let
    cmdArgs = os.commandLineParams()
    target_dir = os.expandFilename(cmdArgs[0])
    package_name = cmdArgs[1]
    new_package_name = os.splitPath(target_dir).tail

  if package_name == new_package_name:
    echo "オリジナルのテンプレートなので終了します"
    quit(1)

  echo package_name, " => ", new_package_name

  echo "=== rename files ==="
  for file in get_files(target_dir, false):
    let org_file = joinPath(target_dir, file)
    var new_file = file.replace(package_name, new_package_name)
    if file != new_file:
      echo "mv ", file, " ", new_file
      new_file = joinPath(target_dir, new_file)
      discard move_file(org_file, new_file)

  echo "=== content ==="
  for file in get_files(target_dir, false):
    var new_file = joinPath(target_dir, file)
    let tmp_file = replace_file_content(new_file, package_name,
        new_package_name)
    if tmp_file.changed:
      echo "mv ", $tmp_file.file, " ", new_file
      discard move_file(tmp_file.file, new_file)

  