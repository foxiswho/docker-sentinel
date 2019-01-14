
#FROM java:8
FROM centos:7

ARG version
ARG ip
ARG port

# sentinel version
ENV SENTINEL_VERSION ${version:-1.4.1}
#host
ENV IP ${ip:-localhost}
#ip
ENV PORT ${port:-8080}


# sentinel home
ENV SENTINEL_HOME  /opt/
ENV SENTINEL_LOGS  /opt/logs

#tme zone
RUN rm -rf /etc/localtime \
&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN yum install -y java-1.8.0-openjdk-headless unzip gettext nmap-ncat openssl wget\
 && yum clean all -y

# create logs
RUN mkdir -p ${SENTINEL_LOGS}

# get the version
RUN cd /  \
 && wget https://github.com/alibaba/Sentinel/releases/download/${SENTINEL_VERSION}/sentinel-dashboard-${SENTINEL_VERSION}.jar -O sentinel-dashboard.jar \
 && mv sentinel-dashboard.jar ${SENTINEL_HOME}
# test file
#COPY sentinel-dashboard.jar ${SENTINEL_HOME}

# add scripts
COPY scripts/* /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
&& ln -s /usr/local/bin/docker-entrypoint.sh /opt/docker-entrypoint.sh

#
RUN chmod -R +x ${SENTINEL_HOME}/*jar

VOLUME ${SENTINEL_LOGS}

WORKDIR  ${SENTINEL_HOME}

EXPOSE ${PORT}

ENTRYPOINT ["docker-entrypoint.sh"]

CMD java ${JAVA_OPTS} -jar sentinel-dashboard.jar
