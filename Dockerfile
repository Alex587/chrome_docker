FROM debian:jessie

ADD https://dl.google.com/linux/linux_signing_key.pub /tmp/
COPY run_chrome /bin/
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install -y --no-install-recommends dbus-x11 libexif12 && \
    chmod +x /bin/run_chrome && \
  apt-key add /tmp/linux_signing_key.pub && \
  echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable && \
  apt-get clean -y && \
    groupadd --gid 9999 docker && \
    useradd --password='' --uid=9999 --gid=docker --shell=/bin/bash --create-home docker

CMD /bin/run_chrome
