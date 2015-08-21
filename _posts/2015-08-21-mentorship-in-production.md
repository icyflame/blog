---
layout: post
comments: true
title: Mentorship in Production!
categories: web-development
---

Finally, a Rails application in production. And already, we have started facing problems! Whoever said deploying and maintaining web apps is more than half of the job, was definitely right!

[![mentorship](/blog/public/img/mentorship.jpg)](http://www.mentorship.iikgp.ernet.in/)

In this post, I hope to outline exactly what lead to the deployment, and how we handled it, and what lead to the present wall that we are facing.

I am not sure if I wrote about this before, but still, a short introduction about the Mentorship Portal. It's a Rails application, that we had written last semester, between January and March, and had hoped would take the whole Mentorship Programme run by Students' Alumni Cell online. It did exactly that, and everyone registered. The allotment was getting held up, because somewhere down the line, we screwed up the server config, as it had crashed, and we couldn't get it back up. When I came back for this semester, I was determined to solve this, and solved it in the first few days.

After that, we faced the mailer problem. We couldn't send emails through that server because it was not configured to be an email relay. We found out that there were other email relays, that we could get access to, provided we could get over some red-tape first.

Since all we had to do was just to send a mass mail to everyone saying that the allotment has taken place, we immediately did that, using another mass mailer that we already have a license for. Soon after this, the page started getting a lot of hits. (close to 100 a day, during the first few days after the mass email was sent out. For posterity, it's been only two days since!)

One big big feature that was missing from the portal was the `Forgot Password` feature that almost all of us have come to take for granted. One basic thing that is required to solve a problem like `Forgot Password` is that the server must be able to communicate, either by sending emails or SMSes. The one other alternative was asking Security Questions, but those will never guarantee complete security, and we didn't have enough data on the users to safely use that.

So, we started getting emails on a monitored inbox, and I was manually mailing the `reset_password_hash` to all the people who had forgotten their password, they later visited a page where they entered this hash and the email ID and created a new password.

The only problem with this approach was that the manual mailing part was very very time-consuming, and ideally, this was something that should be done by the server.

Anyways, I continued to try to use Mailgun Servers to send email. But weirdly enough, the Python script that I was calling from inside Ruby was just not working. A debuggin session that lasted more than 45 minutes led to naught, and I was frustrated and left the idea.

Today, I have spoken with the institute people, and it turns out that the red-tape for using the mail relay that these guys have setup is not a lot and we can get over it, with some perseverance.

So, that's where things stand at now. We will get the permission to use those relays within the next couple week probably. But till then, I will have to generate the hash and mail all the users their hash. Not the most ideal setup.
