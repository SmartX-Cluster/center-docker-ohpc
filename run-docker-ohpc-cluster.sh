#!/bin/bash

# Dockerized OpenHPC Cluster launcher
# n.Lucas.Kim (2017-12-21)

for i in {1..6}
do
docker run --privileged -d --name c$i -h c$i -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /home:/home --volumes-from ohpc-sms --net sx-docker --ip 172.22.84.1$i ohpc-com
done

