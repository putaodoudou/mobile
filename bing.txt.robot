*** Settings ***
Documentation     An acceptance test suite to verify bing features.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
...               @version 1.0.$Id$
Resource          bing.resource.robot

*** Variables ***
${DC}                   {"browserName:firefox,version:41,media.volume_scale:0.0"}
${login}                ${NONE}
${password}             ${NONE}
${device}		iPhone 6 Plus
${pVersion}		8.4

*** Test Cases ***
# todo http://mlb.com/dominono https://securea.mlb.com/d/stluV/oAj5EwRiE7/rLugOUWr9/entry.jsp
Search Android Browser
    Import Library		AppiumLibrary
    Set Library Search Order    AppiumLibrary
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=Android
    ...                 platformVersion=${PLATFORM_VERSION}
    ...                 browserName=browser
    ...                 deviceName=${DEVICE_NAME}

    Login Init		AppiumLibrary
    Login mobile
    :FOR      ${count}      in range    20
    \   Search One  ${count}	AppiumLibrary
    [TearDown]  Cleanup     AppiumLibrary

Search 20 iOS Browser
    Import Library		AppiumLibrary
    Set Library Search Order    AppiumLibrary
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=iOS    app=Safari
    Wait Until Page Contains     Let's browse!

    Login Init  AppiumLibrary
    Login mobile
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
    Login mobile
    Search Many     30      AppiumLibrary
    [TearDown]  Cleanup     AppiumLibrary

Search PC Browser
    [Documentation]     Search PC browsers 15 times with random strings
    [Tags]  PC      NONBLOCK
    Import Library	Selenium2Library     run_on_failure=Log Source
    Set Test Variable   ${capabilities}    ${NONE}
    Set Test Variable   ${remote_url}			${NONE}
    Open Browser    https://bing.com/rewards/dashboard    ${BROWSER}    desired_capabilities=${DC}
    Set Library Search Order    Selenium2Library
    Login Init  Selenium2Library
    Login PC
    Search Many     32      Selenium2Library
    [TearDown]  Cleanup     Selenium2Library

Self Test
    Import Library	Selenium2Library
    # TODO setup selenium grid on virtual pc
    Open Browser    http://www.google.com    firefox    None    http://a92fe9e2.ngrok.io:4444/wd/hub

    #Create Webdriver	Edge    file:///Users/user/Documents/onedrive/mobile-appium1.5.3/suspend.html
    #Open Browser       file:///Users/user/Documents/onedrive/mobile-appium1.5.3/suspend.html
    #...                 desired_capabilities=${DC}
    Suspended

Fullfill All
    [Documentation]     FullFill All reward on PC
    [Tags]      NONBLOCK
    Import Library	Selenium2Library
    Set Test Variable   ${capabilities}    ${NONE}
    Set Test Variable   ${remote_url}			${NONE}
    Open Browser    https://bing.com/rewards/dashboard    ${BROWSER}    desired_capabilities=${DC}
    Login Init      Selenium2Library
    Login PC
    Fullfill Many   10   Selenium2Library    https://bing.com/rewards/dashboard
    [TearDown]  Cleanup     Selenium2Library

Swagbuck
    [Tags]    Mobile    NONBLOCK
    Import Library	Selenium2Library
    #run_on_failure=Log Source
    Set Test Variable   ${capabilities}    ${NONE}
    Set Test Variable   ${remote_url}			${NONE}
    Set Test Variable      ${url}
    ...             http://www.swagbucks.com/p/login
    Open Browser    ${url}   ${BROWSER}    desired_capabilities=${DC}

    Go to Generic   ${url}      Selenium2Library
    Set Library Search Order    Selenium2Library

    Login swagbucks
    S Poll
    S Homepage
    S Search
    S Homepage
    ${status}=    Run Keyword And Ignore Error   S Crave
    Run Keyword If  '${status[0]}' != 'PASS'
    ...     Fail

    ${status}=    Run Keyword And Ignore Error   S Crave
    Run Keyword If  '${status[0]}' != 'PASS'
    ...     Fail

    ${status}=    Run Keyword And Ignore Error   S Crave
    Run Keyword If  '${status[0]}' != 'PASS'
    ...     Fail

    builtin.sleep   5
    [TearDown]  Cleanup     Selenium2Library
