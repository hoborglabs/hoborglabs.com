### Power your dashboard with __Graphite__.

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
need? [Download](http://get.hoborglabs.com/dashboard/dashboard.phar)
and [install](https://gist.github.com/1512137) dashboard today :)

<img class="columns2 center" src="/images/blog/widget-graphite-trend.png" title="Graphite based widget" style="margin-left: 86px;" />

Here's example widget configuration. It's that simple!
~~~~
{
  name: "My Platform",
  foter: "based on Graphite",
  php: "graphite/trend/widget.php",
  conf: {
    url: "graphs.my-platform.com",
    targets: [
      {
        label: "my-website.com",
        target: "traffic.my-website.count",
      },
      {
        ...
      }
    ]
  }
}
~~~~

And here's a full config, using all features.
~~~~
{
  name: "My Platform",
  foter: "based on Graphite",
  php: "graphite/trend/widget.php",
  conf: {
    url: "graphs.my-platform.com",
    targets: [
      {
        label: "my-website.com",
        target: "traffic.my-website.count",
        factor: 10,
        unit: "req/sec",
        from: "-5min",
        colors: {
          cold: {
            color: "FFFFFF",
            value: 30
          },
          hot: {
            color: "FF0000",
            value: "300"
          }
        }
        img: {
          link: "graphs.my-platform.com/trafic-dashboard"
          from: "-30min",
          width: 150,
          height: 50
        }
      }
    ]
  }
}
~~~~