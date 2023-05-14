v() {
    file=$(fzf --preview 'bat --color=always --style=numbers {}')

    if [ -n "$file" ]; then
        nvim $file
    fi
}

lg() {
    count=$1

    if [ -z "$count" ]; then
        count=10
    fi

    git log --oneline --decorate --graph --all -n $count
}

gdiff() {
    sha=$1

    if [ -z "$sha" ]; then
        sha="HEAD"
    fi

    git diff -w $sha
}
