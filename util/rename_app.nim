# プロジェクト名を取得し、ディレクトリ・ファイル・内容を置換します

import os
import ospaths
import strutils

type
  file_change_result = tuple[file: string, changed: bool]

proc get_files(path:string, dir:bool) : seq[string] =
  result = @[]
  for file in walkDirRec(path):
    if file.find("nimcache",0) >= 0 or file.find("bin",0) >= 0 or file.find(".git",0) >= 0 :
      continue
    let absFile = file
    if dir :
      let dirNames = ospaths.splitPath(absFile) 
      if result.contains(dirNames.head) == false:
        result.add dirNames.head
    else:
      result.add file
  
proc rename_path(path,findStr,repStr: string) : string =
  let fileInfo = ospaths.splitPath(path)
  result = path
  # ファイル名を検索
  if fileInfo.tail.find(findStr) >= 0 :
    let name = fileInfo.tail.replace(findStr,repStr)
    result = joinPath(fileInfo.head,name)

proc rep_str(line,f,r: string) : string =
  result = line
  if f == r :
    return
  if line.find(f) == -1 :
    return 
  else:
    result = line.replace(f,r)
  result = rep_str(result,f,r)

proc move_file(src,dst:string) : bool =
  result = false
  # dstのフォルダを生成する
  let dstParent = dst.splitPath().head.split("/")
  echo dstParent
  var workPath = "/"
  for p in dstParent:
    workPath = joinPath(workPath,p) 
    echo "[" , workPath , "]"

    if workPath != "" and workPath.existsDir() == false:
      discard workPath.existsOrCreateDir()

  os.copyFile(src,dst)
  result = true

proc replace_file_content(file,findStr,repStr: string) : file_change_result =
  result = (file,false)
  var buff:seq[string] = @[]
  # ファイル読み込み
  for line in file.lines():
    var newLine = line
    let findIndex = line.find(findStr)
    if findIndex >= 0:
      result.changed = true
      # replace word
      newLine = rep_str(line,findStr,repStr)
    # add line to seq
    buff.add newLine

  # output temp dir
  if result.changed:
    let tmp = os.getTempDir()
    let s_file = file.splitPath()
    result.file = joinPath(tmp,s_file.tail)
    let f : File = open(result.file,FileMode.fmWrite)
    defer:
      f.close()
    for line in buff:
      f.writeLine line

when isMainModule:
  let target_dir = os.expandFilename(os.commandLineParams()[0])
  let package_name = os.commandLineParams()[1]
  var new_package_name = ospaths.splitPath(os.getCurrentDir()).tail
  if package_name == new_package_name:
    new_package_name = "sample"

  echo package_name , " => " , new_package_name 

  echo "=== rename files ==="
  for file in get_files(target_dir,false):
    let new_name = rename_path(file,package_name,new_package_name)
    if new_name.startsWith(target_dir):
      if file != new_name:
        echo new_name

  echo "=== rename dirs ==="
  for file in get_files(target_dir,true):
    let new_name = rename_path(file,package_name,new_package_name)
    if new_name.startsWith(target_dir):
      if file != new_name:
        echo new_name

  echo "=== content ==="
  for file in get_files(target_dir,false):
    let tmp_file = replace_file_content(file,package_name,new_package_name)
    if tmp_file.changed :
      echo "mv " , $tmp_file.file , " " , file

  echo ospaths.splitPath(os.getCurrentDir()).tail
  echo os.getCurrentDir()

  echo "=== copy file ==="
  discard move_file(
    "/mnt/c/Users/0hya6/workspaces/workspace-nim/nimapp_template/src/nimapp_templatepkg/private/main_impl.nim",
    "/mnt/c/Users/0hya6/workspaces/workspace-nim/nimapp_template/src/samplepkg/private/main_impl.nim"
  )
