# Dockerized image for FBCTF (Multi Containers Version)

This is the Git repo of the [dockerized_fbctf:multi_containers](https://hub.docker.com/r/qazbnm456/dockerized_fbctf/) image. It's more easier for you to setup fbctf with other orchestration.

**Relevant links:**
 [facebook/fbctf](https://github.com/facebook/fbctf) |
 [AlexGaspar/docker-fbctf](https://github.com/AlexGaspar/docker-fbctf) |
 [alexgaspar/fbctf](https://hub.docker.com/r/alexgaspar/fbctf/) | 
 [qazbnm456/dockerized_fbctf](https://hub.docker.com/r/qazbnm456/dockerized_fbctf/)

---------------------------------------

##**Table of contents**

#### [Quick Start](#start)
#### [Thanks](#thanks)

---------------------------------------

<a name="start"></a>
## Quick Start

fbctf needs to be server over https, so by default it would generate a self-signed certificate, if you want to use your own certificate you can turn this off by setting $SSL to false, then fbctf container will only server request over :80, so you can do the SSL termination where ever you prefer.

Using docker-compose

```
docker-compose up
```

Step 1. Launch a mysql container

```
docker run --name fbctf-mysql -d \
    --env MYSQL_ROOT_PASSWORD=root \
    --env MYSQL_DATABASE=fbctf \
    --env MYSQL_USER=fbctf --env MYSQL_PASSWORD=fbctf \
    --volume /opt/docker/fbctf/mysql:/var/lib/mysql \
    mysql:5.5
```

Step 2. Launch a memcached container

```
docker run --name fbctf-memcached -d memcached
```

Step 3. Launch the fbctf container

```
docker run --name fbctf -d \
	-p 10080:80 \
	--env MYSQL_USER=fbctf \
	--env MYSQL_PASSWORD=fbctf \
	--env MYSQL_PORT=3306 \
	--env MYSQL_DATABASE=fbctf \
	--env MEMCACHED_PORT=11211 \
	--link fbctf-memcached:memcached \
	--link fbctf-mysql:mysql \
	qazbnm456/dockerized_fbctf:multi_containers
```

<a name="thanks"></a>
## Thanks

Due to a great suggestion mentioned [here](https://github.com/facebook/fbctf/pull/36), [AlexGaspar](https://github.com/AlexGaspar) and I work together with the concept of splitting the resources into multiple containers. I modify some code to fit my needs here, and you may find original one: [AlexGaspar/docker-fbctf](https://github.com/AlexGaspar/docker-fbctf).
