*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library. Use firebug if necessary for xpath
...                 http://www.wikihow.com/Find-XPath-Using-Firebug or firerobot
...               @version 1.0.$Id$
Library         String

*** Variables ***
${REMOTE_URL}       http://localhost:4723/wd/hub
${APP}              Chrome
${to}               60

# saved for android
${PLATFORM_NAME}        Android
${PLATFORM_VERSION}     4.4.2
${DEVICE_NAME}          Android Emulator
${BING_VERIFY}          We've detected something unusual

*** Keywords ***
Go to Generic
    [Documentation]	Go to API calls with right library from Appium or PC browser
    [Arguments]     ${URL}      ${lib}
    ${status}=      Run Keyword If  '${lib}' == 'Selenium2Library'      Go to         ${URL}
    ${status}=      Run Keyword If  '${lib}' == 'AppiumLibrary'         Go to URL     ${URL}
    ${status}=      Run Keyword If  '${lib}' == 'AppiumLibrary'
    ...                 AppiumLibrary.Capture Page Screenshot

Cleanup
    [Documentation]	Run only one when one fails with the right API calls from Appium or PC browser
    [Arguments]     ${lib}
    ${status}=      Run Keyword If    '${lib}' == 'Selenium2Library'    Close Browser
    ${status}=      Run Keyword If    '${lib}' == 'AppiumLibrary'       Close Application

Search Many
    [Documentation]	Search multiple entries, caller is expected to call tear down
    [Arguments]     ${total}    ${lib}
    ${status}=      Run Keyword If  '${lib}' == 'AppiumLibrary'
    ...                 Import Library		AppiumLibrary
    ${status}=      Run Keyword If  '${lib}' == 'Selenium2Library'
    ...                 Import Library		Selenium2Library
    :FOR      ${count}      in range    ${total}
    \   Wait Until Page Contains Element    name=q
    \   Run Keyword If  '${lib}' == 'AppiumLibrary'         Run Keyword And Ignore Error
    ...     Clear Text          name=q
    \   Run Keyword If  '${lib}' == 'Selenium2Library'      Run Keyword And Ignore Error
    ...     Clear Element Text          name=q
    \   ${random}   Generate Random String  ${count}   [NUMBERS]!@#$%^&*()
    \   Wait Until Page Contains Element    name=q
    \   Run Keyword And Ignore Error	Input text          name=q     ${random}\n
    \   Log	${random}
    \   Wait Until Page Contains Element    name=go
    \   Log Many	${to}	${count}
    \   Wait Until Page Contains     Feedback
    #FIXME for debugging \   Builtin.Sleep	5
    Go to Generic   ${bingsignin}%22+scenario:%22carousel%22&FORM=ML11Z9&CREA=ML11Z9&rnoreward=1
    ...             ${lib}

Verify Phone
    [Arguments]     ${phone4digit}
    Click Element	id=iProofLbl1
    Input text		name=iProofPhone	${phone4digit}
    Click Button    id=iSelectProofAction
    Submit Form

Verify Email
    [Arguments]     ${email}
    Click Element	id=iProofLbl0
    Input text		name=iProofEmail     ${email}
    Click Button    id=iSelectProofAction
    Submit Form

Verify Code
    [Arguments]     ${code}
    #TODO   use tor and try to create situation below
    builtin.sleep   1200
    #xpath=/html/body/div[1]/div[2]/div/div[1]/div[2]/div/div/form/div/section/div/div[2]/div[2]/input
    #xpath=//*[@id="iOttText"]
    #css=html.m_ul.Mozilla body.ltr.SignedOut.Firefox.FF_Mac.FF_M44.FF_D0.Full.RE_Gecko.cb.light.animate div#iPageElt.App div#c_base.c_base div#c_content div#maincontent div#pageControlHost div.confirmIdentity div form#pageDialogForm_1 div#iVerifyCode section.section div.section-body div#iEnterCode.row div.col-xs-24.form-group input#iOttText.form-control.input-max-width
    #Click Element   	iOttText
    #Input text		name=iOttText     ${code}
    #Submit Form

Login
    [Documentation]	Login to bing with credentials
    [Arguments]     ${lib}
    ${status}=
    ...             Run Keyword If  '${lib}' == 'AppiumLibrary'
    ...                 Import Library		AppiumLibrary
    ${status}=      Run Keyword If  '${lib}' == 'Selenium2Library'
    ...                 Import Library		Selenium2Library
    Set Test Variable
    ...             ${bingsignin}
    ...             https://www.bing.com/fd/auth/signin?action=interactive&provider=windows_live_id
    Set Test Variable
    ...             ${ref}
    ...             &return_url=https%3a%2f%2fwww.bing.com%2frewards%2fdashboard%3fwlexpsignin%3d1
    Go to Generic
    ...             ${bingsignin}${ref}&src=EXPLICIT&sig=436FFF70C696439D84D126C03DE514D0    ${lib}
    Set Log Level	DEBUG
    Log Source
    Wait Until Page Contains Element		name=loginfmt
    Input text          name=loginfmt      ${login}
    Input text          name=passwd        ${password}
    Submit Form
    Log Source
    # TODO handle it by selecting Text and Next. next pass with say I have a code
    ${status}=		Run Keyword If  '${lib}' == 'AppiumLibrary'
    ...         Run Keyword And Ignore Error	Page Should Not Contain Text	${BING_VERIFY}
    ${status}=		Run Keyword If  '${lib}' == 'Selenium2Library'
    ...         Run Keyword And Ignore Error	Page Should Contain	${BING_VERIFY}
    Run Keyword If  '${status[0]}' == 'PASS'
    ...             Run Keywords    Log Many        ${status[0]}    ${status[1]}    ${status}
    ...             AND             Verify Email        2501390707
    ...             AND             Verify Code         1234
    Run Keyword If 	${status} == 'None'	Choose Ok On Next Confirmation
    ...		    ELSE    Wait Until Page Contains    Bing Rewards

    Set Test Variable      ${bingsignin}
    ...             https://bing.com/search?q=top+stories&filters=segment:%22popularnow.carousel
    Go to Generic
    ...             ${bingsignin}%22+scenario:%22carousel%22&FORM=ML11Z9&CREA=ML11Z9&rnoreward=1
    ...             ${lib}

Search One
    [Documentation]	Search one and a time
    [Arguments]     ${searchword}	${lib}
    ${status}=      Run Keyword If  '${lib}' == 'AppiumLibrary'
    ...                 Import Library		AppiumLibrary
    ${status}=      Run Keyword If  '${lib}' == 'Selenium2Library'
    ...                 Import Library		Selenium2Library
    Wait Until Page Contains Element    name=q
    Run Keyword If  '${lib}' == 'AppiumLibrary'         Clear Text                  name=q
    Run Keyword If  '${lib}' == 'Selenium2Library'      Clear Element Text          name=q
    Keyword And Ignore Error    Wait Until Page Contains Element    name=q
    Run Keyword And Ignore Error    Input text          name=q     ${searchword}
    Wait Until Page Contains Element    name=go
    Run Keyword And Ignore Error    Click Element       name=go
    Wait Until Page Contains     Feedback
