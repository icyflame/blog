---
layout: post
title: Rolling into production!
comments: true
categories: Web-Development
---

Ruby on Rails <3

Finally, we have rolled out our first ever production application written in Ruby on Rails. And by "we" I mean the Students' Alumni Cell. This is the first time that SAC has deployed a RoR app. We have been joint at the hips with PHP and CodeIgniter for some time.

The application is the Mentorship Portal, which is a centralized portal for the registration of mentors and students, and at a later point in time, we will also do the allotments through this portal. It's an application written in RoR.

There are some things about this application that I really want to say now:

- The templating language is ERB, for no other reason than that it is the one bundled with Rails and it was the first one that me and the team learnt.
- The application is deployed on a Phusion Passenger, with Apache. I didn't do the server setup. (In fact, I was in Chennai when this setup happenned! It was done by a certain [Rahul Mishra](http://github.com/light94)) Once I came back, I was delighted to see that the setup was up and running on an inhouse server. Till now, we had been deploying on the free plan of Heroku. (which in itself is pretty awesome!)
- There were a lot of issues that we faced when we were setting it up and subsequently when we were changing the code on the server often. One of the issues that we faced often was that the DB was not updated to the latest version. Now, we have come to a point when the mentor registrations have started and thus we have stopped pushing any updates to the server which require adding columns to the DB. This very often breaks the application and rolling back is not too easy either. One of the things that we felt was an issue was our use of **MySql**. Till now, we have always used PostGreSQL in Production and SQLite in development. This change didn't affect the code (Again, RoR <3) but it definitely changed a lot of the config and environment files, and tracking these changes is getting too complicated, and we will have to figure out something to ensure that this change doesn't backfire.
- Apart from this, the server itself was running without any problems. One thing that surprised us was that it never went down because of "Too many requests". We don't really know how much traffic we were handling, so, we don't know why this was the case.

That's about it!

Lately, I have also been writing an application in Django. It's a pretty simple application and could be developed in RoR within a couple of hours. But surprising is the fact that even in Django, which I was using for the first time, it did not take me more than 4 hours, in total to get the working application. I have not yet deployed it or open-sourced it on GitHub because there are a still a lot of refinements that I want to make and a lot of testing I want to do. (I have written the authentication system, so yeah. A helluva lot of testing is left to do!) I will probably write a post about this soon!

I found [this](http://light94.github.io/2015/02/28/Setting-up-Phusion-Passenger-with-Apache-for-Running-Rails-App/) post by [Rahul Mishra](http://github.com/light94) regarding the Phusion Passenger setup!

