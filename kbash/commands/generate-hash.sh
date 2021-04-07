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
    echo -n `sha256sum | sed "s/  -\$//g"`
)
