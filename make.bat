@REM @Author: anchen
@REM @Date:   2016-12-21 16:38:42
@REM @Last Modified by:   anchen
@REM Modified time: 2016-12-22 15:57:18

@echo off
if "%1%"=="genlib" goto genlib
if "%1%"=="test" goto test
if "%1%"=="clean" goto clean

:help
    echo "Usage: make [genlib | test]"
    goto end

:genlib
    call vsvars32
    cl /c /DWIN32 /GS- entry.c malloc.c printf.c stdio.c string.c
    lib entry.obj malloc.obj printf.obj stdio.obj string.obj /OUT:minicrt.lib
    goto end

:test
    call vsvars32
    cl /c /DWIN32 test.c
    link test.obj minicrt.lib kernel32.lib /NODEFAULTLIB /entry:mini_crt_entry
    test arg1 arg2 123
    goto end

:clean
    echo "cleaning project"
    for %%i in (*.obj, *.lib, *.txt) do del /f /q %%i
    goto end

:end
