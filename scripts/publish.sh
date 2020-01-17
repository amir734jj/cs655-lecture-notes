#!/bin/bash

datetime=$(date '+%m/%d/%Y %H:%M:%S');

git add .
git commit -m "improvement as of: $datetime"
git push