mkdir dist
third_party\7zip\7za.exe a -tzip dist\Tacktx.love .\src\*
copy /b third_party\love\love.exe+dist\Tacktx.love dist\Tacktx.exe
erase dist\Tacktx.love
xcopy /y third_party\love\*.dll dist
xcopy /y third_party\love\license.txt dist
