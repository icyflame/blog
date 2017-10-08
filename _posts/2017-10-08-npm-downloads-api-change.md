---
layout: post
comments: true
title: NPM changes downloads API and informs two days after
categories: npm api goofs software
---

There are two parts to this post. The first is about what happened,
chronologically and the second part is about why I was so disappointed with
this.

Now, for the more verbose version:

## What happened?

* Around 10 AM on 29th August, 2017, I was proof reading my resume and clicked
    on one of the npm-stat.com links that I have there. I reached that page and
    realised that the number shown there was drastically low compared to the
    number that I already knew was the real one.

    I was surprised. The first thing that came to mind was that NPM had deleted
    the old data leading to the downloads in 2015 being shown as 0. I
    immediately dug a bit more and checked other packages. I also checked some
    really famous packages like `express` and users like @sindresorhus. All of
    their downloads were being shown as 0 in 2015.

* I dug a bit more and reached the code-base for
    [npm-stat.com](https://github.com/pvorb/npm-stat.com) and from the line on
    the website "All data comes directly from NPM", I realised that the website
    probably worked using an API from NPM itself.

    npm-stat.com is a webpack based frontend JS app. I have some experience with
    them and thus, I was quickly able to figure out where the API call was
    happening.

    It was [these 3
    lines](https://github.com/pvorb/npm-stat.com/blob/b79fb8abc7a200c687c9f6985c86a46402a53792/src/charts.js#L266-L268):

    ```js
    function getDownloadsUrl(pkg, fromDate, toDate) {
    return '/downloads/range/' + dateToDayKey(fromDate) + ':' + 
    dateToDayKey(toDate) + '/' + encodeURIComponent(pkg);
    }
    ```

    The request is of the form: `/downloads/range/2015-05-01:2016-11-01/terminal-wallet`

* Now that I had found out the downloads API itself, I immediately checked if
    the data for 2015 was there or not. I found that it was. This was a relief.
    I immediately downloaded JSONs of everything from 2015 to that day, but this
    was where I noticed the rate-limiting!

    I requested data from 2015-05-01 to 2017-08-29 but it only returned data
    starting from 2016-02-29, that's exactly 18 months before the end date. I
    had found the issue!

* This was the first real milestone. Once I realised what was going on, I
    immediately reached out to people:

    (a) Open a ticket with NPM support

    ![img](/public/img/npm-blog-support.png)

    (b) Tweet to [@izs](https://twitter.com/izs)

    <blockquote class="twitter-tweet" data-lang="en"><p lang="en"
    dir="ltr">Hey <a
    href="https://twitter.com/izs?ref_src=twsrc%5Etfw">@izs</a> , looks like
    the /downloads API changed on NPM? Range now replies only from 18 months
    prior!<a
    href="https://t.co/ixlGEMSBaD">https://t.co/ixlGEMSBaD</a></p>&mdash;
    Siddharth Kannan (@_icyflame) <a
    href="https://twitter.com/_icyflame/status/902407527702315008?ref_src=twsrc%5Etfw">August
    29, 2017</a></blockquote>
    <script async src="//platform.twitter.com/widgets.js"
    charset="utf-8"></script>

    (c) Open an issue on
    [npm/registry](https://github.com/npm/registry/issues/206). Here again, the
    complete issue was explained.

    (d) Send an email to [Paul Vorbach](https://github.com/pvorb) who's the
    maintainer of npm-stat.com.

* All this was going down at 11 am IST on Tuesday 29th August 2017. That's 10:30
    PM PDT which is the timezone NPM support seems to be operating in. So, I
    wasn't expecting a response from them until the next day at the least. I got
    an official reply on the support ticket 17 hours after at 4:44 am on 30th
    August 2017.

    ![img](/public/img/npm-blog-ticket-response.png)

* After all this reaching out, (it was around noon already), I sat down to
    work a patch for npm-stat.com. It took me about a day. Around 4 pm the next
    day, on August 30, I opened [npm-stat.com #47](https://github.com/pvorb/npm-stat.com/pull/47).

    There was one round of back-and-forth with @pvorb before the PR was merged
    in on September 7th, a week later.

* On August 31st 1 AM IST, 38 hours after I first noticed the problem,
  (I have no way to know exactly when the API was changed), they
  announced the rate-limiting on [their
  blog](http://blog.npmjs.org/post/164799520460/api-rate-limiting-rolling-out).

    ![img](/public/img/npm-blog-post.png)

    The documentation on npm/registry that they are talking about was added in
    two commits:

    [chore: document downloads api
    limits](https://github.com/npm/registry/commit/b0adb965c15936114751377401b7f35b1f51d425)
    at 2:08 AM IST on August 31st

    [fix: jan 10 not jan
    01](https://github.com/npm/registry/commit/73f3ac456e1d80ffe0d49d19a74bfccdb58b4aaf)
    at 2:24 AM IST on August 31st.

    I found this from [git's blame
    view](https://github.com/npm/registry/blame/73f3ac456e1d80ffe0d49d19a74bfccdb58b4aaf/docs/download-counts.md)

## Why do I even care?

> It's just a downloads API, CHILL MAN.

No one actually said that to me, but you might be wondering why this was such a
big deal for me.

Mainly because I have download numbers on my CV and when someone clicks on the
link and sees a number less than the number they just saw and no apparent
explanation, it's a bad look. There's almost no explanation that can be given in
less than a few minutes time. (Hence, the request to Paul Vorbach to put a note
on his website)

Also because this was unprecedented! This sort of an API change (i.e. a change
without any prior warning) leads to every tool that depends on the API
malfunctioning! Their official stand is that they will keep doing it in the
future as well, and they will only _follow-up_ with documentation:

> We reserve the right to further limit API usage without warning when we see a
> pattern of requests causing the API to be unusable for most callers. We’ll
> follow up with documentation in these cases. Our primary goal is to prevent
> API use from either deliberately or accidentally making the service
> unresponsive for other users.

## Conclusion

I like NPM. Irrespective of that, if you want to work with Node.js then you are
absolutely going to HAVE to use it. There are many things that could have been
done better here: more warning before such API changes, better choices after.
Even something as small as a tweet an hour before the API change was deployed
would have been notice enough, in retrospect. How about adding a field to the
`/downloads/` api response that informed the user that the data is not for the
complete range that they requested because of a new API change. **Explaining a
change 38 hours after it is just not acceptable for an API that's so
prevalent.**

## TL; DR

NPM limited their `/downloads` API to return data only for the last
18 months if you request for a range more than 18 months. They informed the
world about it 38 hours after I first noticed the change. This lead to
npm-stat.com malfunctioning and showing drastically low numbers because of years
of data was simply not there.
