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
      recount my experience of O.P. at IIT Kharagpur during 2013-2018.
---

{% assign posts_in_series = site.posts | where_exp: "p", "p.series_id != nil" %}
{% assign posts_with_series = posts_in_series | group_by: "series_id" %}

<p>

{{ posts_with_series | size }} multi-part series, {{ posts_in_series | size}} posts

</p>

{% for series in posts_with_series %}

{% assign series_detail = page.series[series.name] %}

### {{ series_detail.name }}

{% assign first_post = series.items | first %}
{% assign last_post = series.items | last %}
<i><span class="date">{{ first_post.date | date: "%B %-d, %Y"  }}</span>
to
<span class="date">{{ last_post.date | date: "%B %-d, %Y"  }}</span></i>


{{ series_detail.description }}

{% assign series_posts = series.items | reverse %}

<ul>
{% for post in series_posts %}
<li>
<a href="{{ post.url }}">{{ post.title }}</a>
<span class="date">{{ post.date | date: "%B %-d, %Y"  }}</span>
</li>
{% endfor %}
</ul>

{% endfor %}
