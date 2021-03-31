#!/bin/bash
build_environment_dc_jekyll_help() {
printf "`cat << EOF
${BLUE}dc build jekyll${NC}

EOF
`\n"
}
export -f build_environment_dc_jekyll_help

build_environment_dc_jekyll() {
  echo "Component[jekyll]:build"
}
export -f build_environment_dc_jekyll
