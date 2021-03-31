#!/bin/bash
activate_environment_dc_repo_help() {
printf "`cat << EOF
${BLUE}dc activate repo${NC}

EOF
`\n"
}
export -f activate_environment_dc_repo_help

activate_environment_dc_repo() {
  echo "Component[repo]:activate"
}
export -f activate_environment_dc_repo
