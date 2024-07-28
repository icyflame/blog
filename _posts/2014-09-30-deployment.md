---
layout: post
comments: true
title: Ship it!
categories: web-development rails
---

So, after the previous post, which actually caught the attention of the people at Travis CI, I am
back with the next part of the application lifecycle.

[![twitter-screenshot](/public/img/2014-09-29-travis-ci-conversation-screenshot.png)](https://twitter.com/_icyflame/status/5162296267884544000)

**Shipping!** Although, the word is simple, and the process is pretty easy to understand, it was something that I obviously, had never done before, and didn't have any idea what it meant either. Because, till now, I have worked with PHP and deploying PHP is simply copying the files onto a server that supports PHP hosting (whatever that means!). Rails, though, was a different game, altogether!

[Heroku](https://www.heroku.com/), seemed to be the platform of choice, on the internet. So, I went through the Heroku Getting started for deploying rails guide. This guide itself was very informative, and surprisingly, easy to follow. There were some issues that I did face in the process, I will be detailing some of them below!

**SSH** Back on campus, since we were behind Proxy servers, which listen on port 8080, Heroku is not easy to setup from the terminal. I have not yet found out how to do it, but I believe that it can be done, and I will be asking some of the people I know for some ways to work around the proxies and get stuff done! But, here, at home, I am connected to the internet. And Proxy servers DO NOT exist! So, SSH is possible. And some time before, when I tried to follow this same guide from campus, I found that you could push to heroku only using SSH. I had given up on campus, but out here, it's a new day and I could try again

SSH was easy to setup, `ssh-keygen -t rsa` created the public key and `heroku keys:clear` followed by `heroku keys:add` completed the process. Running `heroku create` configred the rails app, and then came the moment of truth, `git push heroku master`. And bam! I ran into `Permission denied (publickey)`. It was a two line error message, and told me exactly nothing about the problem that the application was facing, so I delved into the internet and [Stack Overflow](http://stackoverflow.com) (duh!) came to my rescue. [This](http://stackoverflow.com/questions/4269922/permission-denied-publickey-when-deploying-heroku-code-fatal-the-remote-end) question told me what needed to be done. So, I did what the accepted answer told me to do, but it didn't work for a couple of times. After some time of tinkering around with the `keys:clear` and the `keys:add` commands, it worked for the first time.

Bam! Second checkpost! `sqlite is not supported on heroku`. This was an error that went on to give me quite some pain! Sqlite is the database of choice in development environments, especially in Rails and Django, all the setup is done when the application is created. But at the production level, obviously, I couldn't expect Heroku to deploy my database on sqlite. But I naively believed that either Heroku or Rails, would automagically handle it, Alas, it didn't.

Enter [Heroku Dev Center](http://devcenter.heroku.com/). And stack overflow, of course! I got the solution after some amount of digging around. [This](https://devcenter.heroku.com/articles/sqlite3) post on the Heroku Dev Center dedicated to sqlite, and [this](http://stackoverflow.com/questions/21297160/detected-sqlite3-gem-which-is-not-supported-on-heroku) question on stack overflow, showed me the way. I learned about grouping gems in the Gemfile. And after doing what the DevCenter guide told me to do, I made it work. And whoa! It worked. The application was deployed at [http://calm-headland-9735.herokuapp.com](http://calm-headland-9735.herokuapp.com/) (where it is still deployed!). But there was one thing to be fixed as of now. The bootstrap elements were not rendering properly. It was like bootstrap was not loaded at all.

This seemed to be easy to fix, and it was easy! [This](http://stackoverflow.com/questions/16271696/cant-get-css-working-on-heroku-using-rails-4-with-bootstrap-saas-gem) question immediately showed me what to do! Just the addition of the four lines at the beginning of this answer to the `production.rb` environment file, fixed the problem. And the second push worked.

In the mean time, I learned that you push from the local branch `deploy` to the remote branch `master` by using `git push heroku deploy:master`, so that at the other end, the local deploy branch is merged with remote:master on arrival. This seemed to be cool. But I am still not clear whether the conflict management at Heroku's end is similar to how git does it, because if it is, then I would have expected some notification from Heroku, asking to me to fix all the conflicts, or push something that didn't conflict with their copy of the repository. I am trying to find more stuff about this!

Also, all through this process, Travis CI was continously building. And that was awesome. Also, Travis also built new branches pushed to the repository, so the deploy branch was being built continously whenever I pushed to it on Github. I also created a tag somewhere during this process, and even this tag was built by Travis!

**Note** I intend this post to be a collection of all the stuff that I needed to make Rails applications work on Heroku!
