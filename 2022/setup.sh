#!/bin/bash

while getopts d: flag
do
    case "${flag}" in
        d) DAY=${OPTARG};;
    esac
done
echo "Setting up Day ${DAY} directory...";

# make folder and populate with starter files
FOLDER=day_${DAY};
mkdir $FOLDER;

# create input and test files
CPP_SRC=${FOLDER}/day_${DAY}.cpp;
INPUT_FILE=${FOLDER}/input.txt;
TEST_FILE=${FOLDER}/test.txt;

touch $INPUT_FILE
touch $TEST_FILE

# initialize julia script with starter file
STARTER_FILE=./cpp_starter.cpp
[[ ! -f ${CPP_SRC} ]] && cp ${STARTER_FILE}  ${CPP_SRC};
[[ -f ${CPP_SRC} ]] && echo "File already exists - ${CPP_SRC}";

echo "Done"
