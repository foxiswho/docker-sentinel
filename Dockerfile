
#FROM java:8
FROM centos:7

ARG version

# sentinel version
ENV SENTINEL_VERSION ${version:-1.4.1}


# sentinel home
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

RUN export JAVA_OPTS="${JAVA_OPTS} -Dserver.port=8720 -Dcsp.sentinel.dashboard.server=localhost:8720 -Dproject.name=sentinel-dashboard -Djava.security.egd=file:/dev/./urandom"

EXPOSE 8720 8719

ENTRYPOINT exec java ${JAVA_OPTS} -jar sentinel-dashboard.jar