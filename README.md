# Dockerized image for FBCTF

This repo aims to dockerized [fbctf](https://github.com/facebook/fbctf).

**Relevant links:**
 [fbctf](https://github.com/facebook/fbctf)

---------------------------------------

##**Table of contents**

 * [HowTo](#howto)
 * [TODO](#todo)

---------------------------------------

<a name="howto"></a>
## HowTo

1. Simply clone this repo and cd to it, then `docker build -t="fbctf" .`.
2. `docker run -p 80:80 -p 443:443 --rm fbctf`
3. Go to http://localhost and you should be able to view the website :)

p.s. I delete HSTS option cause we are in dev mode, which doesn't help a lot.

<a name="todo"></a>
## TODO

1. Finish prod mode as well.
2. Add let's encrypt support.
3. Minimize image size.
