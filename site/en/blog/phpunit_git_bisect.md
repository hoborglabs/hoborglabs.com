### PHPUnit __testsuites__ and git __bisect__

Today I had a weird mistery to solve. How it turns out it was one of the unit 
test not beeing so unit after all and it was causing errors in other tests.

Long story short, it took me a while to realize that one of the 4000 tests is 
causing errors in some other test. With that I finally could replicate it on
my local machine.

#### enter testsuites and git bisect

When I finally realize what is going on, it was dead easy to find the commit
which introduced that error - the unfortunate build had more the 30 commits.

First step was to craft small phpunit.debug.xml which was running only two
test classes.

~~~~
&lt;phpunit bootstrap="./bootstrap.php"
    colors="true"
    backupGlobals="false"
    strict="true"
>
    &lt;testsuites>
        &lt;testsuite name="debug suite">
            &lt;file>src/Company/ModuleA/ClassTest.php&lt;/file>
            &lt;file>src/Company/ModuleB/ClassTest.php&lt;/file>
        &lt;/testsuite>
    &lt;/testsuites>
&lt;/phpunit>
~~~~

Second step was to use git bisect to find which commit broke the build. It's
super easy! that's the way I use it

checkout the last commit that passes our test, and tell git to start bisecting
process.
~~~~
git checkout 123abc
git bisect start
~~~~

Now we have to tell git whereabout did we introduced the bug. Let start with
sying that current version is good
~~~~
git bisect good
~~~~

By checking you CI server we can get the commit where it was defenatelly bad.
~~~~
git bisect bad 456cde
~~~~

Now git will checkout a new version of the code - somewhere between good and 
bad revision. You have to test it ad tell git if the current version is good 
or bad. That's it!

Using testsuites allows you to run the test in seconds, so the whole process of
finding the smelly commit will not take you long.

You can automate the whole process even more by writing a small script 
returning 0 indicating good result or 1 for bad result, and just let git find 
it for you
~~~~
bisect run my_script
~~~~

If you want to know more about git bisect google it up or check these two 
links: [git-bisect man page](http://linux.die.net/man/1/git-bisect) and 
[git book](http://book.git-scm.com/5_finding_issues_-_git_bisect.html)
