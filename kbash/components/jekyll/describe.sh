#!/bin/bash


export REPOJEKYLL_BASE=$DIDCORE/jekyll
export REPOJEKYLL_NODE_VERSION=
export REPOJEKYLL_NODE_MODULES=$REPOJEKYLL_BASE/node_modules

export REPOJEKYLL_LERNA_PACKAGES=$REPOJEKYLL_BASE/packages

export REPOJEKYLL_PYTHON_VERSION=
export REPOJEKYLL_VENV=$REPOJEKYLL_BASE/venv

export REPOJEKYLL_LOG=$REPOJEKYLL_BASE/setup-logs

oneline_description_of_dc_jekyll() {
  echo "Description of jekyll"
}
export -f oneline_description_of_dc_jekyll

vet_environment_dc_jekyll() {
  echo "Component[jekyll]:vet"
}
export -f vet_environment_dc_jekyll

describe_environment_dc_jekyll_help() {
printf "`cat << EOF
${BLUE}dc describe jekyll${NC}

EOF
`\n"
}
export -f describe_environment_dc_jekyll_help

describe_environment_dc_jekyll() {
  echo "Component[jekyll]:describe"

  report_vars "jekyll Build Environment" \
      REPOJEKYLL_BASE\
      REPOJEKYLL_NODE_VERSION\
      REPOJEKYLL_PYTHON_VERSION
}
export -f describe_environment_dc_jekyll
