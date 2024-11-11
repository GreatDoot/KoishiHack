@echo off

@cd %~dp0\png

@dir *.png /b > png.txt

for /f "tokens=*" %%m in (png.txt) do echo %%m

for /f "tokens=*" %%m in (png.txt) do ..\..\..\EventAssembler\Tools\Png2Dmp.exe %%m --lz77

echo ----------

@dir *.dmp /b > dmp.txt

for /f "tokens=*" %%m in (dmp.txt) do echo %%m

echo ----------

for /f "tokens=*" %%m in (dmp.txt) do move %%m "..\dmp\"%%m

@del png.txt

@del dmp.txt

echo Done!

pause