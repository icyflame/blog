---
layout: post
comments: true
title: Day 6 - SHA-1 broken, TRAPPIST-1 has planets, Homeland 6.5 - EPIC EPISODE!
categories: 100daysofwriting writing security cryptography astronomy
---

Well well well. That was an eventful day.

I just learned from an [@eevee
tweet](https://twitter.com/0xabad1dea/status/834802038303236097) that SHA-1
collision was generated. That was about 40 minutes ago. Before that, another
tweet told me showed me the cute gif that [Google
made](https://twitter.com/GoogleDoodles/status/834574707915644929) for the
TRAPPIST-1 discovery. All of this was right after I had just seen Homeland
S06E05. I love the episode. I raved about it [on
Twitter](https://twitter.com/_icyflame/status/834802184462098432).

![day61](/blog/public/img/day-6-1.png)

SHA-1 collision was on it's way, I guess? Chrome had already almost deprecated
SHA-1 certificates, and apparently Root CAs were no longer allowed to issue
SHA-1 only certificates. So, this should probably not affect stuff as much. Git
should definitely be affected. I have read Linus say that even if there was ever
a SHA-1 collision that happened, then Git would handle it just fine. Discussion
about this has [already
started](https://public-inbox.org/git/CA+55aFxjY7mv7YPLZwit7bEhC3VqpEDk1YSRFwSGOEKVw13x4w@mail.gmail.com/T/#me181023a3dfe30d4b76880f0c883c4f90a5a879d)
on the git mailing list, which I am following closely because I am trying to get
[this](https://public-inbox.org/git/1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com/)
[patch](https://public-inbox.org/git/1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com/)
[series](https://public-inbox.org/git/1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com/)
merged in! This is the first time that I am working with the Git community, and
they are really good! I have had email exchanges with Junio (who is the
maintainer) and also with Matthieu Moy who commented on almost all of my
patches! I am glad that I am able to contribute to something that I use daily,
and make some kind of a significant and meaningful contribution to (g)it!

I have studied (in a course last semester: Cryptography and Network Security)
about the internals of DES, AES, SPN Networks (which form the basics of modern
Block Ciphers). I know about TLS and HTTPS because I obsessed over it. I would
like to mention Robert Heaton's brilliant [blog
post](http://robertheaton.com/2014/03/27/how-does-https-actually-work/) on the
matter. (Also see [@filippo's talk about TLS
1.3](https://www.youtube.com/watch?v=0opakLwtPWk) and why it is awesome. This is
apparently pretty close to being a RFC and eventually being implemented on
servers). I am also studying about more security proof stuff: IND-CPA, IND-CCA,
etc this semester in another course: Foundations of Cryptography.

The one thing that's missing from my arsenal is knowledge about the contruction
of 1-way hash functions. I have tried reading the RFC for SHA-1, and although I
kind-of understood it, I still need to understand it more completely. There's
one more thing added to my "read up about" list. (Kidding, I don't have any such
list, creating one should make sense though)

The second thing: TRAPPIST-1. I don't know much about this, except for the
distance that really registered in my head: 40 light years. That's huge, and
basically, what we are seeing now was happening at these planets 40 years ago.

![day62](/blog/public/img/day-6-2.jpg)

Wow, that's one generation of life! Imagine if someone could see (but not
change) what we were doing 40 years ago, and think about how they would have
felt about it. 

Or better still, what if someone watched what we are doing right now, 40 years
from now. For simiplicity, you should probably assume that it is human beings
who don't have any clue about anything, but somehow live 40 light-years from
Earth) Yeah, it is all pretty weird and intriguing and scary.

The last thing that I really wanted to talk about was Homeland 6.5. It is
seriously the best episode that I have seen them make in a long long time. The
last time I felt this way was in Season 1 or Season 2. When Carrie and Brody and
Quinn and Saul and Dar were at the top of their games. Now, only Dar seems to be
at the top of his game, because Saul just confided in Dar. And from the trailer
scene of Dar going into the room for a meeting and saying "No Saul?" and someone
replying "No Saul", it seems like he's going to do something to get him out of
his way so that Keane can't be around any sane person except for Carrie and Rob
(who seems really weird for a Chief of Staff, he never seems to be around any of
the staff that he's supposed to chief of! So unlike Amy from Veep)

The feeling that you get from Franny and Quinn's first interaction scene
together is soooo good! And the irony of it all is that Quinn wasn't doing
anything bad at all, he was doing exactly what Carrie would have done in a
similar situation. Would Carrie have shot that guy on her front porch? Probably
not. She would have certainly gone out and rationally convinced everyone there
that they were being class A A-holes, and they should stop doing whatever they
were upto. (which was intimidating a women in a house alone with a daughter for
saving a guy who is now a suspect. Oh.  Okay, maybe the intimidating thing isn't
right)

Yeah, I am watching Veep too. Mainly for Julia Louis-Dreyfus whom I love because
of Seinfeld.
