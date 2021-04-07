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
  cd $RUNNABLE
  for DATE in `ls`; do
    YPREFIX=""
    cd $DATE
    for TIME in `ls`; do
      cd $TIME
      kbash_info "Adding $DATE $TIME"
      GITINFO=`cat gitinfo.txt`
      . $GITINFO/key-value.dump

      echo "---
layout: single
classes: wide
sidebar:
  - title: DID Specification on $DATE at $TIME
    image: http://placehold.it/350x250
    image_alt: "image"
    text: "$COMMIT_LINE."
  - title: "Another Title"
    text: "More text here."
    nav: history
---
<iframe src=\"../index.html\" width=\"120%\" height=\"800\"></iframe>
" > ./launcher.md

      cd ..
    done
    cd ..
  done
)
