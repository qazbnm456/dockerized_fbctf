# Dockerized image for FBCTF

This is the Git repo of the [dockerized_fbctf](https://hub.docker.com/r/qazbnm456/dockerized_fbctf/) image. It's more easier for you to run fbctf in dev or prod mode.

Default dev mode account: `admin` && `password`

**Relevant links:**
 [fbctf](https://github.com/facebook/fbctf) |
 [dockerized_fbctf](https://hub.docker.com/r/qazbnm456/dockerized_fbctf/)

[![asciicast](https://asciinema.org/a/45614.png)](https://asciinema.org/a/45614)

---------------------------------------

##**Table of contents**

#### [Image](#image)
#### [Build](#build)
#### [TODO](#todo)

---------------------------------------

<a name="image"></a>
## Image

This image use [fbctf_base](https://hub.docker.com/r/qazbnm456/fbctf_base/) as its base image, and support dev and prod mode now.
All you need to do is `docker pull qazbnm456/dockerized_fbctf` and run `docker run -p 80:80 -p 443:443 --rm qazbnm456/dockerized_fbctf`. :D

<a name="build"></a>
## Build

### If you want to build it manually

1. Simply clone this repo and cd to it, then `docker build -t="dockerized_fbctf" .`, and it will build fbctf in dev mode. If you want build fbctf in prod mode, `docker build --build-arg MODE=prod --build-arg DOMAIN=YOUR_DOMAIN -t="dockerized_fbctf" .`.
2. `docker run -p 80:80 -p 443:443 --rm dockerized_fbctf`
3. Go to http://localhost and you should be able to play with fbctf :)

<a name="todo"></a>
## TODO

 - Merging into upstreamm. Track the [PR](https://github.com/facebook/fbctf/pull/36).
