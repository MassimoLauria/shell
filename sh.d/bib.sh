#/bin/sh

#
# Shell command to open a PDF looking among by bibtex entries
#

LS=bibtex-ls
BIBFILE=$HOME/lavori/latex/texmf-private/bibtex/bib/theoryofcomputing.bib
TMPLS=`mktemp`


function _bib_check_runtime() {
    local fail=0

    type $LS >/dev/null 2>&1 ||
        { echo >&2 "Required '$(basename $LS)' command is missing. Run ";
          echo >&2 "    $ go get github.com/msprev/fzf-bibtex/cmd/bibtex-ls"
          echo >&2 "    $ go install github.com/msprev/fzf-bibtex/cmd/bibtex-ls"
          fail=1; }

    type fzf >/dev/null 2>&1 ||
        { echo >&2 "Required 'fzf' command is missing."; fail=1; }

    local server_running=`emacsclient -e '(server-running-p)'`
    if [ $server_running = "nil" ]; then
        echo >&2 "Emacs server is not running. Please start it."
        fail=1
    fi
    return fail
}


function bibpreview () {
    local key='$key'
    bibtool -- "select{$key \"$1\"}" -q -i $BIBFILE  2>|/dev/null | grep -v "@STRING"
    }

function bib () {
    _bib_check_runtime || return 1
    
    # Initial query
    local query=""

    if [ "$#" -ge 1 ]; then
        query="-q $@"
    fi

    # Choose file and build command line
    $LS $BIBFILE | fzf -d'@' -e --reverse --ansi $query |
        awk -F '@' 'BEGIN { printf "(bibtex-completion-open-pdf (list " } {printf " \""$2"\"" } END { printf("))")}' > $TMPLS

    emacsclient -e "(load-file \"$TMPLS\")" >/dev/null
    rm -f $TMPLS
}





