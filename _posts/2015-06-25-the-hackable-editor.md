---
layout: post
title: Atom 1.0, The Hackable editor
comments: true
categories: web-development
---

NodeJS is awesome! (That's kind of the sentence that I see daily on the web, nowadays!). But, this post is not related to that. (Or maybe it is, since Atom is written in Javascript, and NodeJS is Javascript, on steroids!)

So, I see this announcement on GitHub, saying `Atom 1.0 is out`, I open the announcement, and see an awesome video! (<3 GitHub!) The video is actually awesome! It's old school, the people are all old fashioned, but the video itself depicts the future in an irony type setting. And it's cool!

Meanwhile, My computer's D Drive is getting filled about 99% (it is currently at 99.5%), `/home` is filled 60%, and somehow, everything is a bit slow, and I am trying new browsers, (Enter Firefox and Midori) and new ZSH terminal prompts (Enter RobbyRussell, Agnoster), and it felt right to change the editor too.

But anyway, getting to the product. Atom 1.0. I had tried out an earlier version of Atom, and it was somewhere around 0.7, or something, I don't even know for sure. But I do remember it was slow, crashing all the time, and the auto-fill was not great, Sublime's native thing was better, and it just wasn't worth it, and I uninstalled it, and life went on. I was eager to checkout 1.0.

Installing 1.0 was painless, they packaged a DEB, (and that's awesome, everything should either come through `apt`, `npm`, have a `tarball` or a `deb`!).

I opened a HTML project in Atom! And it looked great, that was the first thing I noticed! It looked awesome: the typeface, the colors. The color scheme that is currently being used is probably Solarise, It feels like Solarise, I am not sure though. But anyways, it looks great.

The next thing that I used was auto-fill, it was like Sublime. I am not going to say anything more about this really, because I have not really used it with JavaScript, Rails or other back-end frameworks. I just used it a bit with a plain HTML file, and only selectors were getting auto-filled, and I am happy with it, but we have that in Sublime. So, nothing new yet! I will probably do another post just about auto-fill! (After using Vim's auto-fill plugins, [YouCompleteMe](http://vimawesome.com/plugin/youcompleteme), the editor must be **atleast** as good as that!)

Now, Atom is built by GitHub, and thus, I expected two things. First of all, of course, complete integration with GitHub. I was pretty sure about this, and I think it's baked in. I have not tested a lot of it, but it seems to be baked in. But the second thing, and probably the thing that I am more interested in, is how much Git is baked in.

Over my last few days with Sublime, I had installed a Git plug-in, and I was doing a lot from the editor itself, not too much, I mean the command line is the big brother of everything? But basically, the plug-in could do everything except `amend` and pushing to remotes other than `origin`. So, after this plugin, I like doing small commits a lot, and it makes sense too, and this worked well with the plugin.

The right bottom corner in Atom has the git branch, the diff stat for the current file. And the left sidebar highlights the files yellow and green as per it's new or not, and edited or not. And all this is cool, but apart from this, commits or anything else was not built in out of the box. Probably, a no-brainer?

I am not sure why they did not built that in. Of course, I can go ahead and install a plugin and all will be well again in the world. But it just feels that as a company that is building an editor for developers, and if that editor could cater to people who are new to Git by having everything built in, then that would be awesome!

They would probably bake that in the next release? I don't even know if they have it in their feature list. I am going to head over to their repository, and look for a related issue.

All in all, it feels like this is going to be a good editor experience. I am not sure, but I guess that's the cool thing about new software!
