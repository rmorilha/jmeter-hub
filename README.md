[![Docker Build](https://img.shields.io/docker/automated/justb4/jmeter.svg)](https://hub.docker.com/r/keepnix/jmeter/)

# docker-jmeter

Docker image for [Apache JMeter](http://jmeter.apache.org).
Using [alpine latest](https://hub.docker.com/_/alpine/).

### Build Options

Default values if not passed to build:

- **JMETER_VERSION** - JMeter version, default ``4.0``
- **IMAGE_TIMEZONE** - timezone of Docker image, default ``"America/Sao_Paulo"``

## Running
To run this docker image:

```
docker run -P -ti -d --name jmeter-cnt-keepnix jmeter-keepnix
```

## User Defined Variables

This is a standard facility of JMeter: settings in a JMX test script
may be defined symbolically and substituted at runtime via the commandline.
These are called JMeter User Defined Variables or UDVs.

See [test.sh](test.sh) and the [trivial test plan](tests/trivial/test-plan.jmx).

See also: http://blog.novatec-gmbh.de/how-to-pass-command-line-properties-to-a-jmeter-testplan/

## Specifics

The Docker image built from the 
[Dockerfile](Dockerfile) inherits from the [Alpine Linux](https://www.alpinelinux.org) distribution:

> "Alpine Linux is built around musl libc and busybox. This makes it smaller 
> and more resource efficient than traditional GNU/Linux distributions. 
> A container requires no more than 8 MB and a minimal installation to disk 
> requires around 130 MB of storage. 
> Not only do you get a fully-fledged Linux environment but a large selection of packages from the repository."

See https://hub.docker.com/_/alpine/ for Alpine Docker images.

The Docker image will install (via Alpine ``apk``) several required packages most specificly
the ``OpenJDK Java JRE``.  JMeter is installed by simply downloading/unpacking a ``.tgz`` archive
from http://mirror.serversupportforum.de/apache/jmeter/binaries within the Docker image.

A generic [entrypoint.sh](entrypoint.sh) is copied into the Docker image and
will be the script that is run when the Docker container is run. The
[entrypoint.sh](entrypoint.sh) simply calls ``jmeter``

## Credits

Thanks to https://github.com/justb4/docker-jmeter for providing
the Dockerfile that inspired me.
