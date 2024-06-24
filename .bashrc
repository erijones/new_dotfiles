# coloring for files and directories
alias ls='ls --color=auto' # for mac it should be alias ls='ls -G'

# list files backwards in time since last edit
alias lt='ls -cltrh'

# open the last text file you edited with vim
function vv() {
    temp=$(ls -tr *.tex *.py *.md | tail -n1)
    echo $temp
    vim $temp
}

# open last pdf file you edited with a pdf viewer
function pp() {
    temp=$(ls -tr | grep ".pdf" | tail -n1)
    echo $temp
    evince $temp
}


