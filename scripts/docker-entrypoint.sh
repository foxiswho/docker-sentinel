#!/bin/bash


export JAVA_OPTS="-Dserver.port=${IP} -Dcsp.sentinel.dashboard.server=${HOST}:${IP} -Dcsp.sentinel.log.dir=${SENTINEL_LOGS} -Dproject.name=sentinel-dashboard -Djava.security.egd=file:/dev/./urandom ${JAVA_OPTS}"



exec "$@"