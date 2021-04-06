#!/bin/bash
# Explode information from git repository

print_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT COMPONENT_NAME info${NC}

Info about ENTRYPOINT COMPONENT_NAME

EOF
`\n"
}

process_commit_files_in_active_singleton_checkout() (
	cd $SOURCE
	COMMIT_DIR="$GITINFO/$COMMIT_HASH"
	mkdir -p "$COMMIT_DIR"
	HASHINFO=$COMMIT_DIR/hashinfo.txt
	HASHHEADER=$COMMIT_DIR/hashheader.txt

	git show --format=raw > $HASHINFO
	cat $HASHINFO | sed '/^$/q' > $HASHHEADER
	mkdir -p $COMMIT_DIR/snapshot
	cp -r $SOURCE/* $COMMIT_DIR/snapshot

	git show --pretty='format:%cI' --no-patch > $COMMIT_DIR/commit-data.txt
	echo "git notes show $COMMIT_HASH" > $COMMIT_DIR/commit-notes.txt
	git show --format=oneline --no-patch | colrm 1 41 | sed -e "s/,/COMMA/g" | sed -e 's/"/QUOTE/g' > $COMMIT_DIR/oneline.txt
)

process_abstract() (
set -e
cd snapshot
python3 $DIDCORE/python/abstract.py > ../abstract.txt
python3 $DIDCORE/python/sotd.py > ../sotd.txt
cd ..
cat abstract.txt > intro.txt
echo "\n" >> intro.txt
cat sotd.txt >> intro.txt

sha256sum < abstract.txt > abstract.hash
sha256sum < sotd.txt > sotd.hash
sha256sum < intro.txt > intro.hash

	#python3 $DIDCORE/python/nlp.py abstract.txt > abstract.json
)
process_file() (
	local file=$1
	local hashdir=$2
	cd $hashdir
	kbash_info "Launching $PWD/snapshot/$file.html to $file.md conversion"
	html2text snapshot/$file.html > $file.md
	#kbash_info "Performing NLP analysis on $hashdir/$file.md"
	#python3 $DIDCORE/python/nlp.py $file.md > $file.json
)
process_term() (
	term="$1"
	fterm=`echo $term | sed s/\ /_/g`
	TAG="$fterm-$COMMIT_TIMESTAMP-$commit"
	DIR="$KEYWORDS/$fterm"
	mkdir -p $DIR

	COUNTS=""
	for file in $FILE_LIST; do
		echo "Processing '$term' in $file"
		RESULT_FILE=$DIR/$file-$TAG-matches-only.txt
		grep -i -n -e "$term" $file.html > $RESULT_FILE
		XCOUNTS=`cat $RESULT_FILE | wc | colrm 1 1 | awk '{ print $1","$2","$3 }'`
		COUNTS="$COUNTS,$XCOUNTS"
		RESULT_FILE=$DIR/$file-$TAG-with-context.txt
		grep -A 10 -B 10 -i -n -e "$term" $file.html > $RESULT_FILE
	done

	echo "$term,$COMMIT_DATE,$COMMIT_TIME,$COMMIT_TIMESTAMP$COUNTS,$COMMIT_HASH,\"$COMMIT_LINE\",'LINK',$COMMIT_RUNNABLE,$COMMIT_AUTHOR,$COMMIT_COMMITTER,$COMMIT_NOTES" > summary.csv
	kbash_info "$commit \"$term\", with DATE=$COMMIT_DATE, TIME=$COMMIT_TIME"
)

extract_commit_data() (
	# extract checkout data
	HASHDIR=$GITINFO/$COMMIT_HASH
	cd $HASHDIR

	COMMIT_AUTHOR=`cat hashheader.txt | grep -e "^author" | colrm 1 7`
	COMMIT_COMMITTER=`cat hashheader.txt | grep -e "^committer" | colrm 1 10`
	COMMIT_PARENT=`cat hashheader.txt | grep -e "^parent" | colrm 1 7`
	COMMIT_TREE=`cat hashheader.txt | grep -e "^tree" | colrm 1 5`

	COMMIT_DATA=`cat commit-data.txt`
	COMMIT_DATE=`date -Idate -u -d "$COMMIT_DATA" | sed s/+00:00//g`
	COMMIT_TIME=`date +"%T" -u -d "$COMMIT_DATA"`
	COMMIT_TIMESTAMP=`date -Iseconds -u -d "$COMMIT_DATA" | sed s/+00:00//g`
	COMMIT_NOTES=`cat commit-notes.txt`

	COMMIT_LINE=`cat oneline.txt`


	RDIR="$RUNNABLE/$COMMIT_DATE"
	LINK="$RDIR/$COMMIT_TIME"
	mkdir -p $RDIR
	rm -rf $LINK
	ln -s $HASHDIR/snapshot $LINK
	ln -s $LINK/gitinfo $HASHDIR
	COMMIT_RUNNABLE="static/runnable/$COMMIT_DATE/$COMMIT_TIME/launcher"

	echo $PWD
	ls -al .

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

	process_abstract &

	for file in $FILE_LIST; do
	  process_file "$file" "$HASHDIR" &
	done
	wait

)

run() (
	kbash_info "Running explode-git"
	cd $SOURCE
	if [ ! -z "$1" ]; then
		COMMIT_LIST=$1
	fi

	for COMMIT_HASH in $COMMIT_LIST; do
		kbash_info "Processing hash $COMMIT_HASH in $(basename $SOURCE)"
		cd $SOURCE
		git checkout $COMMIT_HASH >/dev/null 2>&1
		process_commit_files_in_active_singleton_checkout
		extract_commit_data
	done
	wait
)
