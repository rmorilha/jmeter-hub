# inspired by https://github.com/justb4/docker-jmeter
FROM alpine:latest

MAINTAINER Renan Morilha<keeplinuxbr@protonmail.ch>

ARG JMETER_VERSION="4.0"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_BIN	${JMETER_HOME}/bin
ENV	JMETER_DOWNLOAD_URL  http://mirrors.ocf.berkeley.edu/apache/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

# Install extra packages

RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update openjdk8-jre tzdata curl unzip bash \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf /tmp/dependencies

# Set Timezone After Installing tzdata
RUN unset TZ
ENV TZ="America/Sao_Paulo"
RUN  cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
     && echo "America/Sao_Paulo" >  /etc/timezone \
     && echo "America/Sao_Paulo" >  /etc/TZ


# TODO: plugins (later)
# && unzip -oq "/tmp/dependencies/JMeterPlugins-*.zip" -d $JMETER_HOME

# Set global PATH such that "jmeter" command is found
ENV PATH $PATH:$JMETER_BIN
ENV HEAP="-Xms1g -Xmx1g -XX:MaxMetaspaceSize=256m"

# Entrypoint has same signature as "jmeter" command
COPY entrypoint.sh /
COPY tests/ /

WORKDIR	${JMETER_HOME}

ENTRYPOINT ["/entrypoint.sh"]
