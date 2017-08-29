---
layout: post
comments: true
title: Understanding and Explaining the TLS Handshake
categories: tls https security privacy
---

Yesterday, I open sourced
[tls-handshake](https://www.siddharthkannan.in/tls-handshake/), a web page that
tries to provide an over view of the TLS 1.2 handshake at an abstraction level
that is appropriate for students who have taken basic cryptography courses
either at the college or school level. It has been one hell of a ride!

The idea came from my lack of understanding of the TLS 1.2 handshake, I really
had very less of a clue about what was going on. I often checked certificates,
especially on banking and merchant websites where I was entering sensitive
credentials. This had become more of a habit. But I was only checking the trust
chain of certificates, and the fingerprint and if the browser was giving me any
warnings about it all. I didn't really know _what was really_ going on
underneath everything, the math!

[![xkcd](/public/img/color_models.png)](https://xkcd.com/1882/)

There was one obvious place to start: [IETF RFC 5246: TLS
1.2](https://tools.ietf.org/html/rfc5246)

The spec is a dense 100-page document that goes over everything in
implementation-level detail, i.e detail enough to ensure that any person who is
implementing a TLS 1.2 client OR server faces absolutely no ambuiguity. The RFCs

go through a long process in which the TLS Working Group makes updates to them,
their mailing list is a great place to hang out if you have a few hours on your
hand and want to spend them learning more about how the next HTTPS spec gets
written.

RFC 5246 is a great document, **if** you know a few basics that the document
itself doesn't touch on. These include some common cryptography concepts like
asymmetric and symmetric cryptography, digital signature algorithms, the
Diffie-Hellman Key exchange system. Apart from the mathematics of these which
the RFC doesn't attempt to explain or ellaborate over, the RFC is self
sufficient.

A [simple new session packet
capture](https://www.siddharthkannan.in/tls-handshake/SAMPLE_NEW.html) should be
enough to tell you about the different set of messages.

This screenshot from the RFC itself, which I noticed quite late in my reading
will tell you the sequence in which these messages are sent:

![img](/public/img/tls-handshake-overview.png)

A few hours should be enough for you to understand the over-all flow of the
information that is being exchanged and the different places that you might end
up in, after each message is sent.

That is when I was ready to start writing the webpage. After beating around for
a few minutes about a good UI to show everything, I decided to stick to text and
simple HTML as much as I could, and use Markdown to format everything!

One thing I absolutely wanted to have was informal "Purpose" sentences for each
message. Mainly because the TLS handshake is just a secure way for two people to
talk, in a public place like a train or a bus station and without spelling it
out, and share a message that they don't want anyone else to know about. They
have never met before. And both of them are pretty good at mathematics that
involves huge primes, or elliptic curve points, whichever one is to your taste.

That's sort of my story behind the "TLS Handshake" explanation page! I posted it
on r/https (which is a pretty dormant subreddit), I might post it on Hackernews
soon, once I can take some time off and go back to read the whole thing and be
sure that there's nothing wrong that's written there.
