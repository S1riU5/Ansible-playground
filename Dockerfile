FROM ubuntu:20.04

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo ubuntu
RUN echo 'ubuntu:ubuntu' | chpasswd
USER ubuntu
WORKDIR /home/ubuntu

USER ubuntu
RUN apt update
RUN apt -y install ssh
RUN apt -y install vim
RUN apt install -y openssh-server
RUN service ssh start
RUN chown -R ubuntu:root /home/ubuntu





EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-o", "ListenAddress=0.0.0.0"]

