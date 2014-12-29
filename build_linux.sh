#!/bin/sh

if [ ! -d Tacktx ]; then
    mkdir Tacktx
fi

cd src
zip -9 -q -r Tacktx.love .
cp -r * ../Tacktx
rm Tacktx.love  # remove binary .love file from src

echo "Tacktx installed to Tacktx/Tacktx.love"
echo "To run: love Tacktx"
