#!/usr/bin/env bash
cd APS1a
make
cd ..

for f in Samples1a/*
do
    echo $f
    cat $f
    echo "   "
    echo " ______ PrologTerm _____"
    echo "   "
    APS1a/prologTerm $f
    echo
    echo "   "
    echo " ______ Typage  _______  "
    echo
    APS1a/prologTerm $f | swipl -s APS1a/typeChecker.pl -g main_stdin
    if [ $? -eq 0 ]
    then
        echo "   "
        echo " ______ Eval _______  "
        APS1a/eval $f
    fi
    echo "   "
    echo "   "
done

cd APS1a
make clean
cd ..