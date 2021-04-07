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
      kbash_info "Adding $DATE $TIME"
      GITINFO=`cat gitinfo.txt`
      . $GITINFO/key-value.dump

      echo "---
title: DID Specification on $DATE at $TIME
layout: single
classes: wide
sidebar:
  - title: "Title"
    image: http://placehold.it/350x250
    image_alt: "image"
    text: "Some text here."
  - title: "Another Title"
    text: "More text here."
    nav: history
---
<iframe src=\"../index.html\" width=\"120%\" height=\"800\"></iframe>
" > ./launcher.md

      #ls -al
      echo "$YPREFIX- date: $DATE" >> $YML
      echo "$YPREFIX  time: $TIME" >> $YML
      echo "$YPREFIX  link: $COMMIT_RUNNABLE" >> $YML
      echo "$YPREFIX  message: $COMMIT_LINE" >> $YML
      cd ..
    done
    cd ..
  done
)
