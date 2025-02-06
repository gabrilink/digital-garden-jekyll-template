---
layout: page
title: Home
id: home
permalink: /
---

<strong>Latest</strong>

{% assign latest_note = site.notes | sort: "last_modified_at_timestamp" | reverse | first %}

{% if latest_note %}

  <div class="latest-note">
    <h3><a class="internal-link" href="{{ site.baseurl }}{{ latest_note.url }}">{{ latest_note.title }}</a></h3>
    <p>{{ latest_note.content | strip_html | truncatewords: 50 }}</p>
    <a href="{{ site.baseurl }}{{ latest_note.url }}" class="read-more">Read more →</a>
  </div>
{% endif %}

<!--
<p style="padding: 3em 1em; background: #f5f7ff; border-radius: 4px;">
  Take a look at <span style="font-weight: bold">[[Your first note]]</span> to get started on your exploration.
</p>
-->

<strong>Recently updated notes</strong>

<ul>
  {% assign recent_notes = site.notes | sort: "last_modified_at_timestamp" | reverse %}
  {% for note in recent_notes limit: 5 %}
    <li>
      {{ note.last_modified_at | date: "%Y-%m-%d" }} — <a class="internal-link" href="{{ site.baseurl }}{{ note.url }}">{{ note.title }}</a>
    </li>
  {% endfor %}
</ul>

<style>
  .wrapper {
    max-width: 46em;
    margin: 0 auto; /* Centers the content horizontally */
    padding: 0 1em; /* Adds some padding to prevent content from touching the edges */
  }
  .latest-note {
    background: #f5f7ff;
    padding: 1em;
    border-radius: 4px;
    margin-top: 1em;
  }
  .latest-note h2 {
    margin: 0 0 0.5em;
  }
  .read-more {
    display: inline-block;
    margin-top: 0.5em;
    color: #007bff;
    text-decoration: none;
  }
</style>
