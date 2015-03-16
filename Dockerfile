FROM ubuntu:14.04
MAINTAINER Carles Amigó, fr3nd@fr3nd.net

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt-get update && apt-get install -y --force-yes \
      curl \
      maven \
      oracle-java8-installer && \
      rm -rf /usr/share/doc/* && \
      rm -rf /usr/share/info/* && \
      rm -rf /tmp/* && \
      rm -rf /var/tmp/*

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV SPARK_VERSION 1.2.0
ENV SPARK_HOME /opt/spark

# Install Spark
RUN curl http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}.tgz | tar -xz -C /opt/
RUN ln -s /opt/spark-${SPARK_VERSION} /opt/spark
WORKDIR /opt/spark
RUN ./make-distribution.sh --skip-java-test

ENV PATH $PATH:$SPARK_HOME/bin
WORKDIR /
