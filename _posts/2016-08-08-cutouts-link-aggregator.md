---
layout: post
title: Cutouts, really Just Another Link Aggregator
comments: true
categories: web-development projects
---

![image](/blog/public/img/cutouts-1.png)

I use [Pocket](https://getpocket.com). And I love it, I love the offline sync
functionality that they have. It is incredibly useful whenever you are
travelling or going somewhere without Internet access (God Forbid!). But there
is one thing that I have never been able to get over, about Pocket, and it's
that although, it's a great store for articles until you read them, once you
have read them, it's not a good store at all. For one, all stored articles take
up space on your mobile, tablets etc. Next, the tagging system doesn't really
work that way. Going into the Read / Archived section will show you a list of
Links, and there's no way (except for the `Favourite`) option to really mark an
article as `I REALLY LOVED IT!`

Now, storing articles that you have read seems more of a thing that Pinterest
would do, right? You pin the articles that you loved on the board that you
really think it should be on, and I like that idea. But I hate the Pinterest UI,
in the browser. The app is marginally better, but it just feels blocky and
doesn't flow at all.

And now, coming to what I built. [Cutouts](https://cutouts.herokuapp.com) is a
link aggregator without any of the bells and whistles of Mobile Applications and
Browser integrations. It is one single web page. You sign up, you start adding
articles right away. For every article, you have three fields (I thought about
the number of fields and this made sense right away).

- Link to the Article
- Name(s) of the Author(s)
- A quote from the article itself - Something that will remind you about what
		this article was really about and generally, I tend to use the catchphrase
		from the article. You can use anything! (You might also enter your own
		comments in here, but that won't work with the UI that I have planned, but
		it's fine of course!)

I have been using Cutouts for almost 3 months now, and I have added quite a few
articles. I really love the simple UI that I chose to have, which is just a form
on the left and the top 10 articles, reverse-chronologically sorted, on the
right side. Nothing else, and this alongwith Turbolinks on Rails means that the
page loads extremely fast for something that is hosted on the Free plan on
Heroku.
