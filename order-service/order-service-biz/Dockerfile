FROM openjdk:8u292-jre-slim
LABEL maintainer www.ctnrs.com
ENV workdir=/apps \
    jar_name=order-service-biz.jar \
    gid=1000 \
    uid=1000 \
    user=aspire \
    group=aspire \
    APP_OPTS="$APP_OPTS "\
    JAVA_OPTS="$JAVA_OPTS " \
    JVM_OPTS="$JVM_OPTS -Xss256k -Duser.timezone=Asia/Shanghai -Djava.security.egd=file:/dev/./urandom -Dfile.encoding=UTF8 "

RUN  set -x \
     && groupadd -g ${gid} ${group} \
     && useradd -u ${uid} -g ${group} -s /bin/sh ${user} \
     && set -x \
     && mkdir -p $workdir \
     && chown -R $user:$group $workdir
#     && addgroup -g 1000 -S aspire \
#     && adduser  -u 1000  -G aspire -g aspire aspire
USER $group
COPY --chown=$user:$group ./target/$jar_name $workdir/
#COPY pinpoint /pinpoint
EXPOSE 8020
#CMD java -jar -javaagent:/pinpoint/pinpoint-bootstrap-1.8.3.jar -Dpinpoint.agentId=$(echo $HOSTNAME | awk -F- '{print "stock-"$NF}') -Dpinpoint.applicationName=ms-stock $JAVA_ARGS $JAVA_OPTS /stock-service-biz.jar
#CMD java -jar  $JAVA_ARGS $JAVA_OPTS /stock-service-biz.jar
ENTRYPOINT [ "sh", "-c", "java $JVM_OPTS $JAVA_OPTS -jar $workdir/$jar_name $APP_OPTS" ]
