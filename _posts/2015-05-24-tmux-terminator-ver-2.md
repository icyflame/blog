---
layout: post
title: Tmux, Better than terminator?
comments: true
categories: linux
---

In the about page of this blog, I talked about the application [Terminator]() and how it is part of my virtual workspace, apart from Vim, Sublime, Git and Linux!

But then, I came across Tmux, and it seemed interesting. It was a pain to get started with, to be honest. The default prefix key is `Ctrl+B`, and having to press that before even switching panes in a window, that was a pane. (Did I mean `pain`?)

Anyways, I went through the documentation and didn't really understand much at the beginning. It was all panes, windows, sessions, servers, clients, and so on. I had to start using this, and just hope that somewhere down the line I would understand what all the words really meant.

And now I am confident that I understand, and I love it! Changing over to the new prefix and arrow keys scheme was hard, and un-intuitive right at the beginning. But now, not so much. I have one session up and running, and inside that session I have about four windows. Of these four windows, two of them run the two development servers that I almost always need, npm and rails. (I like multi-tasking across projects!) Apart from these servers, I have a pane dedicated to git pulls, and pushes. I have a soft corner for the up arrow key, you see. I have some more panes in these development windows. The rails window, needs two panes for `zeus start` and `zeus server`. (I use [zeus](http://github.com/burke/zeus) for all of my Rails development! It's faster, and doesn't need frequent restarting, unless of course one of the initializer file changes!)

And while tmux was great and all that, one of the features of Terminator that I particularly loved was that I could configure a default setup at each startup. This setup was extremely painless. Well, guess what? Tmux did it better. Or atleast there was a plugin that did it better! And thus, much with a deja vu feeling as I had when I first started using Vim, I found a plugin that changed the way the tmux status line looked, and another plugin that was very aptly named `tmux-resurrect`, yes, indeed! It resurrected the session which was running earlier, exactly as it was. I was slightly awed by this, it was not **that** hard to implement, I guess, if you knew how to do it. But it was just, apt for the moment!

So, thus, with all this setup, I am on my way to using tmux, probably forever!
