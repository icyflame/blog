---
layout: post
comments: true
title: Setting up Ubuntu 18.04 LTS on a Thinkpad
categories: ubuntu setup installation
---

It's been a while since I have setup a brand new computer. I did set up a Mac
when I started working in September last year, but that was more of a
step-by-step thing where I just started with my existing dotfiles and picked up
stuff along the way from people around me who had been working for a much longer
time and knew of _so many_ great Vim extensions and tools that I had previously
never heard of. [Prezto][1] was one of them!

I was going to install Ubuntu 18.04 LTS on an IBM Thinkpad L390. It was released
around December last year (or earlier this year?) and sounded like a really good
handy laptop for travelling, particularly. I bought it with a mid-range RAM
config of 16GB and a 512 GB SSD. For comparison, my current personal machine was
a Dell Inspiron from 2015 with a 1TB HDD and 8 GB of RAM; so this was a pretty
significant upgrade.

**TL; DR** Installing Ubuntu took about [5 minutes flat][2]. I am not even
kidding; I never realized that copying files and cleaning up the disk is one of
the slowest steps in an install and is a complete bottleneck! Also, the
partition setup was much simpler for me this time. 80 GB Windows 10, 80 GB root
`/` and the rest for `/home`. That's it. I decided to keep it extremely simple.

Deciding to keep Windows 10 was a pretty big decision, and I definitely took the
safer option. I was particularly worried about warranty issues if I nuked
Windows because I am convinced that any service center would _only_ have
trouble-shooting software for Windows. In fact, every time I have taken the Dell
in for a repair, I always boot them into Windows and leave them in there. So,
   even though I was looking forward to nuking Windows and having a pure Ubuntu
   single-boot machine, I decided to continue with Dual Boot. My concern of
   Windows being at the top of the Grub screen had gone away since my last
   install of Ubuntu and subsequent discovery that you can actually control the
   order in which the operating systems show up on the Grub screen!

Once the installation was done, I set about getting all the software that I
considered essential. The last time I did this with the Macbook, I didn't keep
track of what commands I was running and this was a mistake. So, this time, I
took [meticulous notes][3]. I also added this gist to my dotfiles, just in case
I ever have to setup an Ubuntu computer from scratch again. (One of the steps I
        was fumbling at was linking the `.z*` inside `$ZDOTDIR`. I hadn't linked
        these files and didn't realize that prezto won't work without them!)

I have been using this Thinkpad for about 2 weeks now, and everything has been
going well so far. WiFi, sound, the touch pad, brightness and volume controls
everything seem to be working fine. I haven't run into severe Ubuntu-Thinkpad
compatibility issues yet. And hopefully, I won't run into them far into the
future!

[1]: https://blog.siddharthkannan.in/shell/zsh/prezto/2019/04/06/oh-my-zsh-to-prezto
[2]: https://twitter.com/_icyflame/status/1152417034115747841
[3]: https://gist.github.com/icyflame/1399a7462f4c56103f8417b26875f5c5 
