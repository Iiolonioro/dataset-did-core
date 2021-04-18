---
title: Terms
layout: single
author_profile: false
permalink: /terms
sidebar:
  nav: terms
---


{% assign mappingcounts=site.data.mappingcounts %}
{% for pair in mappingcounts %}
{{ pair[0] }}
{% endfor %}
{% assign sectiontitles=site.data.sectiontitles %}
<dl>
{% for pair in sectiontitles %}
  <dt>{{ pair[0] }}</dt>
  <dd>{% for map in pair[1]['mappings']%}
        {{ map[0] | jsonify }}
        {% for hashentry in map[1]%}
          {{ hashentry['txt'] }}
        {% endfor %}
      {% endfor %}
  </dd>
{% endfor %}
</dl>
