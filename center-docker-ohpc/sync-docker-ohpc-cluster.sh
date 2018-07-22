#!/bin/bash

# Dockerized OpenHPC Cluster launcher
# n.Lucas.Kim (2017-12-21)


docker cp ohpc-sms:/etc/munge/munge.key .
docker cp ohpc-sms:/etc/slurm/slurm.conf .

for i in {1..6}
do
docker cp munge.key c$i:/etc/munge/munge.key
docker cp slurm.conf c$i:/etc/slurm/slurm.conf

docker exec c$i chown munge:munge /etc/munge/munge.key

docker exec c$i systemctl restart munge
docker exec c$i systemctl restart slurmd

docker exec c$i ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

done

