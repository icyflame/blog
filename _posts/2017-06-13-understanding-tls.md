---
layout: post
comments: true
title: Setting milestones to understand TLS
categories: internet tls security https
---

I downloaded the TLS IETF draft. It's 104 pages long, That's as big as Rita
Hayworth and Shawshank Redemption.

This is perhaps my 100th attempt at reallt understanding the internals of how
TLS works. My end goal is simple here: I want to know how a secure channel is
established between a server and a client. I don't want an
apples-and-oranges-are-fruits level understanding of it, I have that. I know
all the digital signature and public key cryptography analogies that are out
there. I want to be able to form a general idea of HOW each step works, why it
is required, and how that particular step fits in the larger scheme of things.

I started with Wireshark and captured a default HTTPS handshake. I was able to
do this rather easily and create a pcap file. Now I atleast have that, which is
the ACTUAL packets going through the network.

The order of messages is clear to me but I have decided to take it slow and
understand each message thoroughly before trying to put the pieces together.

If I was to give an analogy for this, like those that people always resort to
while explaining crypto to others, it would go something like this: I want to
understand what is there on each piece of the puzzle before trying to put it
together.

First milestone: `Client Hello` and `Server Hello`. After this comes the more
intense cryptographic part, but these two are important for the decision of
which cipher suite to use. (my computer's least favorite cipher suite uses
3DES, remember that?)

More on this series, hopefully. I am going to print some pages of the spec out
because that is probably the only way to keep my sanity and still learn
something useful.

Some random thoughts:

In the Hello part of the exchange, both parties agree on four things: the key
exchange + signing algorithm, the bulk encryption algorithm, MAC function and a
pseudo-random function (PRF). Why are these used? Under my current model for
learning about TLS, at this stage, I am going to have to take for granted that
these four things are needed somewhere down the line. 
