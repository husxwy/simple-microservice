#FROM alpine:3.8
#
#LABEL maintainer="761396462@qq.com"
#
#ENV SKYWALKING_VERSION=8.8.1
#
#ADD http://mirrors.tuna.tsinghua.edu.cn/apache/skywalking/${SKYWALKING_VERSION}/apache-skywalking-apm-${SKYWALKING_VERSION}.tar.gz /
#
#RUN tar -zxvf /apache-skywalking-apm-${SKYWALKING_VERSION}.tar.gz && \
#    mv apache-skywalking-apm-bin skywalking && \
#    mv /skywalking/agent/optional-plugins/apm-trace-ignore-plugin* /skywalking/agent/plugins/ && \
#    echo -e "\n# Ignore Path" >> /skywalking/agent/config/agent.config && \
#    echo "# see https://github.com/apache/skywalking/blob/v8.8.1/docs/en/setup/service-agent/java-agent/agent-optional-plugins/trace-ignore-plugin.md" >> /skywalking/agent/config/agent.config && \
#    echo 'trace.ignore_path=${SW_IGNORE_PATH:/health}' >> /skywalking/agent/config/agent.config
#FROM busybox:1.34.1-musl
#ENV LANG=C.UTF-8
#ENV workdir=/usr/skywalking/agent
##ENV workdir=/usr/skywalking/agent \
##    jar_name=gateway-service.jar \
##    gid=2000 \
##    uid=2000 \
##    user=aspire \
##    group=aspire
##RUN  set -x \
##     && addgroup -g ${gid} ${group} \
##     && adduser -u  ${uid} -g ${group} -s /bin/sh ${user}  \
##     && set -x \
##     && mkdir -p $workdir \
##     && chown -R $user:$group $workdir
##USER $user
##COPY --chown=$user:$group ./target/$jar_name $workdir/
#ADD agent $workdir
##WORKDIR
FROM debian:buster-slim
ENV LANG=C.UTF-8
ENV workdir=/usr/skywalking/agent
ENV workdir=/usr/skywalking/agent \
    jar_name=gateway-service.jar \
    gid=1000 \
    uid=1000 \
    user=aspire \
    group=aspire
RUN  set -x \
     && groupadd -g ${gid} ${group} \
     && useradd -u ${uid} -g ${group} -s /bin/sh ${user} \
     && set -x \
     && mkdir -p $workdir \
     && chown -R $user:$group $workdir
USER $user
#COPY --chown=$user:$group ./target/$jar_name $workdir/
ADD --chown=$user:$group agent $workdir
#WORKDIR
