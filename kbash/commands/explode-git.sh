#!/bin/bash
# Explode information from git repository

print_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT COMPONENT_NAME info${NC}

Info about ENTRYPOINT COMPONENT_NAME

EOF
`\n"
}

run_git_commands_and_create_snapshot() (
	cd $SOURCE
	COMMIT_DIR="$GITINFO/$COMMIT_HASH"
	mkdir -p "$COMMIT_DIR"

	# get the patch and extract the patch info
	HASHINFO=$COMMIT_DIR/fullpatch.txt
	HASHHEADER=$COMMIT_DIR/header.txt
	git show --format=raw > $HASHINFO
	cat $HASHINFO | sed '/^$/q' > $HASHHEADER

	# create a runnable snapshot
	mkdir -p $COMMIT_DIR/snapshot
	cp -r $SOURCE/* $COMMIT_DIR/snapshot

	# get the commit full timestamp
	git show --pretty='format:%cI' --no-patch > $COMMIT_DIR/commit-full-timestamp.txt

	# not handling notes correctly
  echo "git notes show $COMMIT_HASH" > $COMMIT_DIR/commit-notes.txt

	# get the single oneline descriptio0n
	git show --format=oneline --no-patch | colrm 1 41 | sed -e "s/,/COMMA/g" | sed -e 's/"/QUOTE/g' > $COMMIT_DIR/oneline.txt
	# get the single oneline descriptio0n
	git show --show-signature > $COMMIT_DIR/gpg-signature.txt
)

extract_commit_data() (
	# extract checkout data
	HASHDIR=$GITINFO/$COMMIT_HASH
	cd $HASHDIR

	COMMIT_AUTHOR=`cat header.txt | grep -e "^author" | colrm 1 7`
	COMMIT_COMMITTER=`cat header.txt | grep -e "^committer" | colrm 1 10`
	COMMIT_PARENT=`cat header.txt | grep -e "^parent" | colrm 1 7`
	COMMIT_TREE=`cat header.txt | grep -e "^tree" | colrm 1 5`

	COMMIT_FULL_TIMESTAMP=`cat commit-full-timestamp.txt`
	COMMIT_DATE=`date -Idate -u -d "$COMMIT_FULL_TIMESTAMP" | sed s/+00:00//g`
	COMMIT_TIME=`date +"%T" -u -d "$COMMIT_FULL_TIMESTAMP"`
	COMMIT_TIMESTAMP=`date -Iseconds -u -d "$COMMIT_FULL_TIMESTAMP" | sed s/+00:00//g`
	COMMIT_NOTES=`cat commit-notes.txt`

	COMMIT_LINE=`cat oneline.txt`

  # make /runnable/date/time -> gitinfo/snapshot
	RDIR="$RUNNABLE/$COMMIT_DATE"
	LINK="$RDIR/$COMMIT_TIME"
	mkdir -p $RDIR
	rm -rf $LINK
	ln -s $HASHDIR/snapshot $LINK
	COMMIT_RUNNABLE="static/runnable/$COMMIT_DATE/$COMMIT_TIME/launcher"
	echo $HASHDIR > $LINK/gitinfo.txt

	# save environment
	echo $COMMIT_HASH > commit.txt
	echo "#`date -u`" > env.yml
	echo "commit:" >> env.yml
	DB_DIR=key-value
  . $KBASH/kv-sh/kv-sh
	kvset CREATE_TIME "`date -u`"
	for var in COMMIT_HASH COMMIT_AUTHOR COMMIT_COMMITTER COMMIT_PARENT COMMIT_TREE COMMIT_DATA COMMIT_DATE COMMIT_TIME COMMIT_TIMESTAMP COMMIT_LINE COMMIT_RUNNABLE; do
		X=${!var}
		kvset $var "$X"
		echo "  $var: \"${!var}\"" >> $HASHDIR/env.yml
	done
	kvdump > key-value.dump
	kbash_info "Created key-value.dump and env.yml for hash $COMMIT_HASH"
)

run() (
	kbash_info "Running explode-git"
	cd $SOURCE
	if [ ! -z "$1" ]; then
		COMMIT_LIST=$1
	fi

	for COMMIT_HASH in $COMMIT_LIST; do
		kbash_info "Exporting commit data for hash $COMMIT_HASH in $(basename $SOURCE)"
		cd $SOURCE
		git checkout $COMMIT_HASH >/dev/null 2>&1


		run_git_commands_and_create_snapshot
		extract_commit_data
	done
	wait
)
