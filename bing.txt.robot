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
${device}		iPhone 6 Plus
${pVersion}		8.4

*** Test Cases ***
# todo http://mlb.com/dominono https://securea.mlb.com/d/stluV/oAj5EwRiE7/rLugOUWr9/entry.jsp
Search Android Browser
    Set Library Search Order    AppiumLibrary
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=${PLATFORM_NAME}
    ...                 platformVersion=${PLATFORM_VERSION} app=${APP}
    ...                 deviceName=${DEVICE_NAME}

    #Login   AppiumLibrary
    Search Test		AppiumLibrary
    :FOR      ${count}      in range    20
    \   Search One  ${count}
    [TearDown]  Cleanup     AppiumLibrary

Search 20 iOS Browser
    Set Library Search Order    AppiumLibrary
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=iOS	platformVersion=${pVersion}
    ...                 deviceName=${device}	app=Safari
    AppiumLibrary.Wait Until Page Contains     Let's browse!  timeout=60

    Login   AppiumLibrary
    :FOR      ${count}      in range    22
    \   Search One  ${count}
    [TearDown]  Cleanup     AppiumLibrary

Interactive
    [Documentation]     Run Bing
    [Tags]    Bing
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=iOS	platformVersion=${pVersion}
    ...                 deviceName=${device}	app=/Applications/Appium.app/Contents/Resources/node_modules/appium/Bing.ipa

Search iOS Browser
    [Documentation]     Mobile web browser
    [Tags]    Mobile
    Open Application	http://localhost:4723/wd/hub	alias=web	platformName=iOS	platformVersion=${pVersion}
    ...                 deviceName=${device}	app=Safari
    Set Library Search Order    AppiumLibrary
    AppiumLibrary.Wait Until Page Contains     Let's browse!  timeout=60

    Login   AppiumLibrary
    Search Many     30      AppiumLibrary
    [TearDown]  Cleanup     AppiumLibrary

Search PC Browser
    [Documentation]     A test to open browser and close
    [Tags]  PC
    Set Test Variable   ${capabilities}    ${NONE}
    Open Browser    https://bing.com/rewards/dashboard    ${BROWSER}     remote_url=${NONE}
    ...             desired_capabilities=${DC}
    Set Library Search Order    Selenium2Library
    Login   Selenium2Library
    Search Many     32      Selenium2Library
    [TearDown]  Cleanup     Selenium2Library
