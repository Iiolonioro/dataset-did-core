#!/bin/bash
# Reset File

print_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT COMPONENT_NAME info${NC}

Info about ENTRYPOINT COMPONENT_NAME

EOF
`\n"
}

run() (
	dc backup-analysis

	#set up virgin directories for exploding a git repository
	rm -rf $ANALYSIS
	for dir in $RUNNABLE $GITINFO; do
		mkdir -p $dir
		done

	for file in $FILE_LIST; do
		mkdir -p $HISTORY/$file
		mkdir -p $JEKYLL/$file
	done

	# generate commit list
	cd $SOURCE
	git stash
	git pull origin main
	git checkout main >/dev/null 2>&1
	git log --pretty=format:%H | tail -n 5 > $ANALYSIS/commit-list.txt

  dc explode-git
	kbash_warn "Preparing for jekyll"
  dc prepare-for-jekyll
	#kbash_warn "Analyzing Absttracts"
  #dc analyze-abstracts
)