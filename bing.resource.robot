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
${REMOTE_URL}       http://localhost:${PORT}/wd/hub
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
    ${status}=      Run Keyword If    '${lib}' == 'Selenium2Library'    Close All Browsers
    ${status}=      Run Keyword If    '${lib}' == 'AppiumLibrary'       Close Application

Search Many
    [Documentation]	Search multiple entries, caller is expected to call tear down
    [Arguments]     ${total}    ${lib}
    ${status}=      Run Keyword If  '${lib}' == 'AppiumLibrary'
    ...                 Import Library		AppiumLibrary
    ${status}=      Run Keyword If  '${lib}' == 'Selenium2Library'
    ...                 Import Library		Selenium2Library

    Set Test Variable      ${bingsignin}
    ...             https://bing.com/search?q=top+stories&filters=segment:%22popularnow.carousel
    Go to Generic
    ...             ${bingsignin}%22+scenario:%22carousel%22&FORM=ML11Z9&CREA=ML11Z9&rnoreward=1
    ...             ${lib}
    :FOR      ${count}      in range    ${total}
    \   Log Source
    \   Wait Until Page Contains Element    id=sb_form_q    timeout=${to}
    \   Run Keyword If  '${lib}' == 'AppiumLibrary'         Run Keyword And Ignore Error
    ...     Clear Text  id=sb_form_q
    \   Run Keyword If  '${lib}' == 'Selenium2Library'      Run Keyword And Ignore Error
    ...     Clear Element Text          id=sb_form_q
    \   ${random}   Generate Random String  5   [NUMBERS]!@#$%^&*()
    \   Wait Until Page Contains Element    id=sb_form_q
    \   Run Keyword And Ignore Error	Input text          id=sb_form_q     ${random}\n
    \   Log	${random}
    \   Log Many	${to}	${count}
    \   Wait Until Page Contains     Feedback   timeout=${to}
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

Login Init
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

Login PC
    [Documentation]	Login to bing with credentials only for PC
    Log Source
    Wait Until Page Contains Element		name=loginfmt
    Input text          name=loginfmt      ${login}
    Click Element       id=idSIButton9
    Builtin.Sleep       1
    Input text          name=passwd        ${password}
    Builtin.Sleep       1

    Submit Form
    Log Source
    Suspended
    # TODO handle it by selecting Text and Next. next pass with say I have a code
    ${status}=		Run Keyword And Ignore Error	Page Should Contain	${BING_VERIFY}
    Run Keyword If  '${status[0]}' == 'PASS'
    ...             Run Keywords    Log Many        ${status[0]}    ${status[1]}    ${status}
    ...             AND             Verify Email        2501390707
    ...             AND             Verify Code         1234
    Run Keyword If 	${status} == 'None'	Choose Ok On Next Confirmation
    ...		    ELSE    Wait Until Page Contains    Bing Rewards

Login mobile
    [Documentation]	Login to bing with credentials only for iOS
    Log Source
    Wait Until Page Contains Element		id=i0116    timeout=${to}
    Input text          id=i0116        ${login}
    Click Element  id=idSIButton9

    Input text          id=i0118        ${password}
    Click Element       id=idSIButton9
    builtin.sleep       5
    Set Test Variable      ${bingsignin}
    ...             https://bing.com/search?q=top+stories&filters=segment:%22popularnow.carousel
    Go to Generic
    ...             ${bingsignin}%22+scenario:%22carousel%22&FORM=ML11Z9&CREA=ML11Z9&rnoreward=1
    ...             AppiumLibrary

Search One
    [Documentation]	Search one and a time
    [Arguments]     ${searchword}	${lib}
    ${status}=      Run Keyword If  '${lib}' == 'AppiumLibrary'
    ...                 Import Library		AppiumLibrary
    ${status}=      Run Keyword If  '${lib}' == 'Selenium2Library'
    ...                 Import Library		Selenium2Library

    Set Test Variable      ${bingsignin}
    ...             https://bing.com/search?q=top+stories&filters=segment:%22popularnow.carousel
    Go to Generic
    ...             ${bingsignin}%22+scenario:%22carousel%22&FORM=ML11Z9&CREA=ML11Z9&rnoreward=1
    ...             ${lib}
    Log Source
    Wait Until Page Contains Element    id=sb_form_q
    Run Keyword If  '${lib}' == 'AppiumLibrary'         Clear Text                  id=sb_form_q
    Run Keyword If  '${lib}' == 'Selenium2Library'      Clear Element Text          id=sb_form_q
    Keyword And Ignore Error    Wait Until Page Contains Element    id=sb_form_q
    Run Keyword And Ignore Error    Input text          id=sb_form_q     ${searchword}
    Run Keyword And Ignore Error    Click Element       id=sb_form_go
    Wait Until Page Contains     Feedback   timeout=${to}

Fullfill Daily Activities Legacy
    [Documentation]     Regression Test Click through all daily activities with e/Earn 1 or 10 credit
    [Arguments]     ${url}
    Import Library	Selenium2Library
    #Open Browser    ${url}  ${BROWSER}
    Go to Generic   ${url}      Selenium2Library
    Log Source
    ${creditstatus}=        Run Keyword And Ignore Error	Page Should Contain    0 of 1[0] credit
    Log     ${creditstatus}
    Log Source
    Run Keyword If  '${creditstatus[0]}' == 'PASS'
    ...     Run Keywords    Click Element   partial link=0 of 1[0] credit
    ...     AND             Log Source

Fullfill Daily Activities
    [Documentation]     Regression Test Click through all daily activities with e/Earn 1 or 10 credit
    [Arguments]     ${url}
    Import Library	Selenium2Library
    #Open Browser    ${url}  ${BROWSER}
    Go to Generic   ${url}      Selenium2Library
    Log Source
    ${creditstatus}=        Run Keyword And Ignore Error	Page Should Contain    POINTS
    Log     ${creditstatus}
    Log Source
    Run Keyword If  '${creditstatus[0]}' == 'PASS'
    ...     Run Keywords    Click Element   partial link=POINTS
    ...     AND             Log Source

Quiz
    [Documentation]     Welcome tutorial requires clicking next
    ${creditstatus}=        Run Keyword And Ignore Error	Page Should Contain    0 of 3[0] credit
    Log     ${creditstatus}
    Log Source
    Run Keyword If  '${creditstatus[0]}' == 'PASS'
    ...     Run keywords        Click Element   partial link=0 of 3 credits
    ...     AND                 Click Element   partial link=Start playing!
    Log Source

Welcome Tutorial
    [Documentation]     Welcome tutorial requires clicking next
    # Handle case if new account and there needs to go through welcome
    ${status}=        Run Keyword And Ignore Error	Page Should Contain
    ...                     Find out how you can get the most out of Bing Rewards.
    Log     ${status}
    Run Keyword If  '${status[0]}' == 'PASS' and '${creditstatus[0]}' == 'PASS'
    ...     Run Keywords    Repeat Keyword    4     Click Element   partial link=Next
    ...     AND             Click Element   partial link=Finish
    Log Source

Edge support
    [Documentation]    Edge requires clicking next
    ${status}=        Run Keyword And Ignore Error	Page Should Contain
    ...                     Earn 1[0] credit
    Log     ${status}
    Run Keyword If  '${status[0]}' == 'PASS'
    ...     Click Element   partial link=Earn 1[0] credit
    Log Source

    ${status}=        Run Keyword And Ignore Error	Page Should Contain
    ...                     1[0] point
    Log     ${status}
    Run Keyword If  '${status[0]}' == 'PASS'
    ...     Click Element   partial link=1 point
    Log Source

Suspended
    ${status}=        Run Keyword And Ignore Error	Page Should Contain
    ...  We'll send a verification code to your phone.  After you enter the code, you can sign in.
    Log     ${status}
    Run Keyword If  '${status[0]}' == 'PASS'
    ...     Submit Form

    ${status}=        Run Keyword And Ignore Error	Page Should Contain
    ...                     Enter your phone number, and we'll send you a security code
    Log     ${status}
    Run Keyword If  '${status[0]}' == 'PASS'
    ...     Submit Form
    Log Source

Fullfill Many
    [Documentation]	Fullfill multiple entries, caller is expected to call tear down
    [Arguments]     ${total}    ${lib}  ${url}
    ${status}=      Run Keyword If  '${lib}' == 'AppiumLibrary'
    ...                 Import Library		AppiumLibrary
    ${status}=      Run Keyword If  '${lib}' == 'Selenium2Library'
    ...                 Import Library		Selenium2Library
    :FOR      ${count}      in range    ${total}
    \   Fullfill Daily Activities   ${url}

Login swagbucks
    [Documentation]	Login swagbucks
    Wait Until Page Contains Element    name=emailAddress    timeout=${to}
    Input Text      name=emailAddress   ${login}
    Wait Until Page Contains Element    name=password    timeout=${to}
    Input Text      name=password       ${password}
    Submit Form
    ${status}=  Run Keyword And Ignore Error        Click Element       id=goldSurveyModalExit
    #Wait Until Page Contains       SWAG CODE   timeout=${to}


S Homepage
    [Documentation]	Open side bar in homepage

    Set Test Variable   ${url}  http://www.swagbucks.com/Swagbucks
    Go to Generic       ${url}  Selenium2Library

    ${status}=  Run Keyword And Ignore Error        Select Window       id=html
    ${status}=  Run Keyword And Ignore Error        Click Element       id=swagButtonModalExit

    Wait Until Element Is Visible       link=Search   timeout=10
    Run Keyword And Ignore Error        Click Button    sbMainNavToggle

S Poll
    [Documentation]	Click on 3rd item of swagbucks
    Set Test Variable   ${url}  http://www.swagbucks.com/polls
    Go to Generic       ${url}  Selenium2Library
    Wait Until Page Contains   Poll        timeout=${to}
    Run Keyword And Ignore Error        Click Element
    ...                                 xpath=//tr[3]/td/table/tbody/tr/td[2]/table/tbody/tr/td
    Run Keyword And Ignore Error        Click Element   id=btnVote

Detect Crave
    #Wait Until Element Is Visible   css=#link_down    timeout=60
    ${status}=    Run Keyword And Ignore Error   Wait Until Page Contains    00:00   timeout=60
    Run Keyword If  '${status[0]}' != 'PASS'    # TODO Not for me if 2 or 3 needed
    ...     Return From Keyword    ${-1}
    builtin.sleep   40

Continue Crave
    S Homepage

S Crave
    [Documentation]	Click on swagbucks crave
    Set Test Variable   ${url}      http://www.swagbucks.com/watch/daily-crave
    Go to Generic       ${url}      Selenium2Library
    Wait Until Page Contains   Discovering        timeout=${to}
    Detect Crave
    Click Element   css=#link_down
    Detect Crave
    ${status}=    Run Keyword And Ignore Error   Click Element   css=#link_down
    # TODO Not for me if 2 or 3 needed
    Run Keyword If  '${status[0]}' != 'PASS'
    ...     Return From Keyword    ${-1}

    # TODO Not for me if 2 or 3 needed
    ${status}=    Run Keyword And Ignore Error    Detect Crave
    Run Keyword If  '${status[0]}' != 'PASS'
    ...     Return From Keyword    ${-1}
    Wait Until Page Contains    Activity Completed!

S Search
    [Documentation]	Click swagbucks search
    Wait Until Page Contains            Daily Search        timeout=${to}
    Run Keyword And Ignore Error        Click Element   partial link=Daily Search