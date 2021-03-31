#!/bin/bash


export GITREPO_BASE=$DIDCORE/repo
export GITREPO_NODE_VERSION=
export GITREPO_NODE_MODULES=$GITREPO_BASE/node_modules

export GITREPO_LERNA_PACKAGES=$GITREPO_BASE/packages

export GITREPO_PYTHON_VERSION=
export GITREPO_VENV=$GITREPO_BASE/venv

export GITREPO_LOG=$GITREPO_BASE/setup-logs

oneline_description_of_dc_repo() {
  echo "Description of repo"
}
export -f oneline_description_of_dc_repo

vet_environment_dc_repo() {
  echo "Component[repo]:vet"
}
export -f vet_environment_dc_repo

describe_environment_dc_repo_help() {
printf "`cat << EOF
${BLUE}dc describe repo${NC}

EOF
`\n"
}
export -f describe_environment_dc_repo_help

describe_environment_dc_repo() {
  echo "Component[repo]:describe"

  report_vars "repo Build Environment" \
      GITREPO_BASE\
      GITREPO_NODE_VERSION\
      GITREPO_PYTHON_VERSION
}
export -f describe_environment_dc_repo
