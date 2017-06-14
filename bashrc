# secrets path below from swarm manager
# expect export list to fail if any of below is undefined or use invalid strings
SPATH=/run/secrets
TRACYPASS=`cat $SPATH/TRACYPASS`
TRACYPASS1=`cat $SPATH/TRACYPASS1`
USER=2501390707@qq.com
USER1=tracyhe2016@gmail.com
USER2=tracyhe2016@yahoo.com

SBUSER=saintcharlessf@gmail.com
SBPWD=`cat $SPATH/KPASS`

SBUSER1=tracyhe2016@gmail.com
export ULIST=( ${USER} ${USER1} ${USER2} )
export PLIST=( ${TRACYPASS1} ${TRACYPASS} ${TRACYPASS} )

export SBLIST=( ${SBUSER} ${USER1} ${USER2} )
export SBPLIST=( ${SBPWD} ${TRACYPASS}  ${TRACYPASS} )

export DOCKER_USER=kenney
export DOCKER_PASS=`cat $SPATH/DOCKER_PASS`
