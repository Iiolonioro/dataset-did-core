#!/bin/bash
# Functions support ENTRYPOINT commands
set -a

dir_resolve()
{
cd "$1" 2>/dev/null || return $?  # cd to desired directory; if fail, quell any error messages but return exit status
echo "`pwd -P`" # output full, link-resolved path
}

SOURCE=$DIDCORE/did-core
mkdir -p $DIDCORE/analysis
ANALYSIS=`dir_resolve $DIDCORE/analysis`
RUN_TIMESTAMP=`date -u -Is`

FILE_LIST="index terms"

KEYWORDS=$ANALYSIS/keywords
MARKDOWN=$ANALYSIS/markdown
GITINFO=$ANALYSIS/gitinfo
JEKYLL=$DIDCORE/jekyll-src
HISTORY=$ANALYSIS/history
RUNNABLE=$ANALYSIS/runnable

SUMMARY=$KEYWORDS/summary.csv
if [ -f "$ANALYSIS/commit-list.txt" ]; then
  COMMIT_LIST=$(cat $ANALYSIS/commit-list.txt)
else
  kbash_warn "no commit-list.txt found, consider running reset-workspace next"
fi
