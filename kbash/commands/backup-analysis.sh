#!/bin/bash
# backup analysis

print_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT COMPONENT_NAME info${NC}

Info about ENTRYPOINT COMPONENT_NAME

EOF
`\n"
}

run() (
	if [ -f "$ANALYIS" ]; then
		mkdir -p $DIDCORE/backup
		tar -czf $DIDCORE/backup/analysis-backup-${RUN_TIMESTAMP}.tgz $ANALYSIS
	fi
)
