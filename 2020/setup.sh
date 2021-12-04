#!/bin/bash


while getopts d: flag
do 
    case "${flag}" in
        d) day=${OPTARG};;
    esac
done
echo "Setting up Day $day directory...";

# make folder and populate with starter files
folder=day_$day/;
mkdir $folder;

# create input and test files
julia_script=${folder}/day_${day}.jl;
input_file=${folder}/input.txt;
test_file=${folder}/test.txt;

touch $input_file
touch $test_file
# touch $julia_script

# initialize julia script with starter file
starter_file=./julia_starter.jl
[[ ! -f $julia_script ]] && cp ${starter_file}  ${julia_script};
[[ -f $julia_script ]] && echo "File already exists - ${julia_script}";

echo "Done"
