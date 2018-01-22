---
layout: post
comments: true
title: Pragmatic GoLang Workshop - Follow-up
categories: golang workshop technology
---

As part of the [Kharagpur Open Source Summit
2018](http://kwoc.kossiitkgp.in/summit), there was a Pragmatic GoLang workshop
on 20th January, for 3 hours.  [Kshitij](https://github.com/kshitij10496)
organized and ran it. By all accounts, it was a great success! He did a really
good job with the [slides](http://slides.com/kshitij10496/pragmatic-go) and with
delivering the workshop! The workshop was originally scheduled for 3 hours but
it ran for nearly 4 hours, and people sat patiently and programmed alongwith
him.

I was part of the team who was there helping him out with the doubts that
everyone who came to the session had. These are some of the things I learnt in
the workshop and some notes about GoLang for the future.

- GoLang requires the opening brace of a function to be on the same line as the
    closing parentheses of the function definition:

    ```go
    // allowed
    func Test(a, b int) {
        ...
    }

    // not allowed
    func Test(a, b int)
    {
        ...
    }
    ```

    I remember reading about this in the Go "How to Format your Code" section
    and thinking to myself that this is perfect because this is the style I
    swear by whenever I write JavaScript!

- Go doesn't have a `float` type. It's mentioned pretty clearly in the [Types
    RefSpec](https://golang.org/ref/spec#Numeric_types) but I ended up expecting
    a similar construct to `int`. I should start using `int64` instead of just
    `int` so that the code works on all architectures!

- Go's `switch` doesn't suffer from fall-through, the thing that forms the
    material for several of the trickiest questions about C++. This is GOOD!

- Arrays can't be resized. Slices are references to arrays. Slices work a lot of
    like Vectors in C++, I now realize. Slices are a very convenient data
    structure.

- Functions are first-class objects in Go. With lambdas, functions being
    first class objects, and closures being treated without a frown, Go achieves
    several of the things that I love about JavaScript! (Go is such a mixture of
    features from every paradigm of programming)

- Channels can be closed. This enables iteration over the channel using the
    _for-range_ structure!

All this stuff that I have learned about writing "Idiomatic Go" enables me to
go back to [year-in-twitter](https://github.com/icyflame/year-in-twitter) and
[leprechaun](https://github.com/icyflame/leprechaun) and do things _the Go way_.

**Sidebar:** I gave a
[talk](http://archive.is/2018.01.16-063824/http://kwoc.kossiitkgp.in/summit/106)
titled **Node.js, GoLang and Concurrency** on 21st January! It went well (I
think). The video should be up soon. I am working on an appropriate HTML page
with the resources I would like to distribute with the talk. (slides, code,
further reading)
