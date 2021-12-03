#wget http://mirrors.tuna.tsinghua.edu.cn/apache/skywalking/8.8.1/apache-skywalking-apm-8.8.1.tar.gz
# http://archive.apache.org/dist/skywalking/8.1.0/apache-skywalking-apm-es7-8.1.0.tar.gz
service=skywalking-agent
#  使用 skywalking apm 版本号
SKYWALKING_VERSION=8.3.0-2
docker_registry=harbor.husx.top
image_name=$docker_registry/microservice/${service}:${SKYWALKING_VERSION}

docker build -t ${image_name} .
docker push ${image_name}
docker rmi ${image_name}
