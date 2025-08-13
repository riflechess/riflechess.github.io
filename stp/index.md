---
layout: default
title: Saint Paul Meeting Summaries
---

<h1>Saint Paul Meeting Summaries</h1>
<p>Browse recent meetings below.</p>

<ul>
  {% assign items = site.pages | where_exp: "p", "p.path contains 'summaries/'" | sort: "path" | reverse %}
  {% for p in items %}
    <li><a href="{{ p.url | relative_url }}">{{ p.path | split: '/' | last | replace: '_', ' ' | replace: '.md', '' }}</a></li>
  {% endfor %}
</ul>

