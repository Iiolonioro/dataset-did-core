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
  for coll in index intro; do
    DIR=$JEKYLL/collections/_$coll
    rm -rf $DIR
    mkdir -p $DIR
  done;

  for COMMIT_HASH in $COMMIT_LIST; do
    DB_DIR=key-value
    . $KBASH/kv-sh/kv-sh
    COMMIT_TIMESTAMP=$(kvget COMMIT_TIMESTAMP)

    cd $GITINFO/$COMMIT_HASH
    echo cd $GITINFO/$COMMIT_HASH
    echo $PWD
    ls -al

    DIR=$JEKYLL/collections/_index
    FILE=$DIR/$COMMIT_TIMESTAMP.md
    echo "---" > $FILE
    cat ./env.yml >> $FILE
    echo "---" >> $FILE
    echo "" >> $FILE
    cat ./index.md >> $FILE
    echo Built $FILE

    DIR=$JEKYLL/collections/_intro
    FILE=$DIR/$COMMIT_TIMESTAMP.md
    echo "---" > $FILE
    cat ./env.yml >> $FILE
    echo "---" >> $FILE
    echo "" >> $FILE
    cat ./intro.txt >> $FILE
    echo Built $FILE

  done
)
