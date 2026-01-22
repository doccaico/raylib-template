@echo off

REM Usage
REM
REM Debug Build
REM     $ script\build_msvc.bat
REM Release Build
REM     $ script\build_msvc.bat --release
REM
REM Build and Run
REM     $ call script\build_msvc.bat && bin\debug\app.exe

setlocal

set EXE=app.exe
set OUTDIR=bin

set CC=cl.exe
set SRC=src\main.c
set CFLAGS=%CFLAGS% -nologo
set CFLAGS=%CFLAGS% -utf-8
set CFLAGS=%CFLAGS% -Oi
set CFLAGS=%CFLAGS% -fp:precise
set CFLAGS=%CFLAGS% -MP
set CFLAGS=%CFLAGS% -FC
set CFLAGS=%CFLAGS% -GF
set CFLAGS=%CFLAGS% -W4
set CFLAGS=%CFLAGS% -wd4100
set CFLAGS=%CFLAGS% -wd4101
set CFLAGS=%CFLAGS% -wd4127
set CFLAGS=%CFLAGS% -wd4146
set CFLAGS=%CFLAGS% -wd4505
set CFLAGS=%CFLAGS% -wd4456
set CFLAGS=%CFLAGS% -wd4457
set CFLAGS=%CFLAGS% -DUNICODE -D_UNICODE
set CFLAGS=%CFLAGS% -D_CRT_SECURE_NO_WARNINGS
set INC=%INC% -Ivendor/raylib/include
set LDFLAGS=%LDFLAGS% -link
set LDFLAGS=%LDFLAGS% -LIBPATH:vendor\raylib\bin\windows\msvc16
set LDFLAGS=%LDFLAGS% -NODEFAULTLIB:libcmt
set LDFLAGS=%LDFLAGS% -INCREMENTAL:no
set LIBS=msvcrt.lib raylib.lib winmm.lib user32.lib shell32.lib gdi32.lib

if "%1" == "--release" (
    set OUTDIR=%OUTDIR%\release
    set CFLAGS=%CFLAGS% -O2 -MT
    set CFLAGS=%CFLAGS% -DNDEBUG -D_NDEBUG
    set LDFLAGS=%LDFLAGS% /SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup
) else (
    set OUTDIR=%OUTDIR%\debug
    set CFLAGS=%CFLAGS% -fsanitize=address -fsanitize=fuzzer
    set CFLAGS=%CFLAGS% -Od -MDd -Zi
    set CFLAGS=%CFLAGS% -DDEBUG -D_DEBUG
    set LDFLAGS=%LDFLAGS% /DEBUG
)

REM %CC% %SRC% -Fo%OUTDIR%\ -Fe%OUTDIR%\%EXE% %CFLAGS% %INC% %LDFLAGS% %LIBS%
%CC% %SRC% -Fo%OUTDIR%\ -Fe%OUTDIR%\%EXE% %CFLAGS% %INC% %LDFLAGS% %LIBS%

if ERRORLEVEL 1 (
    echo Failed to compilation...
    exit /b %ERRORLEVEL%
)

echo Compilation succeeded...
