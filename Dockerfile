FROM ubuntu:14.04
MAINTAINER Bryan Burke <btburke@fastmail.com>

RUN apt-get install -y apt-transport-https ca-certificates software-properties-common wget
RUN add-apt-repository ppa:webupd8team/java && apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer
RUN wget -O /tmp/scala.tgz http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz && tar -C /usr/local/lib -xvzf /tmp/scala.tgz
RUN ln -s /usr/local/lib/scala-2.11.8/bin/scala /usr/local/bin/scala
RUN ln -s /usr/local/lib/scala-2.11.8/bin/scalac /usr/local/bin/scalac
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 && apt-get update
RUN apt-get install -y sbt

RUN mkdir -p /code
VOLUME /code
WORKDIR /code

ENTRYPOINT ["sbt"]
