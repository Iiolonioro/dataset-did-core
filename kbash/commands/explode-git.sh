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
	for file in $FILE_LIST; do
		cp $file.html $COMMIT_DIR
	done

	RDIR="$RUNNABLE/$COMMIT_DATE/$COMMIT_TIME"
	mkdir -p "$RDIR"
	COMMIT_RUNNABLE="file://$RDIR/index.html"
	cp *.* $RDIR
	echo $COMMIT_HASH > $RDIR/commit.txt
	rm -f $RDIR/hash_analysis
	ln -s $GITINFO/$COMMIT_HASH $RDIR/hash_analysis

	git show --pretty='format:%cI' --no-patch > $COMMIT_DIR/commit-data.txt
	echo "git notes show $COMMIT_HASH" > $COMMIT_DIR/commit-notes.txt
	git show --format=oneline --no-patch | colrm 1 41 | sed -e "s/,/COMMA/g" | sed -e 's/"/QUOTE/g' > $COMMIT_DIR/oneline.txt
)

process_abstract() (
	python3 $DIDCORE/python/abstract.py > abstract.txt
	python3 $DIDCORE/python/nlp.py abstract.txt > abstract.json
)
process_file() (
	local file=$1
	html2text $file.html > $file.md
	python3 $DIDCORE/python/nlp.py $file.md > $file.json
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
		grep -i -n -e "$term" index.html > $RESULT_FILE
		XCOUNTS=`cat $RESULT_FILE | wc | colrm 1 1 | awk '{ print $1","$2","$3 }'`
		COUNTS="$COUNTS,$XCOUNTS"
		RESULT_FILE=$DIR/$file-$TAG-with-context.txt
		grep -A 10 -B 10 -i -n -e "$term" index.html > $RESULT_FILE
	done

	echo "$term,$COMMIT_DATE,$COMMIT_TIME,$COMMIT_TIMESTAMP$COUNTS,$COMMIT_HASH,\"$COMMIT_LINE\",'LINK',$COMMIT_RUNNABLE,$COMMIT_AUTHOR,$COMMIT_COMMITTER,$COMMIT_NOTES" > summary.csv
	kbash_info "$commit \"$term\", with DATE=$COMMIT_DATE, TIME=$COMMIT_TIME"
)
extract_commit_data() (
	# extract checkout data
	cd $GITINFO/$COMMIT_HASH

	COMMIT_AUTHOR=`cat hashheader.txt | grep -e "^author" | colrm 1 7`
	COMMIT_COMMITTER=`cat hashheader.txt | grep -e "^committer" | colrm 1 10`
	COMMIT_PARENT=`cat hashheader.txt | grep -e "^parent" | colrm 1 7`
	COMMIT_TREE=`cat hashheader.txt | grep -e "^tree" | colrm 1 5`

	COMMIT_DATA=`cat commit-data.txt`
	COMMIT_DATE=`date -Idate -u -d "$COMMIT_DATA" | sed s/+00:00//g`
	COMMIT_TIME=`date +"%T" -u -d "$COMMIT_DATA"`
	COMMIT_TIMESTAMP=`date -Iminutes -u -d "$COMMIT_DATA" | sed s/+00:00//g`
	COMMIT_NOTES=`cat commit-notes.txt`

	COMMIT_LINE=`cat oneline.txt`

	for var in COMMIT_AUTHOR COMMIT_COMMITTER; do
		echo "\$"$var
	done

	for file in $FILE_LIST; do
		#kbash_info "Launching $PWD/$file.html to $file.md conversion"
	  process_file "$file" &
	done

	#kbash_info "Genearting abstracts and tocs in $PWD"
	python3 $DIDCORE/python/toc.py > toc.txt &
	process_abstract &

	while IFS= read -r term; do
		process_term "$term" &
	done < ../termlist.txt

)

run() (
	kbash_info "Running explode-git"
	cd $SOURCE
	for COMMIT_HASH in $COMMIT_LIST; do
		kbash_info "Processing hash $COMMIT_HASH in $(basename $SOURCE)"
		cd $SOURCE
		git checkout $COMMIT_HASH >/dev/null 2>&1
		process_commit_files_in_active_singleton_checkout
		extract_commit_data &
	done
	wait
)
