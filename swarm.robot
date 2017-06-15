*** Settings ***
Documentation     Swarm feature with Docker to verify bing features.
...
...               This test secrets from swarm manager
...               @version 1.0.$Id$
Resource        bing.resource.robot
Library         String
Library         OperatingSystem

*** Variables ***
${PORT}         4723
${DC}           {"browserName:firefox,version:41,media.volume_scale:0.0"}
${login}        ${NONE}
${password}     ${NONE}
${device}       iPhone 6 Plus
${pVersion}     8.4
${profile}      profile

*** Test Cases ***
USER1 RUN
    ${envlogin}=           Get Environment Variable    USER1   ${EMPTY}
    ${envpassword}=        Get Environment Variable    TRACYPASS   ${EMPTY}
    Set Global Variable     ${login}    ${envlogin}
    Set Global Variable     ${password}    ${envpassword}
    Search on PC    firefox

USER2 RUN
    ${envlogin}=           Get Environment Variable    USER2   ${EMPTY}
    ${envpassword}=        Get Environment Variable    TRACYPASS   ${EMPTY}
    Set Global Variable     ${login}    ${envlogin}
    Set Global Variable     ${password}    ${envpassword}
    Search on PC    firefox