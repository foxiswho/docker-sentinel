# docker-sentinel
alibaba sentinel


# TAGS

`1.4.1`, `latest`

# run

```shell
docker run -e JAVA_OPTS='-Xmx1g' --name sentinel -p 8720:8720 -p 8719:8719 foxiswho/docker-sentinel-1.4.1
```


```shell
docker run --rm -e JAVA_OPTS='-Xmx1g' --name sentinel -p 8720:8720 -p 8719:8719 foxiswho/docker-sentinel-1.4.1
```