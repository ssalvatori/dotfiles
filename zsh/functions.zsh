extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}


prompt_green() {
    if is_zsh; then
        echo "%F{green}$@%f"
    else
        echo -e "\e[1;32m$@\e[0m"
    fi
}

prompt_red() {
    if is_zsh; then
        echo "%F{red}$@%f"
    else
        echo -e "\e[1;31m$@\e[0m"
    fi
}

prompt_blue() {
    if is_zsh; then
        echo "%F{blue}$@%f"
    else
        echo -e "\e[1;34m$@\e[0m"
    fi
}

echo_red() {
    echo -e "\e[1;31m$@\e[0m"
}

source_package() {
	for it in $@; do
	    if [ -f $it ]; then
		    source $it
	    else
		    echo_red "Cannot find $it"
	    fi
	done
}
