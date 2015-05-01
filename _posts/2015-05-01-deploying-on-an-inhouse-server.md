---
layout: post
comments: true
title: Deploying on an inhouse server: Rant
categories: web-development
---

So, this is probably my first `rant` per se, on anything related to Ruby on Rails. And it's connected with a step that just can't be avoided by any Rails application: Production.

I never thought this would be much of a problem, since I had been using Heroku almost all my time with Rails, and deploys were super quick, and super-easy! Hardly ever did I run into any walls, and even when I did, the documentation on Heroku and Stack Overflow was more than enough to get me up and running soon.

Enter, Inhouse Server. So, in IITKGP, we have a set of servers that we administer as part of Students' Alumni Cell, and they are servers that are housed inside the [Computer Informatics Center](http://cic.iitkgp.ernet.in). We have SSH access to them, and they are connected to the Internet, and almost all the websites that are there in here, the Institute website, the ERP system for studetnts/faculty, etc, are hosted on inhouse servers, and maintained by Ops people.

You may ask, why the sudden need to deploy. Well, yeah, that's what we asked too! We had a running application on this server, but then, suddenly, everything stopped working, and we had to re-install Apache on the server. Well, that's easy right? yeah, it was easy.

After this, we configured one of the front end sites that we manage, the [Annual Alumni Meet Website](http://www.alumnimeet.iitkgp.ernet.in), and that was done pretty fast. We didn't have to change much, just edit the Apache Conf files a bit and boom, we were done!

Now, the one other Rails application that we had to host in here was the Mentorship Portal. (part of this has been open sourced, find the code [here](http://github.com/icyflame/mentorship-website-cum-portal).) We had been running on Passenger instance earlier, so we decided to keep the same Configuration, and we were surprised to find that passenger was already installed. So, in that case, basically, we didn't have to do anything, just follow the steps mentioned on the documentation of Passenger and voila, we should have had the application up, right? well, just that it didn't work that way.

We ran the steps that were mentioned on the Passenger documentation. Which was basically just one step `sudo passenger-install-apache2-module`, copy a few lines into the designated files, and restart apache2. Alas, it didn't start working.

So, we tried a lot of other things. (Contemplating a change from Passenger to Capistrano being one of them), but we couldn't get anything to work at all.

The one thing that did work for us was the Passenger standalone setup. This setup was perfect for us, except for the fact that this setup listens on port 3000 and we needed to listen on port 80, which is what we had configed in Apache2. But, barring that we could fix this. (By simply redirecting from Apache to Passenger), we would have had a working web server.

Then, another roadblock! Turns out that the alumnimeet website that we believed had been setup was actually working only inside the campus network, the site was still inaccessible from outside the campus network. This is something that we just can't seem to fix. We will have to contact the people at CIC, and get this fixed.

Deploying with Rails was apparently tough, before Passenger came along, but seriously, deploying with an InHouse server will probably always be tough. Atleast, when you don't do that for a living :/

Rant End.
