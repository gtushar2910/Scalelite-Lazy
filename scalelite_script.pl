#!/bin/bash
sleep 1m
sudo su - root
add-apt-repository universe
add-apt-repository multiverse
apt-get update
git clone https://github.com/aakatev/scalelite-run.git /scalelite-run
chmod 0744 /scalelite-run/init-letsencrypt.sh
touch /scalelite-run/.env
echo "SECRET_KEY_BASE=${secret_key_base}" >> /scalelite-run/.env
echo "LOADBALANCER_SECRET=${scalelite_secret}" >> /scalelite-run/.env
echo "URL_HOST=${scalelite_url}" >> /scalelite-run/.env
echo "NGINX_SSL=${nginx_ssl}" >> /scalelite-run/.env
apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt update
apt install -y docker-ce
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
cd /scalelite-run
./init-letsencrypt.sh
docker-compose up -d
sleep 15m
docker exec -i scalelite-api bundle exec rake db:setup
export url=`https://${bbb_subdomain_name}-0.${bbb_domain_name}/bigbluebutton/api/`
docker exec -i scalelite-api bundle exec rake servers:add[$url,${shared_secret}] > test.txt
export id = `grep "id" test.txt | cut -d " " -f 2`
docker exec -i scalelite-api bundle exec rake servers:enable[$id]
export url=`https://${bbb_subdomain_name}-1.${bbb_domain_name}/bigbluebutton/api/`
docker exec -i scalelite-api bundle exec rake servers:add[$url,${shared_secret}] > test.txt
export id = `grep "id" test.txt | cut -d " " -f 2`
docker exec -i scalelite-api bundle exec rake servers:enable[$id]
export url=`https://${bbb_subdomain_name}-2.${bbb_domain_name}/bigbluebutton/api/`
docker exec -i scalelite-api bundle exec rake servers:add[$url,${shared_secret}] > test.txt
export id = `grep "id" test.txt | cut -d " " -f 2`
docker exec -i scalelite-api bundle exec rake servers:enable[$id]

