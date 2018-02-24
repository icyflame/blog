---
layout: post
comments: true
title: A Wildly Functional Digital Studio
categories: technology productivity tools
---

I follow Casey Neistat. I have watched everything he's made, and everything he
continues to make. There's one constant character in all of his work: **his
studio**.

<iframe width="854" height="480" src="https://www.youtube.com/embed/vb60rrtTddQ"
frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

He has had the space for nearly 10 years now. And everything in it is outfitted
exactly as he likes it. He never searches for things in his studio, he just **gets
them**.

_Hang on, this is not just a rave about Casey Neistat's studio_

I have been thinking about what the equivalent of a studio would be for a
programmer. The studio is the home for all the tools that you would use in your
work and life outside of work. That has got to start with a few staples: your OS,
your editor, your shell, your dotfiles. Actually, the complete [dotfiles][1]
repository. But is that all? **Definitely not**

**Scripts**. There are a [lot][2] of [repositories][3] on Github with the name
`scripts` or `oneliners` which have a collection of a the user's most commonly
used shell scripts. Great. So, [oneliners][4] is another part of the studio.
What next?

Dotfiles and oneliners have a very low time spent building them to time spent
using them ratio. So, they are a really good way to spend your time. Write more
and more oneliners. As many as you probably can churn out. The ideal case would
be one in which any task could be accomplished using just your brain or your
oneliners readme.

What about more involved contraptions? (eg: Neistat's Overhead shooting rig)
These are not the typical build-once, use-forever shell scripts. They are more
involved. Sometimes, they are even complete web applications. Most of the time
though, they are single-file scripts or web applications that solve an extremely
personal problem. Eg: me with [cutouts][5] (_I really could not let that
opportunity to plug my thing go_) or some other things.

~Cutouts is a way to save articles you read on the internet and want to store for
later.~

Cutouts is an application that I use to store the articles that I read on the
Internet alongwith the name of the author, a memorable quote from the article
and tags that let me arrange the articles. There are some more bells and
whistles which I added recently mainly to tell more people about it and help
fill a void for them, if they had one.

- Share a cutout via email: The articles I cut-out, I always want to share them
    with _someone_. Engaging with people and talking about all the perspectives on
    the issue at hand is a great way to learn.
- Share the permalink to a cutout: In case I am not too crazy about email and I
    just want to send it over an IM app to someone
- Upgraded to Bootstrap 4: The new Bootstrap blue. **double heart**
- Cutout visibility: _Give me six lines written by an honest man, and I will
    find something in it with which to hang him_ [Cardinal Richelieu][6]
- The Cutouts [feed][7]: I want to see how many people are using it and what
    they are upto. (obviously, only public cutouts are shown here)

Cutouts is a part of my digital studio. It's a Rails applications that I have
spent quite a bit of time on. It solves a problem for me. I don't know if many
other people have the same problem. I want to get this out there, so that if
they do have this problem, then Cutouts would make their life a little bit
easier.

The crucial difference a physical studio and a digital one is that the
components of my digital studio need not be a part of just _my studio_, they can
be a part of anyone's studio.

### Postscript

> This is equivalent to a single shot showing all the things in a physical
> studio.

Component | Purpose
:--- | :---
[dotfiles][1] | Install several dependencies, setup zsh's look and feel, editor (vim), git, tmux
[oneliners][4] | A list of oneliners that have proved to be useful time and again and have a tendency of being hard to find whenever the bash history disappears and these don't appear in autosuggestions anymore
[cutouts][8] | Store articles with quotes and author names. [Companion firefox extension][9]
[terminal-wallet][12] | Manage my wallet from the terminal; do simple debit, credit operations; have a stash account; export to csv
[cstimer_analyze_cli][13] | Analyze past times and note how fast improvements have come and if there have been any drastic jumps
[cstimer txt to cstimer json][14] | More struggles with csTimer in which the import and export formats were different(??)
[cli-cube-timer][10] | Measure the time it takes me to solve the Rubik's cube; plot it over time; maintain a backup on a [Github Gist][11] (_Finally I was done with csTimer)
[check PNR status][15] | Check Indian Railways PNR to see if their status has gone from Waitlisted to RAC to Confirmed
[metakgp visualize][16] | visualize the contributions on Metakgp and see what user is making maximum number of edits! There's also a [CLI Companion][17] for this. (I wonder why I thought it necessary to build a web page _and_ a CLI)
[Github repo creation calendar][18] | In a particularly heavy repository creation period, I decided that I want to use the Github API to find out how often I create repositories. NBD.
[Install tmux 2.0 from source][19] | There aren't any official sources and I didn't want to have to figure out the dependency tree again and again
[Understanding the TLS Handshake][20] | Probably one of the most useful repositories I have ever spent time on. I learnt an incredible amount reading the TLS 1.2 RFC and it actually came in handy this December! So, the time I spent on this repository was certainly the most productive 4 hours of my life!
[Youtube Chronological][21] | Youtube will let you show the uploads of a channel sorted by date but you can only play them sorted reverse chronologically. When you have just found a [new channel][22], almost always, you want to play the videos chronologically. I tried to look for services online that would take a playlist and reverse them, but I couldn't find any. So, I delved into the YouTube API. This Node.js script makes raw calls to the YouTube API. No API helper or anything.

It has been a long while since I have seen the repository pages of some of those
utilities. It feels great to list out all the things that I built out. Terribly
great motivation for sure.

Finally, I would love to see what constitutes your digital studio. So, if you
have written a post like this before, do drop a link to that in the comments
below.

_P.S._ I love writing blog posts. **double heart**


[1]: https://github.com/icyflame/dotfiles
[2]: https://github.com/search?l=Shell&o=asc&q=scripts&s=stars&type=Repositories&utf8=%E2%9C%93
[3]: https://github.com/search?l=Shell&o=asc&q=oneliners&s=stars&type=Repositories&utf8=%E2%9C%93
[4]: https://github.com/icyflame/oneliners
[5]: https://cutouts.siddharthkannan.in
[6]: https://archive.is/ImDPr#selection-43.1-43.99
[7]: https://cutouts.siddharthkannan.in/feed
[8]: https://github.com/icyflame/cutouts
[9]: https://github.com/icyflame/cutouts-firefox
[10]: https://github.com/icyflame/cli-cube-timer
[11]: https://gist.github.com/icyflame/59f64461aff1438975d7b241876fcc6e
[12]: https://github.com/icyflame/terminal-wallet
[13]: https://github.com/icyflame/cstimer_analyser_cli
[14]: https://github.com/icyflame/cstimer-txt-to-json
[15]: https://github.com/icyflame/check-pnr-status
[16]: https://github.com/icyflame/metakgp-visualize
[17]: https://github.com/icyflame/metakgp-visualize-cli
[18]: https://github.com/icyflame/gh-repos-creation-cal
[19]: https://github.com/icyflame/install-from-source-tmux-2-0
[20]: https://www.siddharthkannan.in/tls-handshake/
[21]: https://github.com/icyflame/youtube-chronological
