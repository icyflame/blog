---
layout: page
title: List of Posts
weight: 10
---

<style>

#list a{

  text-decoration: none !important;
  color: #777 !important;
}

#list a:hover{

  color: black !important;
  text-decoration: none !important;
}

</style>

<div id="list">

  <table style="border: 0; ">

    {% for post in site.posts %}

    <tr>

      <td>

        <a href="{{ site.baseurl_without_slash }}{{post.url}}">
          {{ post.title }}
        </a>

      </td>

      <td>

        <span style="float: right; ">
          {{ post.date | date_to_string }}

        </span>

      </td>

    </tr>

    {% endfor %}

  </table>

</div>
