### Configure your __GIT__

I think there is no point in advertising GiT - it's simply awesome!
But it's even more awesome if you configure it to fit your needs.

I like GUI, and I want to use it when I can. I also like to SSH to my
machines, and then I want to use plain and simple console output.

### Viewing diffs using GUI

Few month ago I come across a config which allows you to use meld
for `git diff`. And for a while it was good ... But one day I wanted
to make a simple `.patch` file, which turns out to be real pain without
disabling my handy meld config.

Now I have new better config which doesn't use external scripts and it's
all pure GIT.

~~~~
[alias]
    df = difftool -x meld
    patch = diff --no-prefix

[difftool]
    prompt = false
~~~~

And now I can simply use following commands
~~~~
git df // that will open meld and show current diff
git patch // to generate patch
git diff // to use plain and simple console diff when I'm ssh-ing
~~~~


### Colours

For some reason I didn't like the default colour scheme. It's really
easy to change it to whatever you want.

~~~~
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
~~~~


Here's my whole config file

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