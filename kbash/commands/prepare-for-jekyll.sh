#!/bin/bash
# PUT ONE LINE DESCRIPTION OF extract-tocs HERE

print_help() {
printf "`cat << EOF
${BLUE}dc COMPONENT_NAME info${NC}

Info about dc COMPONENT_NAME

EOF
`\n"
}

create_jekyll_data() (
  kbash_info "Creating Jekyll Data for $COMMIT_HASH"
  mkdir -p $JEKYLL/_data/hashes
  python3 $DIDCORE/python/create_jekyll_data.py $JEKYLL/_data/hashes/$COMMIT_HASH $GITINFO/$COMMIT_HASH
)
create_collections() (
  kbash_info "Creating Jekyll Collections"

  DIR=$JEKYLL/collections/_index
  FILE=$DIR/$COMMIT_TIMESTAMP.md
  echo "---" > $FILE
  cat ./env.yml >> $FILE
  echo "---" >> $FILE
  echo "" >> $FILE
  cat ./index/index.md >> $FILE
  kbash_info Built $FILE

  DIR=$JEKYLL/collections/_intro
  FILE=$DIR/$COMMIT_TIMESTAMP.md
  python3 $DIDCORE/python/build-collection-file.py "$FILE"
  kbash_info Built $FILE
)

run() (
  for coll in index intro; do
    DIR=$JEKYLL/collections/_$coll
    rm -rf $DIR
    mkdir -p $DIR
  done;

  for COMMIT_HASH in $COMMIT_LIST; do
    COMMIT_TIMESTAMP=$(kvget COMMIT_TIMESTAMP)

    HASHDIR=$GITINFO/$COMMIT_HASH
    kvrestore < $HASHDIR/key-value.dump
    cd $HASHDIR

    #create_collections &
    create_jekyll_data &
    done
  wait
)
