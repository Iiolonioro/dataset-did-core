#!/bin/bash
activate_environment_dc_jekyll_help() {
printf "`cat << EOF
${BLUE}dc activate jekyll${NC}

EOF
`\n"
}
export -f activate_environment_dc_jekyll_help

activate_environment_dc_jekyll() {
  echo "Component[jekyll]:activate"
}
export -f activate_environment_dc_jekyll
