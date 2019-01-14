# docker-sentinel
alibaba sentinel


# TAGS

`1.4.1`, `latest`

# VOLUME

容器内日志目录：/opt/logs

# run

```shell
docker run --name sentinel -p 8080:8080 -v ./logs:/opt/logs foxiswho/sentinel:1.4.1
```

或

```shell
docker run -e JAVA_OPTS='-Xmx1g' --name sentinel -p 8080:8080 foxiswho/sentinel:1.4.1
```
或

```shell
docker run --rm --name sentinel -p 8080:8080 foxiswho/sentinel:1.4.1
```

或

```shell
docker run --rm -e JAVA_OPTS='-Xmx1g' --name sentinel -p 8080:8080 foxiswho/sentinel:1.4.1
```

# 官网

https://github.com/alibaba/Sentinel

新手指南

[https://github.com/alibaba/Sentinel/wiki/新手指南](https://github.com/alibaba/Sentinel/wiki/%E6%96%B0%E6%89%8B%E6%8C%87%E5%8D%97)






# 根据 Dockerfile 自己编译

编译镜像

```shell
docker build -t foxiswho/sentinel:1.4.1 --build-arg version=1.4.1 ./
```

启动容器
````SHELLL
docker run --rm --name sentinel -p 8080:8080 foxiswho/sentinel:1.4.1

或
docker run --rm -e JAVA_OPTS="-Dserver.port=8080 -Dcsp.sentinel.dashboard.server=localhost:8080 -Dproject.name=sentinel-dashboard -Djava.security.egd=file:/dev/./urandom" --name sentinel -p 8080:8080 foxiswho/sentinel:1.4.1
````



