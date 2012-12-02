### Visual git diff on MAC

On linux systems I use `meld` for graphical diff tool. On MAC I just
started using [DiffMerge](http://www.sourcegear.com/diffmerge/) and I must say it does the job.

Here's your git configuration snippet.
~~~~
[alias]
    df = difftool -x /Applications/DiffMerge.app/Contents/MacOS/DiffMerge
    patch = diff --no-prefix

[difftool]
    prompt = false
~~~~

`git df` - visual diff  
`git diff` - console diff  
`git patch` - generate patch file

You can check my other post about [git configuration](/en/blog/git-config)
