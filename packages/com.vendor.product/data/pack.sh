#! /bin/sh

exe="ChineseChess"
des="/opt/Qt/QtIFW-3.2.2/examples/tutorial/packages/com.vendor.product/data"
deplist=$(ldd $exe | awk '{if (match($3,"/")){printf("%s "),$3}}')
cp $deplist $des
