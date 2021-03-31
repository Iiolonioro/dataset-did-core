#!/bin/bash
setup_environment_dc_repo_help() {
printf "`cat << EOF
${BLUE}dc setup repo${NC}

EOF
`\n"
}
export -f setup_environment_dc_repo_help

setup_environment_dc_repo() {
  echo "Component[repo]:setup"
}
export -f setup_environment_dc_repo
