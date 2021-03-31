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
  for COMMIT_HASH in $COMMIT_LIST; do
    local BASE=$GITINFO/$COMMIT_HASH
    . $BASE/env.sh # activate the local environment
    kbash_info "Processing hash $COMMIT_HASH"
    ABSTRACT_HASH=$(sha256sum < abstract.txt)
    ABSTRACT_TEXT="$(cat abstract.txt)"
    kbash_info "Processing hash $COMMIT_HASH - abstract hash is $ABSTRACT_HASH"
  done
  wait
)
