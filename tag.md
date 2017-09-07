---
layout: page
title: Blog Posts by Tag
permalink: /tag/

sitemap:
  priority: .5

---

Click on a tag to see relevant list of posts.

<ul class="tags">
{% for tag in site.categories %}
  {% assign t = tag | first %}
  <li><a href="/tag/#{{t | downcase | replace:" ","-" }}">{{ t | downcase }}</a></li>
{% endfor %}
</ul>

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
