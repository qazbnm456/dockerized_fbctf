# Dockerized image for FBCTF

This is the Git repo of the [dockerized_fbctf](https://hub.docker.com/r/qazbnm456/dockerized_fbctf/) image. It's more easier for you to run fbctf in development mode.

Default account: `admin` && `password`

**Relevant links:**
 [fbctf](https://github.com/facebook/fbctf)
 [dockerized_fbctf](https://hub.docker.com/r/qazbnm456/dockerized_fbctf/)

---------------------------------------

##**Table of contents**

#### [Image](#image)
#### [Build](#build)
#### [TODO](#todo)

---------------------------------------

<a name="image"></a>
## Image

You can use [dockerized_fbctf](https://hub.docker.com/r/qazbnm456/dockerized_fbctf/) as your base image to do other custom stuffs.
Write your dockerfile like:

```
From qazbnm456/dockerized_fbctf:latest

CMD ["/sbin/my_init"]

# ~~ Put your code here ~~

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

```

<a name="howto"></a>
## HowTo

1. Simply clone this repo and cd to it, then `docker build -t="dockerized_fbctf" .`.
2. `docker run -p 80:80 -p 443:443 --rm dockerized_fbctf`
3. Go to http://localhost and you should be able to view the website :)

p.s. I delete HSTS option cause we are in dev mode, which doesn't help a lot.

<a name="todo"></a>
## TODO

1. Finish prod mode as well.
2. Add let's encrypt support.
3. Minimize image size.
