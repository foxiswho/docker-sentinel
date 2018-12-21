
#FROM java:8
FROM centos:7

# Rocketmq version
ENV SENTINEL_VERSION "1.4.0"

# Rocketmq home
ENV SENTINEL_HOME  /opt/

#tme zone
RUN rm -rf /etc/localtime \
&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN yum install -y java-1.8.0-openjdk-headless unzip gettext nmap-ncat openssl\
 && yum clean all -y

RUN mkdir -p \
 /opt/logs

RUN mkdir -p ${SENTINEL_HOME}


WORKDIR  ${SENTINEL_HOME}

# get the version
RUN cd /  \
 && curl https://github.com/alibaba/Sentinel/releases/download/${SENTINEL_VERSION}/sentinel-dashboard-${SENTINEL_VERSION}.jar -o sentinel-dashboard.jar \
 && mv sentinel-dashboard.jar /opt

# add scripts
#COPY scripts/ ${SENTINEL_HOME}/bin/

#
RUN chmod -R +x ${SENTINEL_HOME}/*jar

VOLUME /opt/logs

RUN export JAVA_OPTS="${JAVA_OPTS} -Dserver.port=8280 -Dcsp.sentinel.dashboard.server=localhost:8280 -Dproject.name=sentinel-dashboard -Djava.security.egd=file:/dev/./urandom"

EXPOSE 8280

ENTRYPOINT exec java ${JAVA_OPTS} -jar sentinel-dashboard.jar