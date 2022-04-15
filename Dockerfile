FROM jenkins/jnlp-slave
MAINTAINER DaoMing
USER root
RUN apt-get -y update
RUN apt-get install wget
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-18.06.3-ce.tgz && tar xzvf docker-18.06.3-ce.tgz && cp docker/* /usr/bin/
RUN curl -o kubectl https://amazon-eks.s3.cn-north-1.amazonaws.com.cn/1.15.10/2020-02-22/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
