FROM kenney/robot-firefox-alpine:latest

MAINTAINER Kenney He <kenneyhe@gmail.com>

LABEL version "0.0.0.1"

LABEL description "Run bing reward feature"

WORKDIR	/data

# Need to fix docker plugin to use pwd of base project
ADD bing.txt.robot /data/
ADD bing.resource.robot /data/
ADD swarm.robot /data/
ADD requirements.txt /data/


COPY bashrc /run.sh
RUN chmod 755 /run.sh

ADD xvfb-run /usr/bin/xvfb-run

# requirement list like pabot
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ENTRYPOINT  [ "/run.sh" ]
