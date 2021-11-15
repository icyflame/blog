---
layout: post
title: Updating Node to node 4.x
comments: true
categories: nodejs cli linux
---

Node 4.x was released. Hmm, now that is a huge jump! I have been using Node 0.10.32
and Node 0.12.7 for most of my time in Node till now. I have known that a fork
called io.js has been around for some time now, and has version numbers that have reached 3.x.

When I realised that Node had updated it's version to 4.x, the first thing that I
thought of was that I had to update, and then I realized another thing: Backward
compatibility. I have written about 20 Node modules, published on [npm](http://npmjs.com/~icyflame)
and they probably depend on close to 60-80 modules themselves. So, for everything to work
perfectly, all of these 100 modules need to be written in such a way that they don't depend
on any feature that was dropped when moving from Node 0.12.x to 4.x. Hmm, it seems
almost impossible that that would be true.

Well, voila, it wasn't. In fact, one of the modules that I had recently built, [check-pnr-status](https://www.npmjs.com/package/check-pnr-status)
which is to check statuses of various PNRs from the terminal, didn't work.

I immediately installed NVM (the version manager n didn't really seem to work for me)
and ran the module with Node 0.12.7. And it worked.

Now, I was confused. There were quite some dependencies for this particular module,
most notably, `jsdom` and `async`. Running the module with Node 4 resulted in a `Segmentation Fault`
, yeah, well, that has always been very informative!

I have not yet gotten any time to fix this yet.

I don't have any idea how to fix it either.

Changing dependencies to stuff that works on Node 4? Figure out what doesn't work,
drop an issue there and hope the maintainer is worried about Node 4 and fixes his/her module?
