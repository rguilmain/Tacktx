mkdir Tacktx
third_party\7zip\7za.exe a Tacktx\Tacktx.zip .\src\*
cd Tacktx
rename Tacktx.zip Tacktx.love
cd ..
copy /b third_party\love\love.exe+Tacktx\Tacktx.love Tacktx\Tacktx.exe
erase Tacktx\Tacktx.love
xcopy /y third_party\love\*.dll Tacktx
xcopy /y third_party\love\license.txt Tacktx
