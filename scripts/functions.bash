die() {
	# (rc, message...)
	rc="${1:-1}"
	shift 1
	if [[ $# -gt 0 ]]; then
		msg="$*"
	else
		msg="Call to die() without message"
	fi
	echo -e >&2 "\nFATAL: $msg\n"
	exit $rc
}
	


need_command() {
	if command -v "$1" >/dev/null; then
		return 0
	else
		die 2 "The command '$1' is required, and cound not be found"
	fi

}
