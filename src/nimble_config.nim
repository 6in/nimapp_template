var
  packageName, version, author, description, license, srcdir, binDir,
    backend: string
  skipDirs, skipFiles, skipExt, installDirs, installFiles, installExt, bin,
    requiresData, foreignDeps: seq[string]

proc requires(deps: varargs[string]) = discard
proc getPkgDir(): string = discard

template task(name: untyped; description: string;
    body: untyped): untyped = discard
template before(action: untyped; body: untyped): untyped = discard
template after(action: untyped; body: untyped): untyped = discard
template builtin = discard
