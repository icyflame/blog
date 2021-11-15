---
layout: post
comments: true
title: Cutouts 1.0 and the convenience of monolithic frameworks
categories: cutouts applications versions rails ruby programming
---

[![image][1]][2]

This graph shows the commits made in the [cutouts][3] repository over the past 1
year. I have been rather dormant the whole year on this project. In fact, the
last time this project saw some heavy development was back in October 2016 when
I was working on adding tags to the system and making it a better product that I
could use.

The surge in development during February was right before the [Metakgp Demo
Day][4] on February 15th. There were same gaping problems in Cutouts that I had
never considered. And the main reason behind this was that there were no users
except me. And I was using the application just as it was intended to be.

When others starting using it, they told me that the application was crashing
whenever they tried to add a Cutout. The logs showed me that I was doing
`URI(link).host` for the `link` variable and there were no validations setup
that would ensure that users could _only_ add URLs in that field. This was
probably one of the glaring problems that I found and it acted as a trigger for
me to comb through the whole application and figure out what other assumptions I
had made which a non-me user would not instinctively abide by.

Adding tags was one, where new users expected tags to work differently. Another
open feature request is that the link field shouldn't be compulsory, instead the
user should be allowed to add text in that field. (Reported by [Kshitij][5] who
uses Cutouts to store quotes from books!)

After adding a title attribute to all cutouts, life on the application has
become far more convenient. Mentioning the charset in the downloaded HTML was
another minor goof that has lead to a prettier exported cutouts HTML page.

Yet another issue was with the ordering of cutouts. The default ordering
throughout the app seemed to be chronological, when the reverse chronological
order made a lot more sense as you would want to see the latest cutouts before
your older cutouts.

At this point, I was fairly happy with the quality of the application for new
users and the application had stopped crashing whenever people tried to do
things that weren't standard, instead it would either give a decent error
message or fail gracefully without crashing. This was the v1.0 point for
Cutouts.

A couple of other features that I wanted to implement mainly for my own benefit
but that I figured would bring more users in (because of the network effect)
were _sharing a cutout via email_ and _creating a permalink for every cutout_.
With the right meta tags, sharing them on Facebook and Twitter would cause more
people to visit cutouts and hopefully become members and use the app. Using
Rails [Action mailers][6], this was far easier than implementing something
similar would have been on a Node framework like Express. Creating a permalink
was again simply creating a show method for the Cutout controller.

During the Demo Day, [Vivek Aithal][7] gave me the suggestion of implementing a
feed of what everyone is cutting out. This was the ultimate way to use the
network effect to my advantage. Once again, Rails surprised me because
implementing it was [incredibly easy!][8].

The few things where Rails wasn't pleasant to work with were the updation of
the Rails version itself (which I didn't complete successfully, I am still on
Rails 4), the updation of Bootstrap to 5 (which I completed properly, although
it took an unreasonable amount of time to get there). The updation of the
versions of other Gems was much simpler. The bootstrap update gave me access to
the new color scheme that pops compared to the old, duller scheme.

Looking back at this revamp and relaunch, I realize that Rails has been very
very helpful whenever I have had to implement a new feature. Even if the feature
is involved and seems daunting at first, the pieces in Rails fail into place
very well and the implementation itself is tens of lines at most. Also, once
you make a commitment to using a monolithic framework like Rails for a big
project like this one, there is no going back. I don't even want to imagine what
sort of effort it would take for me to transfer the application as is to another
language.

Where Rails faces it's most frustrating caveat is the management of the
development environment. The different gem versions, the ruby versions, the
rails asset pipeline: handling them is a huge pain, they don't _just
work_<sup>TM</sup>. If you want to update a Gem, that's a completely different
battle and I wish you luck with fighting it.

Node.js on the other hand would probably need a few 100 lines to build these
features, but the dependency management in Node.js is way simpler. In fact, when
I went through the same process on [cli-cube-timer][9], the whole process was a
lot more pleasant and the main problem came up wherever the updated dependency
had changed an API. That seemed like a better use of time than struggling with
gem installations and those type of things.

I will still say that Rails is a good framework, despite the frustration that
has often caused me to question my choice of framework back when I started this
project. Implementing new features takes very less time and once you get the
hang of it, it's fun to write code in Ruby, although I have my own gripes with
the language. I will save them for another post. Another advantage of Rails is
the gem library and the community around it. There are gems to do almost
anything. But the same can be said about Node.js, so this isn't an advantage as
much as it is a leveller.

Right now, there are some minor changes that are upcoming on Cutouts. The
long term goal is to have an application that has good test coverage. The
short-term goal is getting to v1.1. I have [already missed the due][10] by 2
days and rescheduled further to the end of March. I will get there, soon. I
hugely underestimated how much I already had to accomplish in March.

**P.S** Cutouts now has a [Twitter account: @CutoutsApp!][11] If you use
Twitter, follow @CutoutsApp to remain posted!

[1]: /public/img/cutouts-past-year.png
[2]: https://github.com/icyflame/cutouts/graphs/commit-activity
[3]: https://github.com/icyflame/cutouts
[4]: https://medium.com/metakgp/lifehacking-add-ons-and-a-better-web-for-kgp-highlights-from-demo-day-3-ffc1fd6af7b
[5]: https://github.com/kshitij10496
[6]: http://guides.rubyonrails.org/action_mailer_basics.html
[7]: https://github.com/nuwandavek
[8]: https://github.com/icyflame/cutouts/commit/23c0b3b43ff62a4a1316b9c9f6eb44b6b85c345b
[9]: https://github.com/icyflame/cli-cube-timer/commit/45885bc0853fb39660cb91f5b8979b0f00a8d8b1
[10]: https://github.com/icyflame/cutouts/milestone/1
[11]: https://twitter.com/CutoutsApp
