FROM debian:9
ENV PASSWORD def456..
RUN echo "$PASSWORD\n$PASSWORD" | passwd root
RUN apt-get update && apt-get install openssh-client openssh-server curl wget gnupg gnupg2 gnupg1 -y && echo "deb http://www.apache.org/dist/cassandra/debian 311x main" |  tee -a /etc/apt/sources.list.d/cassandra.sources.list && wget -q -O - https://www.apache.org/dist/cassandra/KEYS | apt-key add - && apt update && apt install cassandra -y

COPY ./sshd_config /etc/ssh/
ENTRYPOINT /usr/bin/ssh-keygen -A && /etc/init.d/ssh restart && bash

