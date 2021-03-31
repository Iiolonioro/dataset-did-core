#!/bin/bash
clean_environment_dc_jekyll_help() {
  printf "`cat << EOF
${BLUE}dc clean jekyll${NC}

EOF
`\n"
}
export -f clean_environment_dc_jekyll_help

clean_environment_dc_jekyll() {
  echo "Component[jekyll]:clean"
}
export -f clean_environment_dc_jekyll
