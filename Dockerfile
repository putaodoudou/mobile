FROM kenney/robot-firefox-centos:latest

MAINTAINER Kenney He <kenneyhe@gmail.com>

LABEL version "0.0.0.1"

LABEL description "Run bing reward feature"

WORKDIR	/data

ADD bing.txt.robot /data/
ADD bing.resource.robot /data/
#COPY bashrc /data/.bashrc

#RUN /bin/bash -c 'source .bashrc ; env'
RUN pip install --upgrade pip
RUN pip install robotframework-appiumlibrary

# TODO save credential
#RUN pybot -e mobile -i NONBLOCK -v BROWSER:firefox -v login:${LOGIN} \
#      -v DC:"browserName:firefox,version:41" -v password:${PASS} \
#      -v device:"iPhone 6" -v DEVICE_NAME:"iPhone 6" -v deviceName:"iPhone 6" \
#      -v pVersion:8.1  -d tracy bing.txt.robot
