## Raylib Template

### Windows (gcc.exe)
```bash
# Debug Build
$ ./script/build_mingw64.sh
# Release Build
$ ./script/build_mingw64.sh --release

# Build and Run
$ ./script/build_mingw64.sh && ./bin/debug/app.exe
```

### Windows (cl.exe)
```bash
# Debug Build
$ script\build_msvc.bat
# Release Build
$ script\build_msvc.bat --release

# Build and Run
$ call script\build_msvc.bat && bin\debug\app.exe
```

### Linux
```bash
# Debug Build
$ ./script/build_linux.sh
# Release Build
$ ./script/build_linux.sh --release

# Build and Run
$ ./script/build_linux.sh && ./bin/debug/app
```
