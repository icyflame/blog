---
layout: post
comments: true
title: Review - Subprime Attention Crisis (Hwang)
categories: internet advertising economics
---

**Rating:** 4/5

**What would happen if all the free services that you use on the Internet, which are powered by
advertisements, stop being free one day?** This is the premise of the Subprime Attention Crisis. If
you ask yourself this, you might realize that many of the services that we think of as free are
powered by advertising. For me, the most frequently used services that are ostensible free are
Google Maps, WhatsApp and YouTube. I use at least one of them almost every day. If they were to
become paid services, or the hurdles to using them without giving up too much data increased, it
would be mildly annoying. This calculus will be very different for an Internet user who uses Gmail
and uses it to receive important communication. Hwang's argument is sensible and easy to
understand. He starts from the basics of advertising on the Internet and builds up to his myriad
theses: Programmatic advertising is very similar to the financial markets. Ad networks claims that
targeted advertising on the Internet is better than "spray everyone" advertising on TV.  This claim
is a lie and that banner ads don't really change consumer behavior. Commercial interruptions are
blocked by users using ad blocking plugins or because users reliably skip ads on video-only
platforms in under half a second. To back all of this, he presents a lot of industry research and
anecdotal evidence. This was a convincing case for being aware that free services could stop being
free any day, and there would be nothing really surprising about it. (Just the other day, YouTube
took a step [towards blocking ad blockers.](https://www.theverge.com/2023/6/29/23778879/youtube-videos-disabling-ad-blockers-detection))

<!--more-->

Concrete examples are helpful to set the stage:

-   Gmail is a free, e-mail service that launched in 2004. In the past 19 years, it has grown rapidly
    and now has [1.5 billion active users](https://en.wikipedia.org/wiki/Gmail). Gmail.com has become the most common e-mail domain. Gmail is
    run by Google, a search engine company, which had a total revenue of $70 billion between January
    and March 2023. **78%** of this revenue came from Google's advertising network.[^1]
-   Facebook (now Meta) is the company behind 3 of the most common messaging and social media apps
    today: Instagram, Messenger, and WhatsApp. Facebook was launched in 2004, WhatsApp in 2009 and
    Instagram in 2012. Both Facebook and Instagram are powered by ad revenue, while WhatsApp is a
    popular end-to-end encrypted, ad free messaging platform. 3 billion people used at least one of
    these apps in March 2023. Facebook's total revenue between January and March 2023 was $28.6
    billion. **98%** of this revenue came from advertising.[^2]


# What is Programmatic Advertising?

Programmatic advertising is a marketplace with buyers and sellers. Publishers (like the New York
Times news website) sell space on their websites, where ads can be displayed. Buyers (like a local
business) buy this space to display an advertisement about the goods or services that they
provide. The commodity that is being traded (in the abstract) is the attention of the person viewing
the publisher's web page. The process that decides **which** ad should show up on a **webpage** when a
user is visiting it is called [Real-Time Bidding (RTB)](https://advertising.amazon.com/library/guides/real-time-bidding?ref_=a20m_us_blg_progadv_rtb). RTB is a sub-100ms auction where the buyers'
ad networks look at the data that is available about the user and decide how much they are willing
to pay to show a given ad to them. This process is easy to imagine when a few transactions are
happening in an hour. But the process happens at a much larger scale and is completely
automated. The technology behind it is probably complex, and (as Hwang demonstrates) publishers
often don't even know which ad network served a given ad on their website.[^3]


## Standardizing the Marketplace

There is one hiccup to setting up this marketplace. **When exactly can we say that an ad has been
shown to the user?** In other words, when exactly has the user's attention been **captured**? This is
clearly hard to define. In a long news article, if the ad was displayed after the 10th paragraph but
the user stopped reading the article or clicked on another link after looking at the headline, the
ad was not viewed and the publisher should not be paid for placing an ad there. These things are
specific and explain what ads should look like and when they should be considered to be "delivered."
I looked through the website of the Interactive Advertising Bureau (IAB), which sets these
standards to find 2 interesting examples:

For ads that are delivered to a desktop web browser, ad measurement happens when the ad content has
been downloaded by the client and counted as delivered when it begins to render. The actual
guideline goes into excruciating detail and tries to define **everything:**

> An Ad Impression across all display marketing channels is the measurement of responses from an ad
> delivery system to an ad request from the user's browser, which is filtered for invalid traffic and
> is recorded at a point as late as possible in the process of delivery of the creative material to
> the user's browser. The ad must be loaded and at minimum begin to render in order to count it as a
> valid ad impression. Measurement of begin to render should include logical components necessary to
> display the ad, but does not necessarily include logical elements that are not essential (such as
> other tracking elements)
>
> &#x2013; <https://www.iab.com/wp-content/uploads/2017/11/Desktop-Display-Impression-Measurement-Guidelines-US-MMTF-Final-v1.1.pdf> (p.5)

For [podcasts](https://iabtechlab.com/standards/podcast-measurement-guidelines/) (an audio medium), there are two metrics. The first one measures whether the file
containing the ad was delivered:

> Ad Delivered: an ad that was delivered as determined by server logs that show either all bytes of
> the ad file were sent or the bytes representing the portion of the podcast file containing the ad
> file was downloaded.
>
> &#x2013; <https://iabtechlab.com/wp-content/uploads/2021/03/PodcastMeasurement_v2.1.pdf> (p.16)

While the second one measures whether the podcast client can confirm that the ad was played:

> Client-Confirmed Ad Play: counts an ad that was able to prompt a tracking beacon from the client
> when the file was played. Whenever possible, metric should include information about how much of the
> ad was played using the markers: ad start, first quartile (25%), midpoint (50%), third quartile
> (75%), and complete (100%).
>
> &#x2013; <https://iabtechlab.com/wp-content/uploads/2021/03/PodcastMeasurement_v2.1.pdf> (p.16)

Like commodities trading, the attention that is being traded in these IAB standards is different
from the underlying "thing." It has been standardized and defined in an effort to attain an
unattainable perfect commodification of the user's attention.


# How is Programmatic Advertising Different?

Advertising is not a new concept. Newspapers have been funded by classified sections and outright
advertisements for at least a century. Hwang identifies 3 things that are different about
programmatic advertising:

1.  The **speed** at which advertisers decide whether or not to serve an ad to a user on a webpage is
    much faster than before. Before buying an ad on a television show, or a newspaper, ad buyers
    would generally do months of research about viewership/readership data. This data was not perfect
    either, but the time that these decisions took was much longer.
2.  The **volume** of ads that are served to users per minute has increased. On TV, a 30 minute program
    has 22 minutes of content and 8 minutes of advertisements. Online, a single news article which
    one would read in about 5 minutes can have 2 banner advertisments. Video streaming platforms are
    worse with 30 second advertisements for videos which are less than 5 minutes long in some
    cases. There is no way to say _how much_ exactly the volume has increased. But the lack of this
    data should not prevent us from noticing that the number of ads we see on a daily basis has
    skyrocketed.
3.  The **granularity** with which ads can be placed within a piece of content has increased. A
    newspaper has a given section for Classifieds, magazines assign pages or the back cover for
    advertisements, and TV shows demarcate content and advertisements very clearly. ("Mute the
    commercials, will you?") Online, where ads are placed can be controlled right down to the
    paragraphs between which the ad shows up or the section of a video in which the ad would be most
    effective.


# Similarities to Finance

The executives who were building advertising on the early Internet and trying to figure out how to
make these new services profitable were from the finance world. **For e.g.,** Sheryl Sandberg, widely
regarded as the person who was [responsible](https://www.axios.com/2022/06/02/sheryl-sandbergs-advertising-jackpot-facebook) for teaching small businesses to use programmatic
advertising, had a background at the World Bank and the United States Treasury. The model that they
chose to replicate for programmatic advertising was the one of high-frequency trading.

The most important similarity is **market opacity.** When the commodity that is being traded is not
well understood or its value is misunderstood by market participants, a crisis of confidence is
always looming around the corner. This is what [Raghuram Rajan](https://en.wikipedia.org/wiki/Raghuram_Rajan) and [Reinhart](https://www.goodreads.com/book/show/6372440-this-time-is-different) have both argued are the
prerequisites for the creation of a bubble in any economy. The crisis of confidence will trigger the
boom/bust cycle as in the financial markets, as marketers realize that the money they spend on
programmatic advertising is not delivering the returns that they were promised and stop spending as
much. One question here is **whether** the old markets of advertising (television, radio) were not
just as opaque? Of course, they were opaque too. However, the marketing that was done on TV or radio
did not claim to be targeted or very good at anything except raising brand awareness in the first
place. A famous ad industry adage is "Half of the money I spend advertising my product is
wasted. But I don't know which half." The opacity in the market was accepted as a
condition. Programmatic advertising makes unattainable claims about being targeted and measurable;
while simultaneously, publishers are not sure which ad network is delivering what ads to their
users.

Another similarity that Hwang talks about is the "private market." Companies like Facebook and
Google have premium ad space which is sold on private markets. This limits the information available
in the public market, and makes it hard for advertisers to figure out how much a given webpage is
really worth paying for.


# A Bubble in The Attention Economy

First, **ads don't work.** When WIRED, one of the early websites, ran a banner ad, 40% of people who
saw it clicked the ad. Today, even 1% is a pipe dream, with the average being about 0.2-0.4% of
viewers engaging with ads. One way to evade this critique is by saying that advertisers are doing
"brand advertising." Brand advertising simply focuses on showing people brand names and products and
does not aim for any change in behavior at all. This allows advertisers to make the duplicitous
claim that programmatic advertising works at increasing brand awareness, without measuring anything
or changing anybody's behavior.

Second, **ad blocking is on the rise.** Google admitted in 2014 that 56% of ads that were displayed
are never seen by a human. 800 million devices had ad blocking enabled in 2022. The demographic
trend is also discouraging for advertisers: Younger users and wealthier users use ad blockers at a
disproportionately high rate. In this section, Hwang reveals another stunning fact that makes total
sense once you read it: Snapchat's users skip commercial interruptions within less than a
second. **Less than a second.**[^4] Snapchat's users skew younger and are clearly **very** ad-averse.

Third, **click farms** inflate the value of advertisement in some domains. There are also the more
technical problems of domain spoofing, where unreliable and obscure ad networks sell an add on the
domain `NYTemis.com`, but brand it as one that is going to appear on `NYTimes.com`. Buyers and
publishers are not able to detect this behavior, and the technical solutions which prevent such
domain spoofing when visiting websites is still not available when buying ad space.

Fourth, **middlemen.** There are resellers and middlemen who add a markup for no value at all. The
marketing agencies which used to be premium places for creating ads have lost ground in that area,
but they are active in this market of procuring discounted ad space from the ad networks, adding a
mark up, and reselling the space to some buyer. These middlemen get a commission on the ad space
that is bought and are completely disconnected from any effect of whether the ad actually changes
consumer behavior. (Does this sound vaguely familiar? In the movie The Big Short (2015), about the
2008 financial crisis, these middlemen are the mortgage brokers in Florida who were selling condos
by giving subprime loans to anyone with a pulse, and pocketing the commissions on these loans.[^5]
The middlemen brag about the loans as "NINJA loans: No Income No Job" and talk about how the bonuses
on these loans started skyrocketing a few years ago. In fact, Steve Carrel's character asks them the
very question that Hwang complains that no one is asking in the programmatic advertising business:
"Do people have any idea what they are buying?")

The way that Hwang writes, the similarities between the financial markets and the advertising
market, and the time before the crisis in the financial market and now in the advertising market,
become quite clear. The whole book is obsessed with bringing these similarities out and showing
what is going on.


# What Next?

What is an advertisement supposed to do? Ignoring the amorphous category of "brand advertising," all
of advertising has the same goal: **Change the viewer's behavior in a predefined, intended way.** The
online attention economy is based on the confidence that ads on the Internet, bought through ad
networks and sold through real-time bidding, are more effective than old-school, "spray everybody"
advertising. A crisis of confidence will happen when buyers stop advertising through this method and
realize that it does not affect their bottom line adversely at all. Buyers and sellers have already
[started](https://www.nytimes.com/2017/03/29/business/chase-ads-youtube-fake-news-offensive-videos.html) [doing](https://www.bloombergmedia.com/press/shifting-to-an-audience-first-mentality/) this[^6] and they are not seeing their revenues drop.

The ways that we use the Internet are constrained to the mediums in which advertising can spread:
text with engagement signals like "Like" and "Favorite"; quantifiable popularity metrics like
follower and subscriber counts. A place that enables computers to connect to each other without
commodifying everything that people do in that place does not necessarily have to look like our
current Internet. **The way that the Internet is funded is important to the way that the Internet
is.** The algorithms put inflammatory posts that make people mad at the top of their feeds because
that is what sells advertisements and motivates people to take action. Hwang's optimism is touching
here: He says that the Internet had other routes; it could have relied on other sources of
revenue. I believe him. People could have run their own servers if the technology had been simple or
if the education ministries had kept up with the technology. Long-form blogs would have been the
order of the day, rather than "outrage of the hour" sentences. People would have found it harder to
target others because interaction was curated and disperse.

We should care about how the programmatic advertising market works because it is the main source of
funding for many free services today. This article links to a few YouTube videos and news articles,
which remain free because YouTube and publishers have ads on their website, which they believe is
making them enough money that they don't want to stop people from just sharing links around. If that
wasn't the case, how would you share video clips with everyone? Hosting is not free, and neither is
bandwidth. The collapse of this market would change the Internet completely. And possibly, for the
better.

I keep returning to Hwang's premise for this book. **What would happen if all the free services that
you use on the Internet, most of which are powered by advertisements, stop being free one day?**

[^1]: Google's financial results for January-March 2023 ([PDF, p.2](https://abc.xyz/assets/a7/5b/9e5ae0364b12b4c883f3cf748226/goog-exhibit-99-1-q1-2023-19.pdf)). Total revenue: $69,787 million. Revenue from Google advertising was $54,661 million.
[^2]: Facebook's financial results for January-March 2023 ([PDF, p.10](https://s21.q4cdn.com/399680738/files/doc_financials/2023/q1/Meta-03-31-2023-Exhibit-99-1-FINAL-v2.pdf)). Total revenue: $28,645 million. Revenue from advertising was $28,101 million.
[^3]: This was quite clear during the YouTube Adpocalypse scandal when YouTube was struggling to control ads that were being displayed next to content that was affecting "Brand safety," the concept of surfacing brand names next to agreeable content.
[^4]: I could not really believe this fact, so I dug up the article where this fact was sourced from: "Advertisers and media partners familiar with the company's thinking say serious consideration is being given to such a plan, which would help solve a nagging flaw in Snapchat's business: its young users often skip commercial interruptions within less than a second." ([Snapchat May Force Users to Watch Three Seconds of Ads Before Skipping - AdAge](https://archive.is/1A72A#selection-3203.0-3203.265))
[^5]: This is the [clip](https://youtu.be/MesrrYyuoa4) from The Big Short (2015).
[^6]: Hwang mentions the New York Times moving away from programmatic advertising, and other examples in the book, but I have not put references to those here. I found 2 interesting examples for ad buyers and sellers: **First, JP Morgan Chase,** the consumer banking devision of the large investment bank JP Morgan: "Of the 400,000 web addresses JPMorgan's ads showed up on in a recent 30-day period, said Ms. Lemkau, only 12,000, or 3 percent, led to activity beyond an impression. An intern then manually clicked on each of those addresses to ensure that the websites were ones the company wanted to advertise on. About 7,000 of them were not, winnowing the group to 5,000. The shift has been easier to execute than expected, Ms. Lemkau said, even as some in the industry warned the company that it risked missing out on audience 'reach' and efficiency." from [Chase Had Ads on 400,000 Sites. Then on Just 5,000. Same Results.](https://www.nytimes.com/2017/03/29/business/chase-ads-youtube-fake-news-offensive-videos.html) **Second, Bloomberg,** a major publisher of financial news, stopped open-market programmatic advertising. They moved to the time tested strategy of asking buyers to work directly with their media team to place ads. The stated reason for this was the performance of their website. Notably, Bloomberg shut down their ad sales despite seeing the revenues from this business grow for more than 2 consecutive years. "Starting January 1, 2023, Bloomberg Media will no longer allow third parties to sell ads to our audience through open-market third-party programmatic, or other non-direct sold "demand channels," across our website and apps. Going forward, if brands want to reach our audience, they'll need to work directly with our world class media team." &#x2013; [Shifting to an Audience-First Mentality - Bloomberg Media](https://www.bloombergmedia.com/press/shifting-to-an-audience-first-mentality/)
