---
layout: post
comments: true
title: Cracking Travis CI.
categories: web-development
---

About a month into this semester, I found out that [Travis CI](https://travis-ci.org/) is actually free for open source projects. And since all of my projects were open source, and I had already seen those great looking [![Build Status](https://travis-ci.org/icyflame/alum-cell-blog-rails.svg?branch=master)](https://travis-ci.org/icyflame/alum-cell-blog-rails) badges on some repositories, I was excited.

Building a project was something new for me. Generally, all I really cared about was how it rendered on the screen, but building a projects, and running Unit Tests (which was the single most intimidating thing according to me) was new and something that waited to be explored! So, I set out on the journey to crack Travis CI and get the above badge on the README files of one of my repositories as soon as possible.

Naive as ever, I tried to start with a PHP project. Although, right at the beginning the process seemed to be simple, add a .travis.yaml YAML file and push a commit to GitHub and wait for Travis CI to detect the commit and try to build the project at that commit, the process was obviously not so simple!

In fact, there were some build errors which kept coming up, no matter how I changed the PHP project, the YAML file or the environment variables. And somewhere along the process I realised that since I was starting to get used to rails anyway, I should try it out with rails.

And this I began with. Although, an empty project of rails was compiling, I was getting an error called `Parameter Missin` when it was running the two tests `test_should_get_create` and `test_should_get_show`. I didn't really understand what was going on, since I had no idea what the architecture of the whole thing was, and I had no insight into the build lifecycle. I had stared at the build console output for a couple of hours, but at the end of the day, I just decided that I would figure it out later and ditched it and went on learning rails.

Today, (is my first day back at home, during the Durga Puja vacations), I designed to build a rails port for the Create Together application that I had already written using Code Igniter in PHP. It seemed to make more sense to start writing an application that I had already built and knew exactly how I wanted it to work, before trying to build a compeltely new application from scratch. I had tried to build something up from scratch, but then, I realised that I didn't know enough Rails to do that.

So, around 2 in the afternoon, today, I sat down and started working on the app. I got out my pen and paper and literally drew a diagram of what all resources I would have (Rails lingo!) and the connection between all these resources.

Once I had this on paper (This was the first time I was actually drawing something before developing, everytime I thought of doing this before today, I ended up ditching it because it just seemed to take much more time than I would have spent if I had simply started developing. But today was different, I was learning rails for the first time, and I wanted to do it right!

So, about three hours into the endeavour. I had a basic architecture up and running, I could add administrators and contributors, I had decided to queue up posts for a little later because posts were tied with contributors from the inside and  this was something that I had to digest before I could start coding it. Somewhere along the line, I realised that since, I was all about doing this right, shouldn't I also try to get Travis CI to work so that I could really claim that I knew the complete application lifecycle?

So, I created a github repository and pushed the offline git repository online to GitHUb and configured Travis CI with the basic .travis.yml file that's on the documentation for Ruby, and built the project. Voila, build failed!

For the next five builds, the build kept failing. The error was the same, exactly the same. `Parameter Missing`. So, then again, I started reading up about rails tests and how unit tests were written. After the sixth build, I had delved deep into the problem and I was pretty sure that I was pretty close to the solution! Alas, I was mistaken. It would take me about 40 minutes to figure out what the problem was, and another half an hour to fix it.

20 minutes into the internet effort, I was convinced that the issue was with the test cases. One of the test cases that was there somewhere in my repository was creating an issue, and thus, Travis was not showing a successful build, because the only thing that Travis can look at is the response that the test cases give him, so as to assert whether or not the project is good to be deployed.

SO, now, for the first time, since I started writing Rails, I went into the `test/` folder in my repository, there was something called `fixtures`, which I read about on the official Rails unit testing documentation, and that was clear, and there were two other things `models/` and `controllers/`, tests for the models and the controller classes. I delved into models, because in the back of my mind, I had the (wrong) notion that everything related to parameters and `record not found` stuff would be an issue inside the model and not inside the controller.

But again, I was proved wrong (I was almost frustrated enough to ditch everything and go back to the application), when suddenly, I found three controller test files I had never seen before, and in this file, I could see the root of the problem.

Yay! I found the problem! But now, I had to fix it. The simplest fix was obvious, just comment out the code causing the issues, I was sure what was the problem and indeed, it solved the problem (I ran `rake` on my machine to check if all the test cases were compiling with the two test cases commented out, and they did!), But I wasn't really sure if that's how Travis did it, and I was afraid that one more commit gone wrong would simply break the repository and I would have to find a solution again, so, now that I had found out that it was the `get` method which was being called without the appropriate parameters that was causing the problems, I did a simple search **passing parameter to get method rails**

The search results were not what I expected, because I couldn't find any documentation on the get method at all. I don't know if my key was wrong or what, but it just wasn't there. So, scrouge around the beach, for half an hour more and I did find the answer to my problem on [this](http://stackoverflow.com/questions/1430247/passing-parameters-in-rails-redirect-to) stack overflow question. It wasn't really what I was looking for, as it gave information about the `redirect_to` function and not the `get` method, but I had to make do, and I just tried to replace the two keywords, and after some tinkering around I found the solution.

So, now I have a passing [build](https://travis-ci.org/icyflame/alum-cell-blog-rails/builds)! And I have embedded the `build passing` badge on my repositorys readme! yay! mission accomplished!

For those who are interested, or God forbid, if you are facing this problem, check out the [git diff](https://github.com/icyflame/alum-cell-blog-rails/commit/e3cab28b26393ab6375d009da529d1670fa6132a). I am sure that this is as verbose as it gets. And if you don't get it, (I am afraid I might not, in case I see it after a few weeks), comment down below!

Note: This is a confused post, I know, probably because I am kinda excited right now. But I may give out another post explaining exactly what the problem was, alongwith error logs and git diffs, and everything that I went through in much more detail, later this week!