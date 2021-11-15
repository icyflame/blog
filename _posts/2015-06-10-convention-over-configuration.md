---
layout: post
title: Why developers shouldn't have to deal with configuration
comments: true
categories: web-development ruby-on-rails
---


Ruby on Rails is built on the principle of convention over configuration. Right upto now, I have deployed production applications on an in house server which invariably ran into some wall or the other. (Check out my rant about this [here](http://icyflame.github.io/blog/web-development/2015/05/01/deploying-on-an-inhouse-server/)) Meanwhile, we did test runs of all the applications on Heroku, and that ran without any issues, almost all the time. (Except a couple of times, before I discovered `rails_12factor` ) But this flawless ness was never put to the test, in a live environment, with lots of non-developers, users using it. 

Finally, today, I got the chance to deploy [erp-rails](http://github.com/icyflame/erp-rails) to Heroku. (Huge sigh of relief!) It is now deployed and ready to be used. Active use will start only in August first week, when the new second year team is recruited. 

So far, there has been one feature which I have added over the past couple days. And the feature addition included a change in all three fronts of the website. A migration changing the schema, new endpoint in the controller, and JavaScript validation code in the form. It was pure development, no change in configuration at all. No going through the logs repeatedly, no chceking JS `console` on the browser, nothing of the sort at all.

This is also the first time round when I have been actively using GitHub issues to maintain this project. It is a major productivity enhancement tool, allowing us to maintain more than one component in the same application without issues. 

Travis CI is the other tool that I have used and am extremely happy with! The auto deploy feature of Travis CI is just _painless_. Once setup, (about 150 commits ago), I haven't had to change anything at all. A change in the application name, and that's about it. 

The apps get deployed appropriately, builds get logged. And once in a while, when you get the **Errored** email, you just have to go in and see the log!

I guess configuration is inevitable, and everyone needs to go through it, **once**. That should probably be the case all around, you configure once and don't have to re-configure unless there is a major change in the application architecture. Certainly, no configuration should be required for running regular migrations, updating features, etc. (we have had to deal with some major pain due to migrations, and we have considered more than once the possibility of moving to something like MongoDB.)

So, for now, the stack consists Ruby on Rails, GitHub, Heroku, TravisCI, Slack, all of it powered by a Linux machine and Git!