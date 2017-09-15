#!/bin/bash

cd ../dosbox-x/src
make -j8
exit

clear
fasm tester.asm
