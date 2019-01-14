
#FROM java:8
FROM centos:7

ARG version
ARG host
ARG ip

# sentinel version
ENV SENTINEL_VERSION ${version:-1.4.1}
#host
ENV HOST ${host:-localhost}
#ip
ENV IP ${ip:-8080}


# sentinel home
ENV SENTINEL_HOME  /opt/

#tme zone
RUN rm -rf /etc/localtime \
&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN yum install -y java-1.8.0-openjdk-headless unzip gettext nmap-ncat openssl wget\
 && yum clean all -y

RUN mkdir -p \
 /opt/logs

RUN mkdir -p ${SENTINEL_HOME}


WORKDIR  ${SENTINEL_HOME}

# get the version
RUN cd /  \
 && wget https://github.com/alibaba/Sentinel/releases/download/${SENTINEL_VERSION}/sentinel-dashboard-${SENTINEL_VERSION}.jar -O sentinel-dashboard.jar \
 && mv sentinel-dashboard.jar ${SENTINEL_HOME}

# add scripts
#COPY scripts/ ${SENTINEL_HOME}/bin/

#
RUN chmod -R +x ${SENTINEL_HOME}/*jar

VOLUME /opt/logs

ENV JAVA_OPTS="-Dserver.port=${IP} -Dcsp.sentinel.dashboard.server=${HOST}:${IP} -Dproject.name=sentinel-dashboard -Djava.security.egd=file:/dev/./urandom ${JAVA_OPTS}"

EXPOSE ${IP}

ENTRYPOINT exec java ${JAVA_OPTS} -jar sentinel-dashboard.jar
