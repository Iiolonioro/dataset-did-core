#!/bin/bash
# build an index out of hashes previous

print_help() {
printf "`cat << EOF
${BLUE}dc COMPONENT_NAME info${NC}

Runs this : sha256
EOF
`\n"
}

run() (
    python3 $DIDCORE/python/build_hash_index.py $JEKYLL/_data
)
