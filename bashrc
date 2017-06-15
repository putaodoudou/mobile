#!/bin/sh -x
# secrets path below from swarm manager
# expect export list to fail if any of below is undefined or use invalid strings

SPATH=/run/secrets
export TRACYPASS=`cat $SPATH/TRACYPASS`
export TRACYPASS1=`cat $SPATH/TRACYPASS1`
export USER=2501390707@qq.com
export USER1=tracyhe2016@gmail.com
export USER2=tracyhe2016@yahoo.com

export SBUSER=saintcharlessf@gmail.com
export SBPWD=`cat $SPATH/KPASS`

export SBUSER1=tracyhe2016@gmail.com

export DOCKER_USER=kenney
export DOCKER_PASS=`cat $SPATH/DOCKER_PASS`

env
ls -al /run/secrets/*
cd /data
sh -x $*