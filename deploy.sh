#!/bin/bash
echo "Stop container"
docker stop leopard
docker rm leopard
docker image rm sureiger/myserver
echo "Pull image"
docker pull sureiger/myserver
echo "Start leopard container"
docker run --name leopard -d -p 80:80 -p 443:443 sureiger/myserver
echo "Finish deploying!"
