FROM ubuntu:trusty

MAINTAINER dgq8211@gmail.com

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

RUN echo "Asia/Shanghai" > /etc/timezone \
 && dpkg-reconfigure -f noninteractive tzdata

WORKDIR /opt

ADD linux_unix_FineBI4_1-CN.sh /opt/linux_unix_FineBI4_1-CN.sh

RUN bash -c '/bin/echo -e "\n\n\n\n1\n\n30720\n\n\nn\nn\n" | bash linux_unix_FineBI4_1-CN.sh'

# 30G memory
ARG jvm_memory=30720
ARG http_port=37799

EXPOSE ${http_port}

VOLUME /opt/FineBI/webapps/WebReport/

ENTRYPOINT ["/bin/bash", "/opt/FineBI/FineBI"]

