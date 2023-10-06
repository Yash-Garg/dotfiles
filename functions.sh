function v() {
    file=$(fzf --preview 'bat --color=always --style=numbers {}')

    if [ -n "$file" ]; then
        ${VISUAL:-${EDITOR:-nano}} $file
    fi
}

function lg() {
    count=$1

    if [ -z "$count" ]; then
        count=10
    fi

    git log --oneline --decorate --graph --all -n $count
}

function gdiff() {
    sha=$1

    if [ -z "$sha" ]; then
        sha="HEAD"
    fi

    git diff -w $sha
}

function cmb() {
    if [ -d .git ]; then
        git log --graph --color=always \
            --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
            fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
                --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show -w --color=always % | less -R') << 'FZF-EOF'
                {}
        FZF-EOF"
    else
        echo "not a git directory"
    fi
}
