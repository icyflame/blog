---
layout: post
comments: true
title: Generating Git Punchcard plot from the terminal
categories: git punchcard open-source marathons
---

Around 6 pm today, I found
[guanqun/git-punchcard-plot](https://github.com/guanqun/git-punchcard-plot).

At 10:45 pm, approximately 4 hours later (of which I spent rather less time
writing stuff, I opened [PR
\#7](https://github.com/guanqun/git-punchcard-plot/pull/7).

Once I cloned the repository, I realised that you _need_ to put the
`git-punchcard` python script in your `PATH` for it to start working as `git
punchcard`. I didn't need any of that, I did _really_ want to see a punchcard
though. So, I put it there, (**Note 1:** Take path from the CLI if provided!)

When I generated the punchcard for a repository, it looked like this:

![before](/public/img/punchcard-original.png)

It looked _okay_. The opacity was a problem. I might have made fewer commits
during those times (this is the punchcard of [my blog
repository](https://github.com/icyflame/blog/graphs/punch-card) generated using
this utility). So, I also wanted to fix that so that the opacity of all the
circles will be 1 and the circles will all be black.

Implementing these two was rather easy. (I delved into one Cairo function and
searched and found `os.getcwd()` and `os.chdir()`) Now the punchcard looked more
like the one on GitHub, and pretty good:

![middle](/public/img/punchcard-middle.png)

I was about to open a PR to the repo, when I came across [Issue #5:
Timezones](https://github.com/guanqun/git-punchcard-plot/issues/5). It put forth
a rather interesting problem. You have collaborators working from different time
zones and you would like to figure out when they work, so you can plan upgrades
and also schedule meetings without asking them when they work. (decidedly more
cumbersome, but why not?)

This was the part that ate up the most of my time. Understanding the internals
of the myriad utilities that Python has to work with Timestamps. There isn't
just one module does everything. Oh no, that would be too easy. Instead, there
are atleast 4 modules: `datetime`, `time`, `email.utils`, `calendar`. Each of
them has a few functions and they all seem to seemlessly interop with each
other. It's rather confusing and I was finally able to understand what functions
to use after considerable amount of moving around the documentation pages of all
these functions and an open Python shell. The code I wanted was:

```py
formatdate(mktime_tz(parsedate_tz(RFC_TIME_STR)) + FINAL_OFFSET)
# -> This would give me a RFC 2882 compatible string
```

One final thing I added in because almost as soon as I had done all this, I
realised that the punchcard was for the _whole_ project lifetime which could be
years in a lot of cases. I needed some way to limit the period from which the
punchcard was being built. One look at [git-log's commit
limiting](https://www.git-scm.com/docs/git-log#_commit_limiting) documentation
made it obvious to me that tunnelling options to git would be the most flexible
option to go forward.

The list of options that git-log supports is **rather extensive!**.

That was the path I took to get the following punchcard of my 100 Days of
Writing project on this blog:

![final](/public/img/punchcard-100daysofwriting.png)

Anyway, the open PR is now on
[Github at #7](https://github.com/guanqun/git-punchcard-plot/pull/7). If you
have the time, download the script on that branch and make some punchcards for
repositories that you work on or others work on. Maybe you will discover
something interesting about your colleagues.
