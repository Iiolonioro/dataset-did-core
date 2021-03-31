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
  for date in `ls`; do
    cd $RUNNABLE/$date
    for time in `ls`; do
      cd $RUNNABLE/$date/$time
      for file in $FILE_LIST; do
        html2text < $file.html > $GITINFO/$COMMIT_HASH/$file.md &
      done
    done
  done
  wait
)
