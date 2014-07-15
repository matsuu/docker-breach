FROM ubuntu:latest

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates libasound2 libgconf-2-4 libgtk2.0 libnss3 libxtst6 openssh-server wget && \
  apt-get clean

RUN cd /opt && \
  wget https://raw.githubusercontent.com/breach/releases/master/v0.3.21-alpha.5/breach-v0.3.21-alpha.5-linux-x64.tar.gz && \
  tar zxf breach-*.tar.gz && \
  rm breach-*.tar.gz && \
  ln -s breach-* breach

RUN mkdir /var/run/sshd

RUN echo "#!/bin/sh\n/opt/breach/__AUTO_UPDATE_BUNDLE__/exo_browser/exo_browser --disable-setuid-sandbox" > /opt/breach/breach

RUN useradd -d /home/breach -p '*' -s /opt/breach/breach breach

RUN mkdir -p /home/breach/.ssh
COPY authorized_keys /home/breach/.ssh/authorized_keys
RUN chmod -R go-rwx /home/breach/.ssh
RUN chown -R breach:breach /home/breach/

ENTRYPOINT ["/usr/sbin/sshd",  "-D"]

EXPOSE 22
