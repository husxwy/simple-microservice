FROM openjdk:8u292-jre-slim
LABEL maintainer www.ctnrs.com
ENV workdir=/apps \
    gid=1000 \
    uid=1000 \
    user=aspire \
    group=aspire \
    APP_OPTS="$APP_OPTS "\
    JAVA_OPTS="$JAVA_OPTS " \
    JVM_OPTS="$JVM_OPTS -Xss256k -Duser.timezone=Asia/Shanghai -Djava.security.egd=file:/dev/./urandom -Dfile.encoding=UTF8 "
RUN mkdir -p $workdir

RUN  set -x \
     && groupadd -g ${gid} ${group} \
     && useradd -u ${uid} -g ${group} -s /bin/sh ${user}
#     && addgroup -g 1000 -S aspire \
#     && adduser  -u 1000  -G aspire -g aspire aspire
USER $group
COPY ./target/stock-service-biz.jar $workdir/
RUN chown -R ${user}:${group} $workdir
#COPY pinpoint /pinpoint
EXPOSE 8030
#CMD java -jar -javaagent:/pinpoint/pinpoint-bootstrap-1.8.3.jar -Dpinpoint.agentId=$(echo $HOSTNAME | awk -F- '{print "stock-"$NF}') -Dpinpoint.applicationName=ms-stock $JAVA_ARGS $JAVA_OPTS /stock-service-biz.jar
#CMD java -jar  $JAVA_ARGS $JAVA_OPTS /stock-service-biz.jar
ENTRYPOINT [ "sh", "-c", "java $JVM_OPTS $JAVA_OPTS -jar $workdir/stock-service-biz.jar $APP_OPTS" ]
