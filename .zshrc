# Lines configured by zsh-newuser-install
HISTSIZE=500
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch hist_ignore_all_dups
autoload -U compinit
compinit
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install

# Get special keys going
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# In case the above special keys solution didn't work
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Set the prompt - user@host directory, % = normal, # = privileged
autoload -U colors && colors
autoload -U promptinit
promptinit
PROMPT='%F{green}[%n@%M %c]%#%f%F{yellow} '
#PROMPT='%F{green}[local %c]%#%f%F{magenta} '
preexec () { echo -ne "\e[0m" }

# Source alias file
[[ -f ~/.aliases ]] && source ~/.aliases

# Add ssh-identities
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s` &>/dev/null
    ssh-add ~/.ssh/git_ssh &>/dev/null
    ssh-add ~/.ssh/cedar_key &>/dev/null
fi


# Run Dropbox
# ~/.dropbox-dist/dropboxd > /dev/null  
PATH=$HOME/aur/bibutils/src/bibutils_5.6/bin:$HOME/.cabal/bin:$HOME/bin:$HOME/aur/matlab/bin:$PATH

# Fix WSL bug for Mathematica
export KMP_AFFINITY=disabled
export PERL_DESTRUCT_LEVEL=2

# automatically cd upon ls-ing
#function cd {
#    builtin cd "$@" && ls
#}

# make c cd and ls
function chpwd() {
    emulate -L zsh
    ls -a
}

# adjust backlight brightness
function blight() {
echo $1 | sudo tee /sys/class/backlight/intel_backlight/brightness
}

# automatically cd after mv
function mc() {
mv $@ && cd ${(P)#}
}

# add to public directory
function http() {
    chmod a+r $1
    addr="$(pwd)"
    ln -s $addr/$1 ~/public
}

# convert .ris to .bib
function makebib() {
    cat $1 | ris2xml | xml2bib
}

# open last file with pdf
function pp() {
    temp=$(ls -tr | grep ".pdf" | tail -n1)
    echo $temp
    pdf $temp &
}

# open last file with okular 
function oo() {
    temp=$(ls -tr | grep ".pdf" | tail -n1)
    echo $temp
    okular $temp &> /dev/null &
}

# open last file with vim 
function vv() {
    temp=$(ls -tr *.(tex|md|py) | tail -n1)
    echo $temp
    vim $temp
}

# open last file with vim 
function ccc() {
    temp=$(ls -tr *.(tex|md|py|bib|ris) | tail -n1)
    echo $temp
    cat $temp
}

# save temp directory
function S() {
    temp=`$(echo pwd)`
    echo $temp > /home/eric/.current_dir
}

function s() {
    temp=`$(echo cat /home/eric/.current_dir)`
    cd $temp
}

# save temp directory
function SS() {
    temp=`$(echo pwd)`
    echo $temp > /home/eric/.current_dir2
}

function ss() {
    temp=`$(echo cat /home/eric/.current_dir2)`
    cd $temp
}

# save temp directory
function SSS() {
    temp=`$(echo pwd)`
    echo $temp > /home/eric/.current_dir3
}

function sss() {
    temp=`$(echo cat /home/eric/.current_dir3)`
    cd $temp
}

# create run file automatically
function RR() {
    var='#!/bin/bash\n./'
    var+=$1
    echo $var > run
    chmod u+x run
    chmod u+x $1
}

# create templated markdown file
function vmd() {
    touch $1
    echo '---' >> $1
    echo 'title:' >> $1
    echo 'author: Eric Jones' >> $1
    echo '#format: beamer' >> $1
    echo '#header-includes:' >> $1
    echo "#- bslash.usepackage[]{algorithm2e}" >> $1
    echo '...' >> $1
    vim $1
}


clear

# Created by `pipx` on 2024-06-03 04:26:29
export PATH="$PATH:/home/eric/.local/bin"
