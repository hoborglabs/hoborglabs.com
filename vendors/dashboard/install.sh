rm -f dashboard.phar && curl -C - -O http://get.hoborglabs.com/dashboard/dashboard.phar
rm -f dashboard-assets.tgz && curl -C - -O http://get.hoborglabs.com/dashboard/dashboard-assets.tgz
mkdir assets
tar -xvf dashboard-assets.tgz -C assets/