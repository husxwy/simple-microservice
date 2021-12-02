#!/bin/bash
set -x

#docker_registry=10.8.14.63
docker_registry=harbor.husx.top

#harbor.husx.top 10.8.14.63
kubectl create ns ms
# 存储登录Harbor认证信息
kubectl create secret docker-registry registry-pull-secret --docker-server=$docker_registry --docker-username=admin --docker-password=Harbor123 --docker-email=admin@ctnrs.com -n ms

service_list="eureka-service gateway-service order-service product-service stock-service portal-service"
#service_list="eureka-service"
#service_list="order-service product-service stock-service"
#service_list=" stock-service"

service_list=${1:-${service_list}}
work_dir=$(dirname $PWD)
current_dir=$PWD
version=$(date +%Y%m%d%H%M%S)
version=dev-1.0.3

cd $work_dir
#mvn clean package -Dmaven.test.skip=true -P prod
mvn clean package -Dmaven.test.skip=true

touch $current_dir/images_list.txt
cat /dev/null > $current_dir/images_list.txt
for service in $service_list; do
  echo $service  "========================="
   cd $work_dir/$service
   # 业务程序需进入biz目录里构建
   if ls |grep biz &>/dev/null; then
      cd ${service}-biz
   fi

#   service=${service%-*}
   echo $service  "========================="
   image_name=$docker_registry/microservice/${service}:${version}
   echo $image_name  "========================="
#   # 添加 文件列表，删除本地镜像使用


   echo ${image_name} >> $current_dir/images_list.txt
   docker build -t ${image_name} .
   docker push ${image_name}
   docker rmi ${image_name}
   # 修改yaml中镜像地址为新推送的，并apply
#   sed -i -r "s#(image: )(.*)#\1$image_name#" ${current_dir}/${service}.yaml
    sed -i "" "s#\(image:\)\(.*\)#\1 $image_name#" ${current_dir}/${service}.yaml

#   sed -i -r 's#(image: )(.*)#image: 10.8.14.63/microservice/portal-service:2021-12-01100309#' /Users/husx/02work/study/code/simple-microservice/k8s/portal-service.yaml
#   sed -l  "s#\(image: \)\(.*\)#\110.8.14.63/microservice/portal-service:2021-12-01100309#" /Users/husx/02work/study/code/simple-microservice/k8s/portal-service.yaml
#   sed -l  "s#\(image: \)\(.*\)#\110.8.14.63/microservice/portal-service:2021-12-01100309#" /Users/husx/02work/study/code/simple-microservice/k8s/portal-service.yaml
#   sed -i "" "s#\(image: \)\(.*\)#\110.8.14.63/microservice/portal-service:2021-12-01100309#" /Users/husx/02work/study/code/simple-microservice/k8s/portal-service.yaml

   kubectl apply -f ${current_dir}/${service}.yaml
done
