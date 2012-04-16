### __Graphite__ widget

If you are using [Graphite](http://graphite.wikidot.com) for monitoring,
you might find this widget very interesting.

<img class="column1 right" src="/images/blog/graphite-graph.png" title="Example graph"/>

Don't get me wrong - I love to stare at colourful graphs, but what I
found was that I didn't always get the most important information I 
need - which is the current state of my platform.

That's why I've made Graphite widget. It calculates average value
and trend from last 5min (configurable), and puts a mini graph from 
last 30min. You can also configure a link to your graphite dashboard,
to make it easy to drill down selected graph. 

Big number, label, and tiny graph to check last 30min. what else do you
need?

<img class="columns2 center" src="/images/blog/widget-graphite-trend.png" title="Graphite based widget" style="margin-left: 86px;" />

Here's example widget configuration. It's that simple!
~~~~
{
}
~~~~