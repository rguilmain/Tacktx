#!/bin/sh

echo -n "Installing Tacktx to dist directory ... "

if [ ! -d dist ]; then
    mkdir dist
fi

cd ../src
zip -9 -q -r Tacktx.love .
cp -r * ../build/dist
rm Tacktx.love  # remove binary .love file from src

echo "DONE"
echo ""
echo "To run:"
echo "  cd dist"
echo "  love Tacktx.love"
