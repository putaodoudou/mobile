*** Settings ***
Documentation     An acceptance test suite to verify bing features.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
...               @version 1.0.$Id$
Resource          bing.resource.robot

*** Variables ***
${PORT}         4723
${DC}           {"browserName:firefox,version:41,media.volume_scale:0.0"}
${login}        ${NONE}
${password}     ${NONE}
${device}       iPhone 6 Plus
${pVersion}     8.4
${profile}      /data/profile 

*** Test Cases ***
Swagbuck
    [Tags]    Mobile    NONBLOCK
    Import Library	Selenium2Library
    #run_on_failure=Log Source
    Set Test Variable   ${capabilities}    ${NONE}
    Set Test Variable   ${remote_url}			${NONE}
    Set Test Variable      ${url}
    ...             http://www.swagbucks.com/p/login
    Open Browser    ${url}   ${BROWSER}    desired_capabilities=${DC}    ff_profile_dir=${profile}

    Go to Generic   ${url}      Selenium2Library
    Set Library Search Order    Selenium2Library
    Run Keyword And Ignore Error	Login swagbucks
    S Poll
    S Homepage
    S Search
    # .. obsolete and replace with iMacros
    [TearDown]  Cleanup     Selenium2Library
