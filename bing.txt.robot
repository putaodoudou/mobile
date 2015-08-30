*** Settings ***
Documentation     An acceptance test suite to verify bing features.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
...               @version 1.0.$Id$
Resource          bing.resource.robot
Library           Selenium2Library
Library           AppiumLibrary

*** Variables ***
${DC}                   {"browserName:firefox,version:41"}
${login}                ${NONE}
${password}             ${NONE}

*** Test Cases ***

Search 20 iOS Browser
    Set Library Search Order    AppiumLibrary
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=iOS	platformVersion=8.4
    ...                 deviceName=iPhone 6 	app=Safari
    AppiumLibrary.Wait Until Page Contains     Let's browse!  timeout=60

    Login
    :FOR      ${count}      in range    20
    \   Search One  ${count}
    [TearDown]  Cleanup

Search iOS Browser
    [Documentation]     Mobile web browser
    [Tags]    Mobile
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=iOS	platformVersion=8.4
    ...                 deviceName=iPhone 6 	app=Safari
    Set Library Search Order    AppiumLibrary
    AppiumLibrary.Wait Until Page Contains     Let's browse!  timeout=60

    Login
    Search Many     30
    [TearDown]  Cleanup

Search PC Browser
    [Documentation]     A test to open browser and close
    [Tags]  PC
    Set Test Variable   ${capabilities}    ${NONE}
    Open Browser    https://bing.com/rewards/dashboard    ${BROWSER}     remote_url=${NONE}
    ...             desired_capabilities=${DC}
    Set Library Search Order    Selenium2Library
    Login
    Search Many     30
    [TearDown]  Cleanup


