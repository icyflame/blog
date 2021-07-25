---
layout: page
title: List of Series
permalink: /series

weight: 500

sitemap:
  priority: .6

series:
  unscientific-comparison-news-1:
    name: "An Unscientific Comparison of News Websites"
    description: |
      A comparison of the above-the-fold content on the home page of a dozen news websites from
      around the world. The comparison is based on objective metrics such as number of articles
      shown and subjective metrics such as scores for ease-of-use and the number of distracting
      elements on the websites.
  orientation-program-at-iit-kgp:
    name: "Orientation Program at IIT Kharagpur"
    description: |
      Hazing at IIT Kharagpur is referred to by the euphemism Orientation Program, or simply, O.P. I
      recount my experience of O.P. during my time at Nehru Hall in IIT Kharagpur between 2013-2018.
  media-and-expectations:
    name: "Media and Expectations"
    description: |
      After a couple years of vicious complaining about the Indian media, nightly shouting matches
      and the absurd topics that were chosen for each debate, I read Rosling's Factfulness. Rosling
      points out that the news is "not very useful for understanding the world." This series is
      about how the media will serve the interests of the advertiser and why news channels on
      YouTube will probably be better at delivering news. (This series is from 2018. Looking back in
      2021, I realize that I trusted in data too much and believed that getting the _right_
      statistic would help me understand and explain the world to others.)
  configuring-emacs:
    name: "Configuring Emacs: 7 months later"
    description: |
      In mid-2020, after nearly 6 years of being a religious Vim user, I switched to Emacs. This
      series is my story after using it for 7 months. I tell my story in 3 acts, beginning with
      the fundamentals such as package management and powerful packages **not** to install right
      at the beginning. The second act looks at configuring keybindings and moving around a bit
      more effortlessly. The final act walks the user through a couple of Elisp functions I wrote
      to solve some issues which are extremely simple in a Regular expression editor such as Vim
      but are non-trivial inside Emacs.

  india-central-bank-interventions:
    name: "Indian Central Bank's Monetary Interventions"
    description: |
      For some inexplicable reason, around the beginning of this year, I was on the RBI website and
      reading the minutes of the Monetary Policy Committee's latest meeting. The minutes were very
      interesting and seemed to be drawing on data that was not public. It talked about "high-frequency
      data" and "foreign exchange reserves." I had very little understanding of these things and so, I
      went down a rabbithole trying to understand the function of Central Banks, the tools that are at
      their disposal and how they deploy them at the right time.
---

{% assign posts_in_series = site.posts | where_exp: "p", "p.series_id != nil" %}
{% assign posts_with_series = posts_in_series | group_by: "series_id" %}

<p>

{{ posts_with_series | size }} multi-part series, {{ posts_in_series | size}} posts

</p>

{% for series in posts_with_series %}

{% assign series_detail = page.series[series.name] %}

### {{ series_detail.name }}

{% assign latest_post = series.items | first %}
{% assign earliest_post = series.items | last %}
<i>
<span class="date">{{ earliest_post.date | date: "%B %-d, %Y"  }}</span>
to
<span class="date">{{ latest_post.date | date: "%B %-d, %Y"  }}</span>
</i>

{{ series_detail.description }}

{% assign series_posts = series.items | reverse %}

<ul>
{% for post in series_posts %}
<li>
<a href="{{ post.url }}">{{ post.title }}</a>
</li>
{% endfor %}
</ul>

{% endfor %}
