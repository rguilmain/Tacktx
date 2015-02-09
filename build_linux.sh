#!/bin/sh

if [ ! -d dist ]; then
    mkdir dist
fi

cd src
zip -9 -q -r Tacktx.love .
cp -r * ../Tacktx
rm Tacktx.love  # remove binary .love file from src

echo "Tacktx installed to dist/Tacktx.love"
echo "To run: love Tacktx"
