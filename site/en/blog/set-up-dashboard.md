### This is how to __add dashboard__ to your website.

This blog describes how I added dashboard to hoborglabs.com website. 
You can check it out [here](/dashboard). The 
initial version will display Jenkins jobs statuses.

#### download and Install

First I need a folder for 3rd party vendors, configs and widget's data files - easy!!
~~~~
cd hoborglabs.com
mkdir data
mkdir conf
mkdir htdocs/dashboard
mkdir -p vendors/dashboard
cd vendors/dashboard
~~~~

Now I can download dashboard
~~~~
wget http://dashboard.hoborglabs.com/downloads/dashboard.phar
wget http://dashboard.hoborglabs.com/downloads/dashboard-assets.tgz
~~~~

Now ... dashboard.phar does not serves assets. But the default assets set comes
in nice tgz. I will unzip it in vendors folder and symlink it from my public 
folder.
~~~~
mkdir assets
tar -xzf dashboard-assets.tgz -C assets/
cd ../../htdocs/
ln -s ../vendors/dashboard/assets/ dashboard-assets
~~~~

Now let's make our dashboard page. (We are still in htdocs/ folder)
~~~~
vim dashboard/index.php
~~~~

And this is what you put inside
~~~~
&lt;?php
define('HD_PUBLIC', '/dashboard-assets');
define('CONFIG_DIR', __DIR__ . '/../../conf/');
include_once __DIR__ . '/../../vendors/dashboard/dashboard.phar';

$kernel = new \Hoborg\Dashboard\Kernel('prod');

$kernel->setPath('data', array(__DIR__ . '/../../data'));
$kernel->setDefaultParam('conf', 'hoborglabs-dashboard');

// and go, go, go...
$kernel->handle($_GET);
~~~~


#### Dashboard __Configuration__.

Now we have to prepare configuration file for our dashboard.

~~~~
cd ../
vim conf/hoborglabs-dashboard.json
~~~~

and put this into your config file.
~~~~
{
  "template" : "hoborg",
  "public" : "/dashboard-assets",
  "widgets" : [
    {
      "name": "Jenkins Job Status",
      "footer": "hoborg/jenkins/widget.php",
      "size": "span8 autoHeight",
      "body" : "Loading Content...",
      "php": "hoborg/jenkins/widget.php",
      "conf" : {
        "data" : "jobs.json"
      }
    }
  ]
}
~~~~

We also need empty list of json jobs for our widget.
~~~~
echo "{}" > data/jobs.json
~~~~


#### Preparing data and __Cron Jobs__.

Now we just need to set up a cron job which will be updating Jenkins job statuses.

~~~~
vim bin/dashboard-cli.php
~~~~

and that's what you need to put in that file
~~~~
&lt;?php
include_once __DIR__ . '/../vendors/dashboard/dashboard.phar';
$kernel = new \Hoborg\Dashboard\Kernel('prod');

$option = getopt('c:p:d:');
$kernel->handleCli($option);
~~~~

Now, let's get the data from Hoborg Labs jenkins view.
~~~~
php bin/dashboard-cli.php -c widget.hoborg.jenkins.collector -d "url=http://leeds.oledzki.info:5080/jenkins/view/Hoborg%20Labs/" -d out=`pwd`/data/jobs.json
~~~~

Now let's add it to crontab. Schedule the job wisely - if you project builds in
10min schedule it for every 10min, if you don't commit that often, just 
schedule it for every houer.
~~~~
crontab -e
*/30 * * * * php bin/dashboard-cli.php -c widget.hoborg.jenkins.collector -d "url=http://leeds.oledzki.info:5080/jenkins/view/Hoborg%20Labs/" -d out=`pwd`/data/jobs.json
~~~~