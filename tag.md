---
layout: page
title: List of Posts by Tag
permalink: /tag/

weight: 100

sitemap:
  priority: .5

---

<p>
{{site.posts | size}} posts, {{site.categories | size}} tags
</p>

_Click on a tag to see relevant list of posts_

<table>
{% assign sorted_categories = site.categories | sort %}
{% tablerow tag in sorted_categories cols: 3 %}
  {% assign t = tag | first %}
  {% assign posts = tag | last %}
  <a href="/tag/#{{t | downcase | replace:" ","-" }}">
    {{ t | downcase }} ({{ posts | size }})
  </a>
{% endtablerow %}
</table>

---

{% for tag in site.categories %}
  {% assign t = tag | first %}
  {% assign posts = tag | last %}

<h4><a name="{{t | downcase | replace:" ","-" }}"></a><a class="internal" href="/tag/#{{t | downcase | replace:" ","-" }}">{{ t | downcase }}</a></h4>
<ul>
{% for post in posts %}
  {% if post.categories contains t %}
  <li>
    <a href="{{ post.url }}">{{ post.title }}</a>
    <span class="date">{{ post.date | date: "%B %-d, %Y"  }}</span>
  </li>
  {% endif %}
{% endfor %}
</ul>

---

{% endfor %}
