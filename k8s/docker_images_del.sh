docker rmi --force  `docker images |grep harbor |awk '{print $3 }'|xargs `

docker rmi --force  `docker images |grep harbor.husx.top |awk '{print $3 }'|xargs `
docker rmi --force  `docker images |grep 10.8.14.63 |awk '{print $3 }'|xargs `

docker rmi --force  `docker images |grep kf.hub.i139.cn |awk '{print $3 }'|xargs `
