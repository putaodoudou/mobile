# Dockerfile must be run with "tar -czh . | docker build -" to work around symbolic unsupported by docker build
FROM kenney/robot-firefox:latest

MAINTAINER Kenney He <kenneyhe@gmail.com>

LABEL version "0.0.0.1"

LABEL description "Run bing reward feature"

ADD . /data

WORKDIR	/data

# Need to fix docker plugin to use pwd of base project

ADD bing.txt.robot /data/
ADD bing.resource.robot /data/
ADD bashrc /data/.bashrc

# requirement list like pabot
RUN pip install --upgrade pip
RUN pip install -r requirements.txt


# TODO save credential
RUN echo pybot -e mobile -i NONBLOCK -v BROWSER:firefox -v login:${LOGIN} \
      -v DC:"browserName:firefox,version:41" -v password:${PASS} \
      -v device:"iPhone 6" -v DEVICE_NAME:"iPhone 6" -v deviceName:"iPhone 6" \
      -v pVersion:8.1  -d /tmp bing.txt.robot
