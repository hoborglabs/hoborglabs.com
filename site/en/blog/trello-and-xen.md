### __Trello__ and __Xen__ Server

This is how I use [trello](http://trello.com) board to keep a list of
my VMs up to date :) It's of course all automated and definitely not
a production environment solution ;)

![Xen Server Board](/images/blog/trello-board.png "Xen Server Board")

It's main and only purpose is to allow anyone with access to Internet
(and added to my trello board) to check which machine is running.
It also provides basic information about memory usage, IP address,
up time, ...

<img class="column1 left" src="/images/blog/server-widget.png" title="Xen Server Board"/>

It's all very simple. Citrix provides you with Python lib for Xen API. 
You just have to run few simple curl calls to trello API, and you
have your own VM trello board.

The same script is of course updating [my other dashboard](http://hoborglabs.com/dashboard)
powered by HoborgLabs [Simple Dashboard](http://dashboard.hoborglabs.com). 
Because it's public accessible, it only gives high level info about 
server status. This widget is now available on github.

I've tried to keep it simple and possibly reusable by anyone. All you
need to do is to get few IDs from trello, few uuid from Xen and put it
into config file.

~~~~
trello.key = my-key
trello.token = my-token
trello.board.id = abc123

vm.mapping.my-vm1-uuid = trello-card1-id
vm.mapping.my-vm2-uuid = trello-card2-id

vm.status.halted = my-halted-list-id
vm.status.running = my-running-list-id
~~~~

and that's it. Just add a cron job, and you are done.

~~~~
/30 * * * * /var/srv/status/status-monitor-trello /var/srv/status/status-monitor-trello.ini
~~~~