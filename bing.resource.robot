*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library
...               @version 1.0.$Id$
Library         Selenium2Library
Library         AppiumLibrary
Library         String


*** Variables ***
${REMOTE_URL}       http://localhost:4723/wd/hub
${APP}              Chrome
${to}               60

# saved for android
${PLATFORM_NAME}        Android
${PLATFORM_VERSION}     4.4.2
${DEVICE_NAME}          Android Emulator

*** Keywords ***
Go to Generic
    [Documentation]	Go to API calls with right library from Appium or PC browser
    [Arguments]     ${URL}      ${lib}
    ${status}=      Run Keyword If  '${lib}' == 'Selenium2Library'      Go to         ${URL}
    ${status}=      Run Keyword If  '${lib}' == 'AppiumLibrary'         Go to URL     ${URL}
    ${status}=      Run Keyword If  '${lib}' == 'AppiumLibrary'         AppiumLibrary.Capture Page Screenshot

Cleanup
    [Documentation]	Run only one when one fails with the right API calls from Appium or PC browser
    [Arguments]     ${lib}
    ${status}=      Run Keyword If    '${lib}' == 'Selenium2Library'    Close Browser
    ${status}=      Run Keyword If    '${lib}' == 'AppiumLibrary'       Close Application

Search Many
    [Documentation]	Search multiple entries, caller is expected to call tear down
    [Arguments]     ${total}    ${lib}
    :FOR      ${count}      in range    ${total}
    \   Wait Until Page Contains Element    name=q     timeout=${to}
    \   ${status}=      Run Keyword And Ignore Error      Clear text          name=q
    \   ${random}   Generate Random String  ${count}   [NUMBERS]!@#$%^&*()
    \   Wait Until Page Contains Element    name=q     timeout=${to}
    \   Run Keyword And Ignore Error	Input text          name=q     ${random}
    \   Log	${random}
    \   Wait Until Page Contains Element    name=go     timeout=${to}
    \   Run Keyword And Ignore Error	Click Element       name=go
    \   Log Many	${to}	${count}
    \   Wait Until Page Contains     Feedback
    Go to Generic       ${bingsignin}%22+scenario:%22carousel%22&FORM=ML11Z9&CREA=ML11Z9&rnoreward=1    ${lib}

Login
    [Documentation]	Login to bing with credentials
    [Arguments]     ${lib}
    Set Test Variable      ${bingsignin}   https://www.bing.com/fd/auth/signin?action=interactive&provider=windows_live_id
    Set Test Variable      ${ref}         &return_url=https%3a%2f%2fwww.bing.com%2frewards%2fdashboard%3fwlexpsignin%3d1
    Go to Generic       ${bingsignin}${ref}&src=EXPLICIT&sig=436FFF70C696439D84D126C03DE514D0    ${lib}
    Wait Until Page Contains Element    name=loginfmt   timeout=${to}
    Input text          name=loginfmt      ${login}
    Input text          name=passwd        ${password}
    Click Element       name=SI
    Wait Until Page Contains    Bing Rewards    timeout=${to}

    Set Test Variable      ${bingsignin}    https://bing.com/search?q=top+stories&filters=segment:%22popularnow.carousel
    Go to Generic       ${bingsignin}%22+scenario:%22carousel%22&FORM=ML11Z9&CREA=ML11Z9&rnoreward=1    ${lib}

Search One
    [Documentation]	Search one and a time
    [Arguments]     ${searchword}
    Wait Until Page Contains Element    name=q     timeout=${to}
    Clear text          name=q
    Keyword And Ignore Error    Wait Until Page Contains Element    name=q     timeout=${to}
    Run Keyword And Ignore Error    Input text          name=q     ${searchword}
    Wait Until Page Contains Element    name=go     timeout=${to}
    Run Keyword And Ignore Error    Click Element       name=go
    Wait Until Page Contains     Feedback       timeout=${to}
