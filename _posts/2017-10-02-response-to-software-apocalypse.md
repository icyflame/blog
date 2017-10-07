---
layout: post
comments: true
title: A response to The Coming Software Apocalypse (an article on The Atlantic)
categories: responses internet articles software
---

This is a response to [The Coming Software
Apocalypse](https://www.theatlantic.com/technology/archive/2017/09/saving-the-world-from-code/540393/),
an article on The Atlantic published on 26th September, 2017.

The approach that the article suggests for programming is [Model-based
design](https://en.wikipedia.org/wiki/Model-based_design). I would like to cover
some of my own past experiences with bugs that existed in the code I wrote and
how the lack of confidence in the foolproof-ness of a piece of software leads to
hours spent in thorough (not exhaustive) testing.

***

### 1. `undefined` leads to 15,000 emails

During the past summer at Elanic, there was a typical problem in the ExpressJS
based backend that powered the primary REST API that runs the Elanic mobile
applications. There were three ways for a user to sign-up:

a. Using their Facebook account
b. Using their Google account
c. Using an email ID and a password

(c) was majorly used on the iOS application where OAuth2 logins weren't yet
implemented. The issue was that when a user signed up using an email ID and a
password, the email ID wasn't verified. i.e. people could sign up with fake
email IDs like `fake@example.com` and get away with it.

Solving this is pretty straight forward. When a user signs up, check if they are
signing up with type (c) and then, send them an email with a link that consists
of a verification token. When they click on the link, we will get the `GET`
request and using the token we can mark their account as verified.

If the email ID doesn't exist or is not controlled by them, then they will never
be able to verify their email. EEZY PEEZY!

![gif-easy](https://thumbs.gfycat.com/AffectionateDecisiveEchidna-size_restricted.gif)

I thought about it a bit more and realised that there is one more case in which
we would want to verify the user's email and that is in when the user updates
their profile and changes the email from there. In that case as well, we would
have to verify the new email ID. (And if required, send an email to the old
email ID informing them that the email ID has been changed. This wasn't
required.)

So, now there are two places we want to send the verification email: (a) when
the user signs up with an email (b) when the user updates their email.

Now, the way the code was structured, the `UserProfile` model had a function
`UserProfile.updateProfile({ filter, update, options }, callback)` and that was the
right place for this code to be. Primarily because `updateProfile` was being
called from across the application, and if in the future a flow is introduced
where the email might change from somewhere else, this would take care of it.

So, I wrote something like this.

The routes looked like this (`server.js`)

```js
// POST /users
// Creating a new user
function PostUsers(request, response, next) {
  let params = request.getParams;
  let profile = new UserProfile();
  profile.email = params.email;
  profile.password = hash(params.password);
  profile.save(error => {
    if (!error) {
      sendVerificationEmail({ email: profile.email });
      response.send(201);
      return next();
    }
  });
}

// PUT /users/:id
// Edit a user's profile
function PutUsers(request, response, next) {
  let params = request.getParams;
  let userId = params.id;

  let filter = { _id: userId };
  let update = _.delete(params, "id");

  UserProfile.updateProfile({ filter, update }, (...) => {
    ...
    return next();
  });
```

And the model function `updateProfile`:

```js
UserProfile.updateProfile = ({ filter, update, options }, callback) => {
  if (update.email !== undefined) {
    sendVerificationEmail({ email: update.email }, () => {});
  }

  mongo.update(filter, update, (err) => {
    if (!err) {
      return callback();
    }
  });
});
```

Since I have spoiled the problems in the code for you, you probably found the
problem?

It's the first line of `UserProfile.updateProfile`! I check if the
`update.email` is `undefined` or not. While I was writing this, I was convinced
that this will check if the email has changed, because there would be no point
to send the unchanged email alongwith a `PUT` call right? Why waste bytes on the
wire for things that haven't changed?

Well, I got hit right in the face! Turns out **BOTH** the Android and the iOS
application send email alongwith the PUT call and let the backend deal with the
change (or not). Worse still, even PUT calls from an internal tool called the
"administrator panel" also sent this parameter! And internally, profiles are
edited a lot to change tags, etc.

During the next 4 days, there were nearly 15,000 emails sent out of the Mail
exchange. Several frequent users who had their profiles being edited from the
internal tool received the "verify your email" mail multiple times, as high as
20 even.

This was one of the simplest features to implement, but there was still some
nuance! **THAT** is the reason this experience stuck with me, even 3 months
later.


### 2. My ongoing struggle with Merge Sort

I have been implementing sorting and those kind of things for quite a while now.
I keep re-implementing them just to keep up-to-date and warmed up in my primary
langauge for competitive programming: C (although I write it in a `.cpp` file
and compile it using `g++`, more on that later)

Every time I implement Merge sort, I almost always start with the function
signature `int * merge(int *arr, int n)` whereas the actual signature should be
`int * merge(int *arr, int begin, int end)`

The first signature can still be worked, but I like the second one for it's
verbosity.

Then, you find the middle as `middle = (end + begin) / 2` and call merge on the
first and the second halves.

Anyway, there's no particular bug here, I am just stressing on how although I
know this algorithm inside-out, I still need to write it and test it with a
couple of arrays before I can integrate it into my larger file. (The few times I
was over confident about it and directly started building atop the merge sort I
wrote and thought worked, I spent a significant amount of time going back and
forth and finally realising that I had flaked out in the first function I
wrote!)

***

My final code has been buggy in fairly limited instances. Through the
development process, of course, there are several basic mistakes I make and
discover and fix and move on. The iterative process that is so common is the one
I subscribe to as well.

A couple of points about the article,

> Newcombe isn’t so sure that it’s the programmer who is to blame. "I’ve heard
> from Leslie that he thinks programmers are afraid of math. I’ve found that
> programmers aren’t aware—or don’t believe—that math can help them handle
> complexity. Complexity is the biggest challenge for programmers."

I am not sure what programmer is "afraid" of math. Anyone who comes from an
engineering background or any core science background is almost definitely not
"afraid" of math. If he particularly means Finite Automata and FSMs (which they
talk about in the article as being the holy grail for programming, sort of. Read
the article for the full picture) then even that is incredibly common. Anyone
who has taken an engineering course with an interest in Programming (even those
who don't have a major in Computer Science) will definitely do a course on
Switching and Finite Automata or Formal Language and Automata or Finite State
Machines themselves!

There was one thing in the article though, which I think appears fiercely to
everyone who writes code for a living:

> Programmers, as a species, are relentlessly pragmatic
