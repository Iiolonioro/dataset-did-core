#!/bin/bash
# Refresh

print_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT COMPONENT_NAME info${NC}

Info about ENTRYPOINT COMPONENT_NAME

EOF
`\n"
}

run() (
dc reset-workspace
dc explode-git
dc convert-to-markdown
dc extract-abstracts
dc extract-tocs
dc prepare-for-jekyll
)
