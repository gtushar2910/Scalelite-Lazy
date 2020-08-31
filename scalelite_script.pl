#!/bin/bash
sleep 1m
sudo su - root
add-apt-repository universe
add-apt-repository multiverse
apt-get update
git clone git@github.com:whatever folder-name
git clone https://github.com/aakatev/scalelite-run.git /scalelite-run
chmod 0744 /scalelite-run/init-letsencrypt.sh
touch /scalelite-run/.env
echo "SECRET_KEY_BASE=${secret_key_base}" >> /scalelite-run/.env
echo "LOADBALANCER_SECRET=${scalelite_secret}" >> /scalelite-run/.env
echo "URL_HOST=${scalelite_url}" >> /scalelite-run/.env
echo "NGINX_SSL=${nginx_ssl}" >> /scalelite-run/.env
cd /scalelite-Run
sh init-letsencrypt.sh