#!/usr/bin/env bash
cd APS3
make
cd ..

for f in Samples3/*
do
    echo $f
    cat $f
    echo "   "
    echo " ______PrologTerm ___  "
    echo "   "
    APS3/prologTerm $f
    echo
    echo "   "
    echo " ______ Typage  _______  "
    echo
    APS3/prologTerm $f | swipl -s APS3/typeChecker.pl -g main_stdin
    if [ $? -eq 0 ]
    then
        echo "   "
        echo "______ Eval _______"

        APS3/eval $f
    fi
    echo "___END___ "
    echo "  "
done
echo "__Nettoyage__"
cd APS3
make clean
cd ..