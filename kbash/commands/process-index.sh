#!/bin/bash
# Explode information from git repository

print_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT COMPONENT_NAME info${NC}

Info about ENTRYPOINT COMPONENT_NAME

EOF
`\n"
}

process_index() (
	# extract checkout data
	HASHDIR=$GITINFO/$COMMIT_HASH
	cd $HASHDIR

	kbash_info "Soup and NLTK for index.html in $COMMIT_HASH "
	set -e
	mkdir index
  cp snapshot/index.html index/index.html
	cd index
	python3 $DIDCORE/python/soup.py
	html2text < index.html > index.md

	cat abstract.txt > intro.txt
	echo "\n" >> intro.txt
	cat sotd.txt >> intro.txt

	sha256sum < abstract.txt > abstract.hash &
	sha256sum < sotd.txt > sotd.hash &
	sha256sum < intro.txt > intro.hash &
	sha256sum < toc.md > toc.hash &

	python3 $DIDCORE/python/spacy_anal.py abstract.txt > abstract-spacy.json &
	python3 $DIDCORE/python/spacy_anal.py sotd.txt > sotd-spacy.json &
	python3 $DIDCORE/python/spacy_anal.py intro.txt > intro-spacy.json &


	FILES=`find . -regex '\.\/[0-9]+.*\.txt' | sed s/.txt//g | colrm 1 2`
	for file in $FILES; do
		sha256sum < $file.txt > $file.hash &
		python3 $DIDCORE/python/spacy_anal.py $file.txt > $file-spacy.json &
	done
	cd ..

	kvrestore < key-value.dump
	echo "- date: $COMMIT_DATE
  time: $COMMIT_TIME
  hash: `cat index/intro.hash`" >> $INTROS
)

run() (
	kbash_info "Running process-index"
	cd $SOURCE
	if [ ! -z "$1" ]; then
		COMMIT_LIST=$1
	fi

	INTROS=$JEKYLL/_data/intros.yml
	echo "" > $INTROS
	for COMMIT_HASH in $COMMIT_LIST; do
		kbash_info "Processing index.html for hash $COMMIT_HASH in $(basename $SOURCE)"
		process_index &
	done
	wait
)
