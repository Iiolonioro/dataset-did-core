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
  HASHDIR=$GITINFO/$COMMIT_HASH
  . $HASHDIR/key-value.dump
  env | grep COMMIT
  python3 $DIDCORE/python/create_jekyll_data.py $JEKYLL/_data/hashes/$COMMIT_HASH $HASHDIR
)

run() (

  for COMMIT_HASH in $COMMIT_LIST; do
    create_jekyll_data &
    done
  wait
)
