#!/bin/bash
cloud_sql_proxy -instances=eureka-beta:us-east1:eureka-beta-sql=tcp:3306

while read container port; do
  sudo systemctl stop docker
done <<< $(mysql -h 127.0.0.1 -P 3306 -u roboto --password=tHMu4ZXuMJHuT8hFccEZVmZ6 eureka_beta <<<'SELECT container_id from machines' | tail -n+2)

sudo systemctl stop docker
while read container port; do
  cd /var/lib/docker/containers/${container}*
  sudo sed -ri "s/\"HostPort\":\"[^\"]+?\"/\"HostPort\":\"$port\"/" hostconfig.json
done <<< $(mysql -h 127.0.0.1 -P 3306 -u roboto --password=tHMu4ZXuMJHuT8hFccEZVmZ6 eureka_beta <<<'SELECT container_id,ssh_port from machines' | tail -n+2)

sudo systemctl start docker

while read container port; do
  sudo docker start $container
done <<< $(mysql -h 127.0.0.1 -P 3306 -u roboto --password=tHMu4ZXuMJHuT8hFccEZVmZ6 eureka_beta <<<'SELECT container_id,ssh_port from machines' | tail -n+2)
