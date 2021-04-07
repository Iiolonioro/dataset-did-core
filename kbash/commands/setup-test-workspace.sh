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
	dc process-index
	kbash_info where is that kv-sh-env coming from
  dc prepare-for-jekyll
	dc build-launcher
	dc build-runnable-index
	#kbash_warn "Analyzing Absttracts"
  #dc analyze-abstracts
)
