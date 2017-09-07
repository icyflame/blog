---
layout: page
title: Blog Posts by Tag
permalink: /tag/

sitemap:
  priority: .5

---

Click on a tag to see relevant list of posts.

{% assign num_cat = site.categories.size %}
{% assign col_limit = num_cat | divided_by: 3 %}
{% assign offset = 0 %}
<p>{{num_cat}} tags found</p>
<p>{{col_limit}} tags per column</p>
<div class="container">
  <div class="col-md-4">
    <ul>
    {% for tag in site.categories limit:col_limit offset:offset %}
      {% assign t = tag | first %}
      {% assign posts = tag | last %}
      <li><a href="/tag/#{{t | downcase | replace:" ","-" }}">{{ t | downcase }} ({{ posts | size }})</a></li>
    {% endfor %}
    </ul>
  </div>

  {% assign offset = offset | plus: col_limit %}

  <div class="col-md-4">
    <ul>
    {% for tag in site.categories limit:col_limit offset:offset %}
      {% assign t = tag | first %}
      {% assign posts = tag | last %}
      <li><a href="/tag/#{{t | downcase | replace:" ","-" }}">{{ t | downcase }} ({{ posts | size }})</a></li>
    {% endfor %}
    </ul>
  </div>

  {% assign offset = offset | plus: col_limit %}

  <div class="col-md-4">
    <ul>
    {% for tag in site.categories offset:offset %}
      {% assign t = tag | first %}
      {% assign posts = tag | last %}
      <li><a href="/tag/#{{t | downcase | replace:" ","-" }}">{{ t | downcase }} ({{ posts | size }})</a></li>
    {% endfor %}
    </ul>
  </div>
</div>

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
