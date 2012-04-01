### __Trello__ and __Xen__ Server

This is how I use [trello](http://trello.com) board to keep a list of
my VMs up to date :) It's of course all automated and definitely not
a production environment solution ;)

It's main and only purpose is to allow anyone with access to Internet
(and added to my trello board) to check which machine is running.
It also provides basic information about memory usage, IP address,
up time, ...

![Xen Server Board](/images/blog/trello-board.png "Xen Server Board")

It's all very simple. Xen cli provides list of your VMs. Perl script 
parses it. At the end few simple curl calls to trello API, and you
have your own VM trello board.

The same script is of course updating my other dashboard powered by 
HoborgLabs [Simple Dashboard](http://dashboard.hoborglabs.com).

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
/30 * * * * /var/srv/status/trello-vms-status.pl /var/srv/status/trello-vms-status.ini
~~~~