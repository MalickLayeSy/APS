#!/usr/bin/env bash

make
cd ..

for f in Samples1/*
do
   
    echo "	"
    echo $f
    cat $f
    echo
    APS1/prologTerm $f | swipl -s APS1/typeChecker.pl -g main_stdin
    if [ $? -eq 0 ]
    then
        APS1/eval $f
    fi
    echo "	"
    echo "	"
done
echo "__Nettoyage__"
cd APS1
make clean
cd ..
