>## 这是一个基于SpringCloud的微服务架构项目

>## 部署须知
1. 导入db目录下数据库文件到自己的MySQL服务器
2. 修改配置环境（xxx-service/src/main/resources/application.yml，active值决定启用环境配置文件）
3. 修改连接数据库配置（xxx-service/src/main/resources/application-fat.yml）
4. 修改前端页面连接网关地址（portal-service/src/main/resources/static/js/productList.js和orderList.js）
5. 服务启动顺序：eureka -> mysql -> product,stock,order -> gateway -> portal

https://github.com/husxwy/simple-microservice

代码分支说明：
dev1 交付代码
dev2 编写Dockerfile构建镜像
dev3 K8S资源编排
dev4 微服务链路监控
master 最终上线


http://eureka.ctnrs.com
http://gateway.ctnrs.com
http://portal.ctnrs.com

skywalking

https://github.com/apache/skywalking-kubernetes

添加 helm 仓库
export REPO=skywalking
helm repo add ${REPO} https://apache.jfrog.io/artifactory/skywalking-helm                                 


helm search repo skywalking

export REPO=skywalking
export SKYWALKING_RELEASE_NAME=skywalking
export SKYWALKING_RELEASE_NAMESPACE=skywalking

Error: must either provide a name or specify --generate-name
https://georgik.rocks/helm-3-x-fails-with-error-must-either-provide-a-name-or-specify-generate-name/
只需删除-n

kubectl create ns skywalking

export REPO=skywalking
export SKYWALKING_RELEASE_NAME=skywalking
export SKYWALKING_RELEASE_NAMESPACE=skywalking
helm install "${SKYWALKING_RELEASE_NAME}" ${REPO}/skywalking -n "${SKYWALKING_RELEASE_NAMESPACE}" --set oap.image.tag=8.8.1 --set oap.storageType=elasticsearch --set ui.image.tag=8.8.1 --set elasticsearch.imageTag=7.5.1

export REPO=skywalking
export SKYWALKING_RELEASE_NAME=skywalking
export SKYWALKING_RELEASE_NAMESPACE=skywalking
helm install "${SKYWALKING_RELEASE_NAME}" ${REPO}/skywalking -n "${SKYWALKING_RELEASE_NAMESPACE}" \
--set oap.image.tag=8.3.0-es7 \
--set oap.storageType=elasticsearch7 \
--set ui.image.tag=8.3.0 \
--set elasticsearch.imageTag=7.5.1

helm install "${SKYWALKING_RELEASE_NAME}" skywalking -n "${SKYWALKING_RELEASE_NAMESPACE}" \
--set oap.image.tag=8.1.0-es7 \
--set oap.storageType=elasticsearch7 \
--set ui.image.tag=8.1.0 \
--set elasticsearch.imageTag=7.5.1

helm uninstall skywalking -n skywalking
Error: could not get apiVersions from Kubernetes: unable to retrieve the complete list of server APIs: metrics.k8s.io/v1beta1: the server is currently unable to handle the request


NAME: skywalking
LAST DEPLOYED: Thu Dec  2 18:19:03 2021
NAMESPACE: skywalking
STATUS: deployed
REVISION: 1
NOTES:
************************************************************************
*                                                                      *
*                 SkyWalking Helm Chart by SkyWalking Team             *
*                                                                      *
************************************************************************

Thank you for installing skywalking.

Your release is named skywalking.

Learn more, please visit https://skywalking.apache.org/

Get the UI URL by running these commands:
echo "Visit http://127.0.0.1:8080 to use your application"
kubectl port-forward svc/skywalking-ui 8080:80 --namespace skywalking
#################################################################################
######   WARNING: Persistence is disabled!!! You will lose your data when   #####
######            the SkyWalking's storage ES pod is terminated.            #####
#################################################################################
