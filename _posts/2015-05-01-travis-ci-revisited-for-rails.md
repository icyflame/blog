---
layout: post
comments: true
title: Travis CI : Revisited for Rails
categories: web-development
---

This post is long overdue. Now, that the semester is over, I have found time to do two of the things that I intend to completely master over the summer: NodeJS and Formula 1 2014. While the first is a programming framework which has a staggering amount of possibilities, the latter is a game for the PC, that has completly taken me out.

I started playing F1 2014 sometime around March, this year, and I found it to be really boring in the beginning. But then, I got into seeing gameplay videos of the game. And in particular, [this YouTube channel](https://www.youtube.com/user/tiametmarduk1), where videos are uploaded by [this guy](https://www.twitter.com/tiametmarduk). The gameplay videos are great! Fun to watch, but the part I love the most is the live commentary given by the player. It's just awesome!

Well, now, coming back to the title of this post. Travis CI!

Some time ago (about 6 months ago), I posted [this](http://icyflame.github.io/blog/web-development/2014/09/28/cracking-travis-ci/) about TravisCI. It was a naive post about getting Travis to work for a PHP project, I couldn't get it to work at the end, but I had not abandoned it completely.

Now, when I went back to travisCI for a Ruby on Rails project, well, I was dead-set to get it right, and surprisingly, all that determination and dead-set-ness was a bit anti-climactic, as the setup was painless. 

In fact, the setup was so painless, that I went on to integrate Heroku with TravisCI for automated deploys. Further, I also integrated a Slack channel into the whole scheme of things. (I am going to post about my love for Slack soon after this!)

So, now, my stack looks like this. A Ruby on Rails project, on which two people are working. For every push, Travis builds the project and posts the status on our Team channel at Slack. This is done for every branch, every pull request etc.

Now, coming to the auto-deploy part. Every push that I make to the staging branch is built, and if it passes the build process, then the code on that branch gets deployed to a staging Heroku application. And every push that I make to the master branch gets deployed to the production Heroku application.

So, basically, I have a complete automated app up and runing, in which all I, as a maintainer, have to do, is check the front-end and push to staging, check the front end on the staging Heroku application, and if that checks out, I simply merge the staging branch with master, and boom! The production application on Heroku gets updated and everyone gets the changes that I had pushed.

This is awesome! I had never really imagined that I would be able to do so much, so soon and so painlessly. This streamlines the code-to-deploy process a whole lot! No worrying about setting up heroku remotes, the Heroku account you are signed in on the CLI, pushing a wrong branch to the application.

Or the worst, pushing changes that break the application to the production app, affecting everyone who is dependent on your application.

So, that is TravisCI for Rails. Somehow, I think that the change in the platform that we are using PHP -> Ruby on Rails, made the process so much more simpler and easier to handle. Well, I won't forget to include this in my list of `Why I love Rails`!

So, some housekeeping information. The project that I have been talking about is the Networking Portal Project. Find it on Github [here](http://github.com/icyflame/networking-rails). This project is licensed under MIT.
