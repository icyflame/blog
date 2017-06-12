---
layout: post
comments: true
title: Learning React -> Understanding why Redux -> More time spent!
categories: programming react redux
---

So, I had this idea for an app. It's a pretty basic app and it takes the current
location and prints some distances. It does all of this stuff without an active
internet connection because **GPS DOES NOT NEED INTERNET.** It drives me crazy
that Google Maps won't download the area that I live in (which they might know
because I occasionally _have_ to turn on Location Services on my phone) or any
location that I tell it to.

From their POV, it's probably not the best because most of the traffic related
data on Google Maps is crowd sourced and you ain't getting no data from a phone
that is offline.

So, I decided to leap frog that and build a _simple_ app that would show you
your current LAT-LONG, store a list of some LAT-LONGs and then show you
distances to whichever places among those that you ask for. I decided to build
this in react because getting the current location in react is simple. REALLY
SIMPLE: `navigator.geolocation.getCurrentPosition((position) => { ... },
(errCB)`. I am sure I would have lost about 3 hours downloading and getting
gradle to build a hello world on my Linux machine! _THAT_ friction right at the
beginning of the road is really irritating.

But choosing React was not the ideal thing to do. I had heard enough about Redux
to know that it was a good thing that came in handy almost always. A global
state, you can add actions, your reducer will take care of it, etc. IT was all
very hi-fi and I believed (rather stupidly, I admit) that I won't need any of
that and that I could get away with it this time by putting everything in a
single component.

**Moral:** I finally ended up _having_ to send data / emit events in one
component and have the other component subscribe to them. I couldn't find any
reliable event emitter for React Native, which is rather strange but
understandable. Consider too that I spent about 2 hours finding an appropriate
component to select multiple items in a list. I was unable to and had to settle
for a search and add one-by-one approach. Atleast, I was able to find the search
and filter plugin easily.

So, the app is in a limbo state where it doesn't really work and won't until I
either fix this issue or rebuild the whole thing in Redux. I am sure that
rethinking the whole idea of the app and it's component structure in Redux will
take up more time than actually writing it down because very much like MVC,
Redux ends up structuring the app into independent self-sufficient components
that have no clue about what else is going on in the application.

One good thing that did come out of this excercise was my understanding of why
Redux is important and how it makes making even the simple apps _simpler_ and
_easier_ to design.

**Note:** I built the app in React Native actually, so all of the references to
React above are simply the "idea" of state and building the pure function
`render()` that works against state. The code for the app isn't open source yet,
I intend to make it available once it has reached a more complete state.
