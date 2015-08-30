*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library
...               @version 1.0.$Id$
Library         Selenium2Library
Library         Screenshot
Library         RequestsKeywords.py
Library         CssProperties.py
Library         Process
Library         OperatingSystem
Library         SSHLibrary
Library         AppiumLibrary


*** Variables ***
${REMOTE_URL}   http://localhost:4723/wd/hub
# saved for android
${PLATFORM_NAME}    Android
${PLATFORM_VERSION}    4.2.2
${DEVICE_NAME}    Android Emulator
${to}               60


*** Keywords ***
Go to Generic
    #todo run only one when one fails
    [Arguments]     ${URL}
    ${status}=      Run Keyword And Ignore Error      Go to         ${URL}
    ${status}=      Run Keyword And Ignore Error      Go to URL     ${URL}

Cleanup
    #todo run only one when one fails
    ${status}=      Run Keyword And Ignore Error    Close Browser
    ${status}=      Run Keyword And Ignore Error    Close Application

Search Many
    [Arguments]     ${total}
    :FOR      ${count}      in range    ${total}
    \   Wait Until Page Contains Element    name=go
    \   ${status}=      Run Keyword And Ignore Error      Clear text          name=q
    \   Input text          name=q     ${count}
    \   Click Element       name=go
    \   Wait Until Page Contains     Feedback
    Go to Generic       ${bingsignin}%22+scenario:%22carousel%22&FORM=ML11Z9&CREA=ML11Z9&rnoreward=1
    [Teardown]  Cleanup

Login
    Set Test Variable      ${bingsignin}   https://bing.com/fd/auth/signin?action=interactive&provider=windows_live_id
    Set Test Variable      ${ref}         &return_url=https%3a%2f%2fwww.bing.com%2frewards%2fdashboard%3fwlexpsignin%3d1
    Go to Generic       ${bingsignin}${ref}&src=EXPLICIT&sig=436FFF70C696439D84D126C03DE514D0
    Wait Until Page Contains Element    name=loginfmt   timeout=60
    Input text          name=loginfmt      ${login}
    Input text          name=passwd        ${password}
    Click Element       name=SI
    Wait Until Page Contains    Bing Rewards    timeout=60

    Set Test Variable      ${bingsignin}    https://bing.com/search?q=top+stories&filters=segment:%22popularnow.carousel
    Go to Generic       ${bingsignin}%22+scenario:%22carousel%22&FORM=ML11Z9&CREA=ML11Z9&rnoreward=1

Search One
    [Arguments]     ${searchword}

    Wait Until Page Contains Element    name=go
    Clear text          name=q
    Input text          name=q     ${searchword}
    Click Element       name=go
    Wait Until Page Contains     Feedback
