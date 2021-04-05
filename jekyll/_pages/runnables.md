---
title: Runnables
layout: single
permalink: /runnables/
classes: wide
sidebar:
  nav: home

---

{% assign r = site.data.runnables %}
|Date|Time|Link & Message|
|----|----|--------------|
{% for product in r %}|{{ product.date }}|{{ product.time }}|<a href="../{{ product.link }}">{{ product.message }}</a>|
{% endfor %}
