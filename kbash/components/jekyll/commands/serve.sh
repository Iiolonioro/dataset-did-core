#!/bin/bash
# view docs

print_help() {
printf "`cat << EOF
${BLUE}dc jekyll info${NC}

Info about dc jekyll

EOF
`\n"
}

run() (
  bundle exec jekyll serve
)
