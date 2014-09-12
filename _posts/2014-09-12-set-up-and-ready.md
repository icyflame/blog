---
layout: post
title: Setup. Ready to Roll!
comments: true
---

And finally, Hyde is setup. Now, the scene looks like this. Jekyll, powering the blog, Hyde, powering everything that gets rendered, and controls how it renders, the posts themselves hosted on GitHub (of course!), and me, pushing the posts from my machine!

No Web Browsers, No Usernames, and/or Passwords! jekyll is great. I wish I had taken the time to set it up sooner.

The setup was not really the most painless one that I have ever done, but it was good. One of the major problems which I faced was simply that the `post.url` was not being calculated properly, because, the function itself returned the URL of the post, but prefixed it with a `/`, and what that meant was GitHub went to the root of the website, instead of the present URL.

Enter, [StackOverflow](http://stackoverflow.com/questions/18427456/jekyll-using-relative-urls-for-post-url). I got the answer, Actually, finding the issue itself took longer than finding the solution, once I knew what it was. Pretty silly really!

Further problems arose, when I wanted to integrate [Disqus](http://disqus.com). Not really a problem, just a speedbump. And integrating this was pretty easy again, adding disqus shortname, adding the universal embed code to the template, and add comments:true to the front matter of the one post that was already online, and boom! Disqus is up and running! (You should see it below too, if nothing is broken!)

Enough about the setup. Now that it is done, the blogging must begin!