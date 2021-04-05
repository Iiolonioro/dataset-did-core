#!/bin/bash
git submodule update --init --recursive
exec ./kbash/shell.sh 

