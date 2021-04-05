#!/bin/bash
# PUT ONE LINE DESCRIPTION OF extract-tocs HERE

print_help() {
printf "`cat << EOF
${BLUE}dc COMPONENT_NAME info${NC}

Info about dc COMPONENT_NAME

EOF
`\n"
}

run() (
  TARGET=$ANALYSIS/runnables.csv
  YML=$JEKYLL/_data/runnables.yml
  cd $RUNNABLE
  echo "" > $YML
  for DATE in `ls`; do
    YPREFIX=""
    cd $DATE
    for TIME in `ls`; do
      cd $TIME
      echo "---
title: DID Specification on $DATE at $TIME
layout: single
classes: wide
sidebar:
  nav: home
---
<iframe src=\"../snapshot/index.html\" width=\"120%\" height=\"800\"></iframe>
" > launcher.md

      #ls -al
      kbash_info "Adding $DATE $TIME"
      . key-value.dump
      ABSTRACT_HASH=$(cat abstract.hash)
      echo "$YPREFIX- date: $DATE" >> $YML
      echo "$YPREFIX  time: $TIME" >> $YML
      echo "$YPREFIX  link: $COMMIT_RUNNABLE" >> $YML
      echo "$YPREFIX  message: $COMMIT_LINE" >> $YML
      cd ..
    done
    cd ..
  done
)
