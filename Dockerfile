FROM ubuntu:trusty

MAINTAINER dgq8211@gmail.com

RUN echo "Asia/Shanghai" > /etc/timezone \
 && dpkg-reconfigure -f noninteractive tzdata

RUN echo "" > /etc/apt/sources.list \
 && echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main multiverse restricted universe" >> /etc/apt/sources.list \
 && echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main multiverse restricted universe" >> /etc/apt/sources.list \
 && echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main multiverse restricted universe" >> /etc/apt/sources.list \
 && echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security main multiverse restricted universe" >> /etc/apt/sources.list \
 && echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main multiverse restricted universe" >> /etc/apt/sources.list \
 && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty main multiverse restricted universe" >> /etc/apt/sources.list \
 && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main multiverse restricted universe" >> /etc/apt/sources.list \
 && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main multiverse restricted universe" >> /etc/apt/sources.list \
 && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main multiverse restricted universe" >> /etc/apt/sources.list \
 && echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main multiverse restricted universe" >> /etc/apt/sources.list

# Install zh_cn fonts
RUN apt-get update && apt-get install -y fonts-droid \
  ttf-wqy-zenhei \
  ttf-wqy-microhei \
  fonts-arphic-ukai \
  fonts-arphic-uming \
  language-pack-zh-hans

RUN locale-gen zh_CN.UTF-8

# Default to UTF-8 file.encoding
ENV LANG zh_CN.utf8
ENV LC_ALL zh_CN.utf8


WORKDIR /opt

ARG finebi_url=http://down.finereport.com/linux_unix_FineBI4_1-CN.sh

# 30G memory
ARG jvm_memory=30720
ARG http_port=37799

ENV JVM_MEMORY_LIMIT ${jvm_memory}

RUN apt-get install -y curl \
 && curl -fsSL ${finebi_url} -o /opt/linux_unix_FineBI4_1-CN.sh

RUN bash -c '/bin/echo -e "\n\n\n\n1\n\n${JVM_MEMORY_LIMIT}\n\n\nn\nn\n" | bash linux_unix_FineBI4_1-CN.sh'

EXPOSE ${http_port}

VOLUME /opt/FineBI/webapps/WebReport/

ENTRYPOINT ["/bin/bash", "/opt/FineBI/FineBI"]

