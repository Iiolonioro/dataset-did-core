#!/bin/bash
clean_environment_dc_repo_help() {
  printf "`cat << EOF
${BLUE}dc clean repo${NC}

EOF
`\n"
}
export -f clean_environment_dc_repo_help

clean_environment_dc_repo() {
  echo "Component[repo]:clean"
}
export -f clean_environment_dc_repo
