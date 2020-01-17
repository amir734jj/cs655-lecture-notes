#!/bin/bash

lab=$1
if [ -z "$lab" ]; then
  count=0
  for line in $(find lab*/*.marp.md); do
      (marp $line --pdf -o ${line%.marp.md}.pdf);
      count=$(($count+1));
  done;
  tput reset;
  printf "\nCompleted building %d files ...\n" $count;
else
  marp $1 --pdf -o $lab/note.pdf;
  printf "\nCompleted building %s\n" $lab;
fi
