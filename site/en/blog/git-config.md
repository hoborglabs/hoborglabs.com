# Git Configuraiton

~~~~
[core]
    editor = vim

[user]
    name = Lorme Ipsum
    email = lorem.ipsum@dolor.com

[push]
    default = current

[color]
    ui = auto

[color "branch"]
    current = yellow reverse
    local = yellow
    remote = green

[color "diff"]
    meta = yellow bold
    frag = magenta bold
    old = red bold
    new = green bold
    whitespace = red reverse

[color "status"]
    added = yellow
    changed = green
    untracked = cyan

[alias]
    st = status
    ci = commit
    br = branch
    co = checkout
    df = difftool -x meld
    patch = diff --no-prefix
    lg = log -p
    lol = log --graph --decorate --pretty=oneline --abbrev-commit
    lola = log --graph --decorate --pretty=oneline --abbrev-commit --all
    ls = ls-files

    #ticket stuff
    tkt-checkout = "!f() { git checkout tkt-$1 ; }; f"
    tkt-merge = "!f() { git merge --no-ff --no-commit remotes/origin/tkt-$1 ; }; f"
    tkt-merge-cancel = reset --hard
    tkt-merge-undo = reset --hard ORIG_HEAD
    tkt-branch = "!f() { git branch -a | grep --colour=never 'tkt-' ; }; f"
    tkt-create = "!f() { git push origin $1:refs/heads/tkt-$2 ; git fetch origin ; git checkout --track -b tkt-$2 origin/tkt-$2 ; }; f"

[difftool]
    prompt = false
~~~~