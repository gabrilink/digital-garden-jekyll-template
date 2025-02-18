---
layout: page
title: Home
id: home
permalink: /
---

<strong>Latest</strong>

{% assign latest_note = site.notes | sort: "last_modified_at_timestamp" | reverse | first %}

{% if latest_note %}

  <h4><a class="internal-link" href="{{ site.baseurl }}{{ latest_note.url }}">{{ latest_note.title }}</a></h4>
  {% assign word_count = latest_note.content | number_of_words %}
  {% assign reading_time = word_count | divided_by: 200 | ceil %}
  <p>{{ latest_note.last_modified_at | date: "%B %d, %Y" }} · {{ reading_time }} min read</p>
  <p>{{ latest_note.content | strip_html | truncatewords: 50 }}</p>
  <!--<a href="{{ site.baseurl }}{{ latest_note.url }}" class="read-more">Keep reading →</a>-->
{% endif %}

<!--
<p style="padding: 3em 1em; background: #f5f7ff; border-radius: 4px;">
  Take a look at <span style="font-weight: bold">[[Your first note]]</span> to get started on your exploration.
</p>
-->

<strong>Topics</strong>

<p>
  {% assign tag_list = "" | split: "," %}

{% for note in site.notes %}
{% for tag in note.tags %}
{% unless tag_list contains tag %}
{% assign tag_list = tag_list | push: tag %}
{% endunless %}
{% endfor %}
{% endfor %}

{% for tag in tag_list %}
<a href="/tags/{{ tag }}/">{{ tag }}</a>{% unless forloop.last %}, {% endunless %}
{% endfor %}

</p>

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
  background: none;
  padding: 0;
  border-radius: 0;
  margin-top: 0;
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
