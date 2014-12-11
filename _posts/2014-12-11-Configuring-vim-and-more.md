---
layout: post
title: Configuring Vim and more!
comments: true
categories: Web-Development, Programming
---

The Fall semester ended on Dec 28th. And after that a lot of things have happenned. It's been a long time since I wrote a post, because I have hardly had any time, since then. I am leaving for home day after tomorrow. And now finally, all the tasks are moving into "pack-up" phase.

There have been many changes to my development environment in these two weeks. The most important is the integration of Vim into the scheme of things.

For some time now, I have been trying to get into this amazing command line editor that almost everyone seems to love so much.

Almost always, whenever I started using Vim, I got frustrated and left it to go back to my beloved Sublime Text, which was just so much easier to use and a Powerhorse in it's own right. I obviously believed that there was no feature of Vim, that could ever trump the usage of Sublime Text as the primary editor. All the simple Keybindings. So, easy to understand. `Ctrl + V` to paste, and not the EXTRA `shift` that had to be pressed in vim. (God knows how you copy text inside a file, hell, There isn't even an obvious way to highlight text.)

Despite all this, This time, I was determined. I had to learn this editor which was touted as the fastest and the editor with a huge community that built plugins for it which made the editor better then everything else.

The first thing that I set out to do with Vim, was edit HTML. Setting up the two space tab and indent size was my first great battle with Vim. I created a new list on [Kippt](https://kippt.com/icyflame/vim-config). This list was going to be my database where I would dump all the resources that I found regarding Vim. And this particular [clip](https://kippt.com/icyflame/vim-config/clips/23735598) (I call it this for no better word)

But now I was faced with an even harder problem at hand. When I was editing, the tags were automatically indented and closing tags were unindented to give a pretty format. But what about Python, the dread language that didn't have closing tags. I am equally passionate about HTML, Python, Ruby and C++. And I wanted an editor which was a good bet for all of these.

Turning again to the web, I got the solution pretty fast. My first encounter with Vim Plugin. The python.vim file, which I naively copied into `~/.vim/ftplugin`. I say naively because now I know that the only way to keep Vim portable is to use something like Vundle.

After this, there is another very very common feature that almost all people who write serious code, and believe that code should look good and do great things do all the time is "AUTO-INDENT". And in Sublime Text, I had bound this to `Ctrl I`. So Indenting the whole file took just `Ctrl A` followed by `Ctrl I`. Boom, Everything was well indented.

Now, The `=` operator was obviously great, or so everyone on Stack Overflow seemed to think, but it didn't work for me. Not the first time. Not the second time and not a lot of times after that. It turned out that I hadn't done turned on teh Filetype plugin which was through which teh indent operation worked.

A few more tweaks and I had indentation totally cracked! I immediately patted myself on the back on having reached the first bridge ito the land of Vim Users.

Handily, I had a couple of web applications that I was working on, and both of them were mostly basic FrontEnd pages. And there wasn't much file navigation to be done, I struggled through an half-an-hour task for 2 hours, but made it through. Vim had thrown hell at me, and I had waded through all of that to reach the end of my first full blown task in Vim.

Through the process, I had learned a lot about Vim. Pasting text properly, the weird nomenclature of calling copying text yanking and so on.

I also found about Vim Shorthand. `dit` for deleting the content inside tags. And similarly, `yit`, `pit`, `vit`. And the equivalent, when replacing `t` for tags with `"` for double quotes, or basically just any character, the text between two occurences of which we wanted to change stuff.

This was good. And I think this is one of the most powerful features of an editor. And what other editors, (Like my beloved Sublime Text) did using plugins, Vim did out of the box, and that box had a lot of computers in it (Servers, through Chromebooks with PocketLinux) (This is touted as Vim Portabality.) 

Soon after this, I started using Vim for everything from programming projects to even typing Git commit messages. (I used to type in Nano and the 72 character limit on oneline in Vim was very helpful, and I have totally fallen in love with it.)

I also found out the great capabilities of Vim in Find-And-Replace. The `*` operator, and the usage of `sed`-like syntax from inside the editor.

In conclusion, Vim is one of the best editors out there. It is blazing fast, and if you love the terminal, and hate having to move your hand from the home row to either a trackpad or a moust kept beside your keyboard, Vim is for you.

If you love mouses, then you would probably not like Vim as much, but even then, it is worth a try. In fact, Vim is worth more than a try.

Presently, I have installed Vundle, and I am preparing the `config` repository at [GitHub](http://github.com/icyflame/config).

