#!/bin/bash
build_environment_dc_repo_help() {
printf "`cat << EOF
${BLUE}dc build repo${NC}

EOF
`\n"
}
export -f build_environment_dc_repo_help

build_environment_dc_repo() {
  echo "Component[repo]:build"
}
export -f build_environment_dc_repo
