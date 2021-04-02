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
  TARGET=$ANALYSIS/abstracts.csv
  YML=$JEKYLL/_data/abstracts.yml
  cd $RUNNABLE
  echo "abstracts:" > $YML
  for DATE in `ls`; do
    YPREFIX="  "
    echo "$YPREFIX- date:$DATE" >> $YML
    cd $DATE
    YPREFIX="    "
    for TIME in `ls`; do
      cd $TIME
      ls -al
      kvrestore < key-value.dump
      ABSTRACT_HASH=$(cat abstract.hash)
      echo "$YPREFIX- time:$TIME" >> $YML
      echo "$YPREFIX  hash:$ABSTRACT_HASH" >> $YML
      echo "$YPREFIX  commit:$COMMIT_HASH" >> $YML
    done
  done
)
