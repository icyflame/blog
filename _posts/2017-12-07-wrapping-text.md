---
layout: post
comments: true
title: What does "wrapping text to 80 columns" mean?
categories: editors programming
---

When you write a line of text that is really long, you can do two things. You
can enter a "linebreak" or a "newline" after every few characters. Or you can
not do that and let the line be as long as it needs to be.

"Wrapping text at 80 columns" implies that you have configured your editor to
insert a "newline" after you have typed 80 characters on a particular line. The
cursor moves to the next line.

Sample unwrapped text: [Unwrapped text](http://ix.io/CRZ)

Sample wrapped text: [Wrapped text](http://ix.io/CS0)

The difference between these two formats might not be obvious to some at first
glance. The unwrapped sample will look different on different screens. If your
screen is really wide, you will be stuck with each line having about 20 words.
If your screen is really small (like a phone screen) then you will have a
flowing passage of text.

![img](/public/img/unwrapped-pc.png)
_Unwrapped text on a 16 inch PC Screen_

![img](/public/img/unwrapped-phone-portrait.png)
_Unwrapped text on a 16:9 phone in portrait mode_

![img](/public/img/unwrapped-phone-landscape.png)
_Unwrapped text on a 16:9 phone in landscape mode_

The wrapped sample will look good on all computer screens because 80 characters
is some sort of a lower threshold (Yes, there's a reason that 70-80 is the
preferred line length). I am not sure where this threshold comes from, but I
don't think the reason matters. Although, you should be aware that wrapped text
doesn't look like a flowing paragraph on phone screens. The newlines in between
will cause some quirks. But these don't matter because no one is reviewing C
Code on Phone screens (except some Git maintainers on a holiday)

![img](/public/img/wrapped-pc.png)
_Wrapped text on a 16 inch PC Screen_

![img](/public/img/wrapped-phone-portrait.png)
_Wrapped text on a 16:9 phone in Portrait mode_

![img](/public/img/wrapped-phone-landscape.png)
_Wrapped text on a 16:9 phone in Landcape mode_

Note that in the wrapped text, no matter what screen size you see this on, the
newlines occur exactly at the same place. Larger the screen, the more whitespace
you see on the right of the text and below the text.

Whereas on the unwrapped text, the newline could be anywhere depending on your
screen size (it's not technically a newline as the text doesnt have any
newlines, it's just a linebreak that's inserted by the software rendering the
text). Also, the larger the screen, the more whitespace below the text. There
will be no whitespace on the left or right of the text because the text will
expand to accomodate it.

Some other weird stuff: Vim has a mode which can wrap text for you while
writing but still not enter a newline to actually make it wrapped text. I don't
know about this mode and don't use it. You shouldn't use it either unless your
use-case calls for it.

**Note:** I had to explain what wrapping text meant to people on GitHub, and I
couldn't find anything on the internet for it. The [Kharagpur Winter of Code
2017](http://archive.is/2017.12.07-071849/http://kwoc.kossiitkgp.in/) started on
1st December. Since then, I have been getting patches from people who are
_extremely new_ to GitHub, Open Source, Programming, Computers etc. Often, while
explaining concepts to them in GitHub review comments, I realised that many of
the terms that I take for granted are murkily defined. It's also hard to find
"what" they are online, which increases the information assymetry and ends up
wasting the time of everyone involved. That's the reason, I wrote this post.
