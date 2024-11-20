@echo off

@cd %~dp0\input

@dir *.dmp /b > dmp.txt

for /f "tokens=*" %%m in (dmp.txt) do (

    echo %%m

    ren %%m MapPalette.dmp

    TilesetFogFilter.py

    ren MapPalette2.dmp %%m

    move %%m "..\output\"%%m

    ren MapPalette.dmp %%m
)

@del dmp.txt

echo Red Fog Palettes processed!

pause