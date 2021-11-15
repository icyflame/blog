---
layout: post
title: Setting up a new Linux Machine
comments: true
categories: programming
---

Soon after getting acquainted with Vim, I had to change my machine. My old Toshiba, with 3 Gigs of RAM and an Intel Pentium at it's heart, had a broken display, and it was not cutting it anymore.

The new machine is armed with 4 Gigs of RAM, a 4th Gen i5, and 2 GB of AMD Radeon Graphics. It came pre-installed with Windows 8.1. And when I bought it, I had all the intention required to change the operating system to something faster and much more customisable and useful for stuff like Git, Rails and all else, Of course, Ubuntu!

My config on the old laptop was perfect and well toned. Over the past year and a half, I had tweaked each part of the machine, starting from the shell, which changed to zsh recently, right to the complicated dependencies of ROS Hydro. Also, I was moving from Ubuntu 12.04 to Ubuntu 14.04, Long Term Suppor versions of the operating systems.

This was when I came across [this post](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/) by Zach Holman regarding the dotfiles tha make up a machine's configuration.

Further, I also looked at [dotfiles.github.io](http://dotfiles.github.io), which basically told me how to get started. I was not able to understand most of the resources there. And basically, how symlinks worked.

So, I started reading up on symlinks and within an hour or so, I had a working copy of my own dotfiles repository ready. Fork it on GitHub [here](http://github.com/icyflame/dotfiles).

After this, My color scheme, my vimrc (Vim being the editor in which I do most of the editing work now, See my praise for Vim in the previous post!), and my zshrc alongwith the gitconfig and global gitignore file. I also came up with an `install.sh` bash script that would copy these files and symlink them to the main files. Along the way, learning a lot about bash programming. (It's been on my todo list for quite some time now!)

After the configuration was setup, I set about installing all the core packages. (vim, git-core, vlc, chromium etc).

After this, I had to setup ROS, this time, it was the indigo distribution though. Whole of AUV is moving from Hydro to Indigo, this winter. They have started working on the next release (called "Jade"). We guess it will be atleast one more year before they get ready to ship it.

The ROS Indigo installaton was pleasant, and surprisingly, I didn't run into any major walls. The installation was smooth, and I was able to get everything working. (The only problem was when I had to do `echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc`. I had to change all the occurences of bash to zsh in this line! so I had to add the line `source /opt/ros/indigo/setup.zsh` to my `~/.zshrc`. And everything was working good (Once I had configured the `ROS_WORKSPACE` and the `ROS_PACKAGE_PATH` environment variables)

So, about 2 hours in, I was completely setup, except for a couple of problems here and there, I was more than happy with my new laptop! (The Dell Inspiron 5547, which apparently has some kind of "official" support from Canonical, because of which all the drivers were there and everything was working!)

Along the way, we (at AUV) have started using Telegram, an open-source messenger. And as with almost all open source ventures, it has a large community of developers, who have created messenger clients for every device out there. Yes, everything. Android, iOS, Windows Phone, Windows PC, Mac OS X and Linux. So, hopefully, no more reaching to your phone to reply to that message from your colleague. (Footnote: The Android App and the Ubuntu Desktop Client are amazing. They just WORK!)

I have been reading an [interesting article](http://paulmillr.com/posts/the-story-of-telegram/) about why Telegram is secure and if it is secure at all, it makes for some productive discussion over coffee with people interested in Tech and Information Security!
