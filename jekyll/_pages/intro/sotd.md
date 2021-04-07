---
layout: single
author_profile: false
permalink: /sotd
sidebar:
  nav: timeline
---

Timeline - here is an example.  Try the menu on the left.


<div id="timeline"></div>

<script>
  milestones('#timeline')
    .mapping({
      'timestamp': 'year',
      'text': 'title'
    })
    .parseTime('%Y')
    .aggregateBy('year')
    .render([
      { year: 789, title: 'Vikings begin attacks on England.' },
      { year: 840, title: 'Vikings found Dublin in Ireland.' },
      { year: 1050, title: 'The city of Oslo is founded in Norway.' },
      { year: 1066, title: 'Battle of Hastings.' }
    ]);
</script>
