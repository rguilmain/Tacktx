mkdir Tacktx
third_party\7zip\7za.exe a -tzip Tacktx\Tacktx.love .\src\*
copy /b third_party\love\love.exe+Tacktx\Tacktx.love Tacktx\Tacktx.exe
erase Tacktx\Tacktx.love
xcopy /y third_party\love\*.dll Tacktx
xcopy /y third_party\love\license.txt Tacktx
