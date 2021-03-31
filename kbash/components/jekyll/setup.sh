#!/bin/bash
setup_environment_dc_jekyll_help() {
printf "`cat << EOF
${BLUE}dc setup jekyll${NC}

EOF
`\n"
}
export -f setup_environment_dc_jekyll_help

setup_environment_dc_jekyll() {
  echo "Component[jekyll]:setup"
}
export -f setup_environment_dc_jekyll
