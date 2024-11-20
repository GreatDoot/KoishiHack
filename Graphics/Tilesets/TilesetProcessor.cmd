@echo off

@cd %~dp0\png

@dir *.png /b > png.txt

for /f "tokens=*" %%m in (png.txt) do (

    echo %%m

    ..\..\..\EventAssembler\Tools\Png2Dmp.exe %%m --lz77 -o %%~nm"-graphics.dmp" -po %%~nm"-palette.dmp"

)

@del png.txt

@dir *.dmp /b > dmp.txt

for /f "tokens=*" %%m in (dmp.txt) do (
    
    echo %%m

    move %%m "..\dmp\"%%m

)

@del dmp.txt

echo PNGs processed!

@cd %~dp0\mapchip

@dir *.mapchip_config /b > mapchip_config.txt

for /f "tokens=*" %%m in (mapchip_config.txt) do (

    echo %%m

    ..\..\..\Tools\gbalz77tool.exe -o %%~nm"-mapchip.dmp" %%m compress

)

@del mapchip_config.txt

@dir *.dmp /b > dmp.txt

for /f "tokens=*" %%m in (dmp.txt) do (
    
    echo %%m

    move %%m "..\dmp\"%%m

)

@del dmp.txt

echo MAPCHIPs processed!

@cd ..\

palettes\_ProcessFogPalettes.cmd