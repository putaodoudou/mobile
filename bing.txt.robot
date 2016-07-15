*** Settings ***
Documentation     An acceptance test suite to verify bing features.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
...               @version 1.0.$Id$
Resource          bing.resource.robot

*** Variables ***
${DC}                   {"browserName:firefox,version:41"}
${login}                ${NONE}
${password}             ${NONE}
${device}		iPhone 6 Plus
${pVersion}		8.4

*** Test Cases ***
# todo http://mlb.com/dominono https://securea.mlb.com/d/stluV/oAj5EwRiE7/rLugOUWr9/entry.jsp
Search Android Browser
    Import Library		AppiumLibrary
    Set Library Search Order    AppiumLibrary
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=${PLATFORM_NAME}
    ...                 platformVersion=${PLATFORM_VERSION} app=${APP}
    ...                 deviceName=${DEVICE_NAME}S

    Search Test		AppiumLibrary
    :FOR      ${count}      in range    20
    \   Search One  ${count}	AppiumLibrary
    [TearDown]  Cleanup     AppiumLibrary

Search 20 iOS Browser
    Import Library		AppiumLibrary
    Set Library Search Order    AppiumLibrary
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=iOS    app=Safari
    Wait Until Page Contains     Let's browse!

    Login Init  AppiumLibrary
    Login iOS
    :FOR      ${count}      in range    22
    \   Search One  ${count}	AppiumLibrary
    [TearDown]  Cleanup     AppiumLibrary

Interactive
    [Documentation]     Run Bing
    [Tags]    Bing
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=iOS
    ...                 platformVersion=${pVersion}
    ...                 deviceName=${device}
    ...                 app=/Applications/Appium.app/Contents/Resources/node_modules/appium/Bing.ipa

Search iOS Browser
    [Documentation]     Mobile web browser.  Appium 1.5.3 required matching string which requires
    ...                 not addition to deviceName ...
    [Tags]    Mobile    NONBLOCK
    Import Library		AppiumLibrary
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=iOS    app=Safari
    Set Library Search Order    AppiumLibrary
    Wait Until Page Contains    Let's browse!

    Login Init  AppiumLibrary
    Login iOS
    Search Many     30      AppiumLibrary
    [TearDown]  Cleanup     AppiumLibrary

Search PC Browser
    [Documentation]     Search PC browsers 15 times with random strings
    [Tags]  PC      NONBLOCK
    Import Library	Selenium2Library
    Set Test Variable   ${capabilities}    ${NONE}
    Set Test Variable   ${desired_capabilities}		${DC}
    Set Test Variable   ${remote_url}			${NONE}
    Open Browser    https://bing.com/rewards/dashboard    ${BROWSER}
    Set Library Search Order    Selenium2Library
    Login Init  Selenium2Library
    Login PC
    Search Many     32      Selenium2Library
    [TearDown]  Cleanup     Selenium2Library

Self Test
    Fullfill Daily Activities       file:///Users/user/Documents/onedrive/mobile-appium1.5.3/start.html

Fullfill All
    [Documentation]     FullFill All reward on PC
    [Tags]      NONBLOCK
    Import Library	Selenium2Library
    Set Test Variable   ${capabilities}    ${NONE}
    Set Test Variable   ${desired_capabilities}		${DC}
    Set Test Variable   ${remote_url}			${NONE}
    Open Browser    https://bing.com/rewards/dashboard    ${BROWSER}
    Login Init      Selenium2Library
    Login PC
    Fullfill Many   10   Selenium2Library    https://bing.com/rewards/dashboard
    [TearDown]  Cleanup     Selenium2Library
