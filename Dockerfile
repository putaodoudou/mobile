FROM kenney/robot-firefox-alpine:latest

MAINTAINER Kenney He <kenneyhe@gmail.com>

LABEL version "0.0.0.1"

LABEL description "Run bing reward feature"

ADD . /data

WORKDIR	/data

# Need to fix docker plugin to use pwd of base project
ADD bing.txt.robot /data/
ADD bing.resource.robot /data/
ADD bashrc /data/.bashrc
ADD xvfb-run /usr/bin/xvfb-run

# requirement list like pabot
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ENTRYPOINT [ "xvfb-run" , "pybot" ]
