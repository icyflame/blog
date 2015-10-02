---
layout: post
title: Switching from Chromium to Firefox!
comments: true
categories: linux
---

So, one of the few things that almost everyone does after their mid-term exams are over is _chill out_!

I chose to do this using my browser as well! I was browsing GitHub repositories to contribute to, solving and creating issues on projects I maintain and running music in a tab using YouTube.

Lately, I had been slightly irritated with the RAM usage of Chromium. It uses about 70% of Memory and 50% of CPU. I still stuck to it because of the great plugin community around Chrome, the really tight integration with most of Google's services. I liked the Checker Plus for Gmail plugin for Chrome, and this was very important for me. But, enough was enough!

**Note:** The first time that I opened Chromium to get the vtop screenshot, It slowed the system so much that even `htop` was taking so long. And note that on the same computer, I have close to 20 tabs open on Firefox, and I can't even feel it running! Really really light weight!

**Mem Usage on Chromium**

![chromium-top-1](/blog/public/img/chromium-top-1.png)

**Mem Usage on Firefox**

![firefox-top-1](/blog/public/img/firefox-top-1.png)

**Test conditions** In both the above tests, all other apps on the system were closed, and pages for a logged in account of GitHub, Gmail, Facebook and Twitter were kept open. It was on Ubuntu 14.04 running 4 GB of RAM and an Intel i5 processor.

So, except for the **Huge** difference in CPU and MEM usage, the Load Average is also really worth nothing. It is close to 3.5 in Chromium's case, whereas it is slightly less than 3 in the case of Firefox.

So, after seeing the above, I immediately switched. And started searching for Firefox Add-ons for most of the things I used. I got similar ones, if not the same, for most of them. (I got an extension similar to Checker Plus in [Gmail Notifier](http://add0n.com/gmail-notifier.html))

The switch is mostly complete for now. And one of the advantages probably is that Firefox has a built in RSS feed reader, that I don't need to setup and gives me updates on the Bookmarks Bar itself! I am not sure if Chromium has this feature though, and it's way too slow for me to close everything else and then find that! So, if any of you use it, please do enlighten me!
