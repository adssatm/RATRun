*** Settings ***
Library     D:\\RATFramework\\Library\\RATLibrary
Library     Selenium2Library        run_on_failure=Nothing
Library     DateTime

*** Keywords ***
LOG IMAGE
    [Arguments]    ${PARAMETER}
    Set Test Variable   ${CAPTURE}            False
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}    CAPTURE         False
    ${CAPTURE}=         Get Parameter Value             ${PARAMETER}    CAPTURE
    ${INDEXSHOT}=       Create File Name by Index       ${RUNLOGIMG}    png
    ${FLAGCAPTURE}=     Convert To Boolean  ${CAPTURE}
    Run Keyword If      ${FLAGCAPTURE}       Capture Page screenshot    ${RUNLOGIMG}${/}${INDEXSHOT}.png
    Run Keyword If      ${FLAGCAPTURE}       Set Test Variable          ${INDEXSHOT}    ${INDEXSHOT}.png
    ...         ELSE    Set Test Variable   ${INDEXSHOT}                None
    Set Global Variable  ${INDEXSHOT}

LOG TXT FILE
    [Arguments]         ${TEXT}
    Set Test Variable   ${RESULTTEXT}       ${TEXT}
    Set Test Variable   ${LOGTEXT}          False
    ${CHECKTEXT}=       Verify None Parameter Value         ${TEXT}
    Run Keyword If      ${CHECKTEXT} == True                Set Test Variable       ${LOGTEXT}       True
    ${INDEXLOGFILE}=    Create file name by index           ${RUNLOGFILE}       txt
    Run Keyword If      ${LOGTEXT}      create text File    ${RUNLOGFILE}       ${INDEXLOGFILE}
    Run Keyword If      ${LOGTEXT}      write text file     ${RUNLOGFILE}${/}${INDEXLOGFILE}.txt       ${RESULTTEXT}
    Run Keyword If      ${LOGTEXT}      Set Test Variable   ${INDEXLOGFILE}     ${INDEXLOGFILE}.txt
    ...         ELSE    Set Test Variable   ${INDEXLOGFILE}     None
    Set Global Variable     ${INDEXLOGFILE}

LOG FILE TYPE
    [Arguments]         ${TEXT}     ${FILETYPE}
    Set Test Variable   ${RESULTTEXT}       ${TEXT}
    Set Test Variable   ${LOGTEXT}          False
    ${CHECKTEXT}=       Verify None Parameter Value         ${TEXT}
    Run Keyword If      ${CHECKTEXT} == True                Set Test Variable       ${LOGTEXT}              True
    ${INDEXLOGFILE}=    Create file name by index           ${RUNLOGFILE}           ${FILETYPE}
    Run Keyword If      ${LOGTEXT}      create file type    ${RUNLOGFILE}           ${INDEXLOGFILE}         ${FILETYPE}
    Run Keyword If      ${LOGTEXT}      write text file     ${RUNLOGFILE}${/}${INDEXLOGFILE}.${FILETYPE}    ${RESULTTEXT}
    Run Keyword If      ${LOGTEXT}      Set Test Variable   ${INDEXLOGFILE}         ${INDEXLOGFILE}.${FILETYPE}
    ...         ELSE    Set Test Variable   ${INDEXLOGFILE}     None
    Set Global Variable     ${INDEXLOGFILE}

RAT WEB OPEN BROWSER
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${URL}          None
    Set Test Variable   ${BROWSER}      None
    Set Test Variable   ${ALIAS}        None
    Set Test Variable   ${CHECKPARAM}   ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        URL             NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        BROWSER         firefox
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ALIAS           RATWEB1
    ${URL}=             Get Parameter Value             ${PARAMETER}        URL
    ${URL}=             Verify Parameter Value          ${URL}              ${RUNITER}
    ${BROWSER}=         Get Parameter Value             ${PARAMETER}        BROWSER
    ${BROWSER}=         Verify Parameter Value          ${BROWSER}          ${RUNITER}
    ${ALIAS}=           Get Parameter Value             ${PARAMETER}        ALIAS
    ${ALIAS}=           Verify Parameter Value          ${ALIAS}            ${RUNITER}
    Run Keyword If  '${URL}' != 'NO'                    Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True   Run Keyword And Return Status   Open Browser    ${URL}      ${BROWSER}      ${ALIAS}
    # Log debug for dev function
    Log                 URL= ${URL} | BROWSER= ${BROWSER} | ALIAS= ${ALIAS}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Open browser web :  [ ${URL} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Can open web :  [ ${URL} ] on browser [ ${BROWSER} ] and alis name := ${ALIAS}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Can not open web : [ ${URL} ]  (check parameter URL)
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Open Browser   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Open Browser   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB CLOSE ALL BROWSER
    [Arguments]    ${PARAMETER}        ${RUNITER}
    ${STATUS}=      Run Keyword And Return Status   Close All Browsers
# Write logger report function
    ${EXPECTED}=    Plus Connect String     Close all browser  .
    ${ACTUALPASS}=  Plus Connect String     Passed, Can close all browser  .
    ${ACTUALFAIL}=  Plus Connect String     Failed, Can not close all browser  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Close All Browser   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Close All Browser  ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB CLOSE BROWSER
    [Arguments]    ${PARAMETER}        ${RUNITER}
    ${STATUS}=      Run Keyword And Return Status   Close Browser
# Write logger report function
    ${EXPECTED}=    Plus Connect String     Close browser  .
    ${ACTUALPASS}=  Plus Connect String     Passed, Can close browser  .
    ${ACTUALFAIL}=  Plus Connect String     Failed, Can not close browser  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Close Browser   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Close Browser   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB SELECT FRAME BROWSER
    [Arguments]    ${PARAMETER}     ${RUNITER}
    Set Test Variable   ${FRAMENAME}    None
    Set Test Variable   ${CHECKPARAM}   ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        FRAMENAME             NO
    ${FRAMENAME}=       Get Parameter Value             ${PARAMETER}        FRAMENAME
    ${FRAMENAME}=       Verify Parameter Value          ${FRAMENAME}        ${RUNITER}
    Run Keyword If  '${FRAMENAME}' != 'NO'              Set Test Variable   ${CHECKPARAM}         ${TRUE}
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True               Run Keyword And Return Status       Select Frame       &{ELEMENT}[${FRAMENAME}]
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Select frame browser :  ${FRAMENAME}
    ${ACTUALPASS}=      Plus Connect String     Passed, Select frame success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Select frame not success  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False     Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True      Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select Frame Browser   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select Frame Browser   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB MAXIMIZE BROWSER WINDOW
    [Arguments]    ${PARAMETER}        ${RUNITER}
    ${STATUS}=      Run Keyword And Return Status   Maximize Browser Window
# Write logger report function
    ${EXPECTED}=    Plus Connect String     Maximize browser window  .
    ${ACTUALPASS}=  Plus Connect String     Passed, Browser is maximize  .
    ${ACTUALFAIL}=  Plus Connect String     Failed, Browser is not maximize  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Maximize Browser Window   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Maximize Browser Window   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB WAIT UNTIL ELEMENT IS VISIBLE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${OBJECTNAME}       None
    Set Test Variable   ${TIMEOUT}          None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ELEMENTNAME         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TIMEOUT             30
    ${OBJECTNAME}=      Get Parameter Value             ${PARAMETER}        ELEMENTNAME
    ${OBJECTNAME}=      Verify Parameter Value          ${OBJECTNAME}       ${RUNITER}
    ${TIMEOUT}=         Get Parameter Value             ${PARAMETER}        TIMEOUT
    ${TIMEOUT}=         Verify Parameter Value          ${TIMEOUT}          ${RUNITER}
    Run Keyword If  '${OBJECTNAME}' != 'NO'             Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${STATUS}=           Run Keyword If  ${CHECKPARAM} == True              Run Keyword And Return Status   Wait Until Element Is Visible    &{ELEMENT}[${OBJECTNAME}]      ${TIMEOUT}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Wait until element is visible  [ ${OBJECTNAME} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Element is visible  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Element is not visible  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Wait Until Element Is Visible   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Wait Until Element Is Visible   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB INPUT TEXT
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${TEXTBOXNAME}      None
    Set Test Variable   ${VALUE}            None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TEXTBOXNAME         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE               NO
    ${TEXTBOXNAME}=     Get Parameter Value             ${PARAMETER}        TEXTBOXNAME
    ${TEXTBOXNAME}=     Verify Parameter Value          ${TEXTBOXNAME}      ${RUNITER}
    ${VALUE}=           Get Parameter Value             ${PARAMETER}        VALUE
    ${VALUE}=           Verify Parameter Value          ${VALUE}            ${RUNITER}
    Run Keyword If  '${TEXTBOXNAME}' != 'NO' and '${VALUE}' != 'NO'         Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${CHECKTEXTBOX}=    Run Keyword And Return Status   Wait Until Element Is Visible           &{ELEMENT}[${TEXTBOXNAME}]       10
    ${STATUS}=          Run Keyword If  ${CHECKTEXTBOX} == True    Run Keyword And Return Status  Input Text          &{ELEMENT}[${TEXTBOXNAME}]      ${VALUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Inupt text name :   [ ${TEXTBOXNAME} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Inupt text success value is :=  ( ${VALUE} )
    ${ACTUALFAIL}=      Plus Connect String     Failed, Inupt text not success (check parameter textbox name and value)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False or ${CHECKTEXTBOX} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True and ${CHECKTEXTBOX} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Inupt Text   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Inupt Text   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB CLICK BUTTON
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${BUTTONNAME}       None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        BUTTONNAME         NO
    ${BUTTONNAME}=      Get Parameter Value             ${PARAMETER}        BUTTONNAME
    ${BUTTONNAME}=      Verify Parameter Value          ${BUTTONNAME}       ${RUNITER}
    Run Keyword If  '${BUTTONNAME}' != 'NO'             Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${CHECKBUTTON}=     Run Keyword And Return Status   Wait Until Element Is Visible           &{ELEMENT}[${BUTTONNAME}]       10
    ${STATUS}=          Run Keyword If  ${CHECKBUTTON} == True   Run Keyword And Return Status   Click Element   &{ELEMENT}[${BUTTONNAME}]
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Click button :  [ ${BUTTONNAME} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Inupt button success :  [ ${BUTTONNAME} ]
    ${ACTUALFAIL}=      Plus Connect String     Failed, Inupt button not success (check parameter button name)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False or ${CHECKBUTTON} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True and ${CHECKBUTTON} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Click Button   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Click Button   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB CLICK LINK
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${LINKNAME}         None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        LINKNAME         NO
    ${LINKNAME}=        Get Parameter Value             ${PARAMETER}        LINKNAME
    ${LINKNAME}=        Verify Parameter Value          ${LINKNAME}         ${RUNITER}
    Run Keyword If  '${LINKNAME}' != 'NO'               Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True   Run Keyword And Return Status   Click Link   &{ELEMENT}[${LINKNAME}]
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Click link :  [ ${LINKNAME} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Click link success :  [ ${LINKNAME} ]
    ${ACTUALFAIL}=      Plus Connect String     Failed, Click link not success (check parameter link name)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Click Link   ${EXPECTED}   ${ACTUALPASS}    PASSED     ${INDEXSHOT}     ${INDEXLOGFILE}
   ...          ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Click Link   ${EXPECTED}   ${ACTUALFAIL}    FAILED     ${INDEXSHOT}     ${INDEXLOGFILE}

RAT WEB CLICK IMAGE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${IMAGENAME}        None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        IMAGENAME         NO
    ${IMAGENAME}=       Get Parameter Value             ${PARAMETER}        IMAGENAME
    ${IMAGENAME}=       Verify Parameter Value          ${IMAGENAME}        ${RUNITER}
    Run Keyword If  '${IMAGENAME}' != 'NO'              Set Test Variable   ${CHECKPARAM}     ${TRUE}
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True  Run Keyword And Return Status  Click Image   &{ELEMENT}[${IMAGENAME}]
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Click image :  [ ${IMAGENAME} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Click image success :  [ ${IMAGENAME} ]
    ${ACTUALFAIL}=      Plus Connect String     Failed, Click image not success (check parameter image name)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Click Image   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Click Image   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB CLICK ELEMENT
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${ELEMNAME}         None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ELEMENTNAME         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        INDEX               0
    ${ELEMNAME}=        Get Parameter Value             ${PARAMETER}        ELEMENTNAME
    ${ELEMNAME}=        Verify Parameter Value          ${ELEMNAME}         ${RUNITER}
    ${INDEX}=           Get Parameter Value             ${PARAMETER}        INDEX
    ${INDEX}=           Verify Parameter Value          ${INDEX}            ${RUNITER}
    Run Keyword If      '${ELEMNAME}' != 'NO'           Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${XPATHCOUNT}       Run Keyword If  ${CHECKPARAM} == True       Replace Empty String        &{ELEMENT}[${ELEMNAME}]         xpath=
    ${COUNTOBJ}=        Run Keyword If  ${CHECKPARAM} == True       Get Matching Xpath Count    ${XPATHCOUNT}
    ${STATUS}=          Run Keyword If   ${COUNTOBJ} > 1 and ${INDEX} != 0      Run Keyword And Return Status   Click Element   xpath=(${XPATHCOUNT})[${INDEX}]
    ...     ELSE        Run Keyword And Return Status   Click Element   &{ELEMENT}[${ELEMNAME}]
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Click element :  [ ${ELEMNAME} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Click element success :  [ ${ELEMNAME} ]
    ${ACTUALFAIL}=      Plus Connect String     Failed, Click element not success (check parameter element name)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Click Element   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Click Element   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB SELECT CHECKBOX
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${CHECKBOXNAME}     None
    Set Test Variable   ${VALUE}            None
    Set Test Variable   ${GETVALUE}         None
    Set Test Variable   ${STATUS}           ${FALSE}
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        CHECKBOXNAME        NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE               ON
    ${CHECKBOXNAME}=    Get Parameter Value             ${PARAMETER}        CHECKBOXNAME
    ${CHECKBOXNAME}=    Verify Parameter Value          ${CHECKBOXNAME}     ${RUNITER}
    ${VALUE}=           Get Parameter Value             ${PARAMETER}        VALUE
    ${VALUE}=           Verify Parameter Value          ${VALUE}            ${RUNITER}
    Run Keyword If  '${CHECKBOXNAME}' != 'NO'           Set Test Variable   ${CHECKPARAM}       ${TRUE}
    Run Keyword If  ${CHECKPARAM} == True and '${VALUE}' == 'ON'            Select Checkbox     &{ELEMENT}[${CHECKBOXNAME}]
    Run Keyword If  ${CHECKPARAM} == True and '${VALUE}' == 'OFF'           Unselect Checkbox   &{ELEMENT}[${CHECKBOXNAME}]
    ${STATUS}=          Run Keyword If  '${VALUE}' == 'ON'     Checkbox Should Be Selected      &{ELEMENT}[${CHECKBOXNAME}]
    ...                 ELSE IF  '${VALUE}' == 'OFF'           Checkbox Should Not Be Selected  &{ELEMENT}[${CHECKBOXNAME}]
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Select checkbox :  [ ${CHECKBOXNAME} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Select checkbox success value : [ ${VALUE} ]
    ${ACTUALFAIL}=      Plus Connect String     Failed, Select checkbox not success value (check parameter checkbox name or value)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select Checkbox   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select Checkbox   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB SELECT RADIO BUTTON
#Edit by wimow : 03/02/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${RADIONAME}        None
    Set Test Variable   ${VALUE}            None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        RADIONAME       NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE           NO
    ${RADIONAME}=       Get Parameter Value             ${PARAMETER}        RADIONAME
    ${RADIONAME}=       Verify Parameter Value          ${RADIONAME}        ${RUNITER}
    ${VALUE}=           Get Parameter Value             ${PARAMETER}        VALUE
    ${VALUE}=           Verify Parameter Value          ${VALUE}            ${RUNITER}
    Run Keyword If  '${RADIONAME}' != 'NO' and '${VALUE}' != 'NO'           Set Test Variable       ${CHECKPARAM}       ${TRUE}
    Run Keyword If  ${CHECKPARAM} == True               Radio Mapper        &{ELEMENT}[${RADIONAME}]                    ${VALUE}
    ${RadioName}=       Run Keyword If  ${CHECKPARAM} == True               Replace Empty String    &{ELEMENT}[${RADIONAME}]            xpath=//input[@name=
    ${RadioName}=       Run Keyword If  ${CHECKPARAM} == True               Replace Empty String    ${RadioName}        ]
    ${RadioName}=       Run Keyword If  ${CHECKPARAM} == True               Replace Empty String    ${RadioName}        '
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True   Run Keyword And Return Status     Select Radio Button   ${RadioName}    value=${VALUE}
    # Log debug for dev function
    Log                 RADIONAME= ${RADIONAME} | VALUE= ${VALUE} >>> SELECT RADIO BUTTON := ${STATUS}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Select radio :  [ ${RADIONAME} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Select Radio success value : [ ${VALUE} ]
    ${ACTUALFAIL}=      Plus Connect String     Failed, Select Radio not success (check parameter radio name or value)
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Select Radio   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Select Radio   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RADIO MAPPER
#Create by wimow : 03/02/2017
    [Arguments]    ${GROUPRADIO}        ${VALUE}
    ${RADIO}=      Replace Empty String    ${GROUPRADIO}     '
    Run Keyword If   '${RADIO}' == 'xpath=//input[@name=radio]' and '${VALUE}' == 'SelectSubscriber'      Set Test Variable   ${VALUE}            subId
    Run Keyword If   '${RADIO}' == 'xpath=//input[@name=radio]' and '${VALUE}' == 'AdditionalID'          Set Test Variable   ${VALUE}            addId

RAT WEB SWITCH BROWSER
    [Arguments]    ${PARAMETER}     ${RUNITER}
    Set Test Variable   ${ALIAS}        None
    Set Test Variable   ${CHECKPARAM}   ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ALIAS           NO
    ${ALIAS}=           Get Parameter Value             ${PARAMETER}        ALIAS
    ${ALIAS}=           Verify Parameter Value          ${ALIAS}            ${RUNITER}
    Run Keyword If  '${ALIAS}' != 'NO'                  Set Test Variable   ${CHECKPARAM}   ${TRUE}
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True  Run Keyword And Return Status   Switch Browser      ${ALIAS}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Switch browser alis name :  [ ${ALIAS} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Switch browser success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Switch browser not success alis (check parameter alis)  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Switch Browser   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Switch Browser   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB SELECT LIST
    [Arguments]         ${PARAMETER}    ${RUNITER}
    Set Test Variable   ${STATUS}           False
    Set Test Variable   ${LISTNAME}         None
    Set Test Variable   ${INDEX}            None
    Set Test Variable   ${VALUE}            None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        LISTNAME        NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        INDEX           NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE           NO
    ${LISTNAME}=        Get Parameter Value             ${PARAMETER}        LISTNAME
    ${LISTNAME}=        Verify Parameter Value          ${LISTNAME}         ${RUNITER}
    ${INDEX}=           Get Parameter Value             ${PARAMETER}        INDEX
    ${INDEX}=           Verify Parameter Value          ${INDEX}            ${RUNITER}
    ${VALUE}=           Get Parameter Value             ${PARAMETER}        VALUE
    ${VALUE}=           Verify Parameter Value          ${VALUE}            ${RUNITER}
    Run Keyword If  '${LISTNAME}' != 'NO' and '${VALUE}' != 'NO'            Set Test Variable       ${CHECKPARAM}       ${TRUE}
    ...         ELSE IF  '${LISTNAME}' != 'NO' and '${INDEX}' != 'NO'       Set Test Variable       ${CHECKPARAM}       ${TRUE}
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True and '${INDEX}' == 'NO'    Run Keyword And Return Status   Select From List By Value   &{ELEMENT}[${RADIONAME}]        ${VALUE}
    ...         ELSE IF  ${CHECKPARAM} == True and '${VALUE}' == 'NO'       Run Keyword And Return Status   Select From List By Index      &{ELEMENT}[${RADIONAME}]        ${INDEX}
# Write logger report function
    ${EXPECTED}=    Plus Connect String     Select list on :  [ ${LISTNAME} ]
    ${ACTUALPASS}=  Run Keyword If  ${CHECKPARAM} == True and '${INDEX}' == 'NO'    Plus Connect String     Passed, Select list value [ ${VALUE} ] is success  .
    ...         ELSE IF  ${CHECKPARAM} == True and '${VALUE}' == 'NO'       Plus Connect String     Passed, Select list index [ ${INDEX} ] is success  .
    ${ACTUALFAIL}=  Plus Connect String     Failed, Select list not success (check parameter list name and value or index)  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select List   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE      Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select List   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB GET LIST VALUE
    [Arguments]    ${PARAMETER}     ${RUNITER}
    Set Test Variable   ${LISTNAME}         None
    Set Test Variable   ${GETVALUE}         None
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        LISTNAME        NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO        NO
    ${LISTNAME}=        Get Parameter Value             ${PARAMETER}        LISTNAME
    ${LISTNAME}=        Verify Parameter Value          ${LISTNAME}         ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${LISTNAME}' != 'NO' and '${ASSIGNTO}' != 'NO'         Set Test Variable           ${CHECKPARAM}               ${TRUE}
    ${GETVALUE}=        Run Keyword If  ${CHECKPARAM} == True               Get Selected List value     &{ELEMENT}[${LISTNAME}]
    ${STATUS}=          Verify None Parameter Value     ${GETVALUE}
    Run Keyword If      ${STATUS} == True      Add Dictionary Assignment      ${ASSIGNTO}      ${GETVALUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get selected list :  [ ${LISTNAME} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Get list value is success :  [ ${GETVALUE} ]
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get list value is not success (check parameter list name and assign to)  .
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}    False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get List Value   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get List Value   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB GET TEXTBOX VALUE
    [Arguments]         ${PARAMETER}    ${RUNITER}
    Set Test Variable   ${TEXTBOXNAME}      None
    Set Test Variable   ${GETVALUE}         None
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TEXTBOXNAME         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO            NO
    ${TEXTBOXNAME}=     Get Parameter Value             ${PARAMETER}        TEXTBOXNAME
    ${TEXTBOXNAME}=     Verify Parameter Value          ${TEXTBOXNAME}      ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If      '${TEXTBOXNAME}' != 'NO' and '${ASSIGNTO}' != 'NO'  Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${GETVALUE}=        Run Keyword If  ${CHECKPARAM} == True   Get Value   &{ELEMENT}[${TEXTBOXNAME}]
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True   Verify None Parameter Value     ${GETVALUE}
    Run Keyword If      ${STATUS} == True      Add Dictionary Assignment    ${ASSIGNTO}         ${GETVALUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get textbox :  [ ${TEXTBOXNAME} ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Get textbox value is success :  [ ${GETVALUE} ]
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get textbox value is not success (check parameter textbox name and assign to)  .
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False        Set Global Variable     ${FLAGRUNRESULT}    False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True         Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get Textbox Value   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get Textbox Value   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB GET ELEMENT TEXT
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${STATUS}           False
    Set Test Variable   ${ELEMENTNAME}      None
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ELEMENTNAME         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO            NO
    ${ELEMENTNAME}=     Get Parameter Value             ${PARAMETER}        ELEMENTNAME
    ${ELEMENTNAME}=     Verify Parameter Value          ${ELEMENTNAME}      ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${ELEMENTNAME}' != 'NO' and '${ASSIGNTO}' != 'NO'      Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${CHECLELEMENT}=    Run Keyword If  ${CHECKPARAM} == True       Run Keyword And Return Status   Wait Until Element Is Visible   &{ELEMENT}[${ELEMENTNAME}]      10
    ${TXTVALUE}=        Run Keyword If  ${CHECLELEMENT} == True             Get Text            &{ELEMENT}[${ELEMENTNAME}]
    ${TXTVALUE}=        Run Keyword If  ${CHECLELEMENT} == True             Convert To String   ${TXTVALUE}
    ${STATUS}=          Run Keyword If  ${CHECLELEMENT} == True     Run Keyword And Return Status   Add Dictionary Assignment     ${ASSIGNTO}    ${TXTVALUE}
# Write logger report function
    ${EXPECTED}=    Plus Connect String     Get element :  [ ${ELEMENTNAME} ]
    ${ACTUALPASS}=  Plus Connect String     Passed, Get element text is success :  [ ${TXTVALUE} ]
    ${ACTUALFAIL}=  Plus Connect String     Failed, Get element text is not success (check parameter element name and assign to)  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False or ${CHECLELEMENT} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True and ${CHECLELEMENT} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get Element Text   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get Element Text   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB CAPTURE PAGE SCREENSHOT
# Create by Jay 31-01-2017
# Modify by Jay 01-02-2017 [Insert Default Path for Capture]
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${FILEPATH}     None
    Set Test Variable   ${FILENAME}     None
    ${PARAMETER}=       Additional Parameter Value          ${PARAMETER}        FILEPATH            NO
    ${FILEPATH}=        Get Parameter Value                 ${PARAMETER}        FILEPATH
    Run Keyword If  '${FILEPATH}' != 'NO'                   Set Test Variable   ${IMAGEPATH}        ${FILEPATH}${/}${REPORTID}
    ${FILENAME}=        Run Keyword If  '${FILEPATH}' != 'NO'   Create File Name With Index         ${IMAGEPATH}    Screenshot      png
    ${STATUS}=          Run Keyword If  '${FILEPATH}' != 'NO'   Run Keyword And Return Status       Capture Page screenshot         ${IMAGEPATH}${/}${FILENAME}.png
    ${PARAMCAP}=        Run Keyword If  '${FILEPATH}' == 'NO'   Additional Parameter Value          ${PARAMETER}    CAPTURE         True
    Run Keyword If  '${FILEPATH}' == 'NO'       Set Test Variable       ${STATUS}       ${TRUE}
# Write logger report function
    ${EXPECTED}=        Run Keyword If  '${FILEPATH}' != 'NO'   Plus Connect String     Capture page screenshot to :  [ ${IMAGEPATH}${/}${FILENAME}.png ]
    ...         ELSE    Plus Connect String     Capture page screenshot to :  [ log img ${INDEXSHOT}.png ]
    ${ACTUALPASS}=      Plus Connect String     Passed, Capture page screenshot is success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Capture page screenshot is not success  .
    Run Keyword If  '${FILEPATH}' == 'NO'       LOG IMAGE   ${PARAMCAP}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Capture Page Screenshot   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Capture Page Screenshot   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB SELECT WINDOW
#Create by Chayut : 03/02/2017
    [Arguments]         ${PARAMETER}            ${RUNITER}
    Set Test Variable   ${URL}                  None
    Set Test Variable   ${TITLE}                None
    Set Test Variable   ${NAME}                 None
    Set Test Variable   ${CHECKPARAM}           ${TRUE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        URL         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TITLE       NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        NAME        NO
    ${URL}=             Get Parameter Value             ${PARAMETER}        URL
    ${URL}=             Verify Parameter Value          ${URL}              ${RUNITER}
    ${TITLE}=           Get Parameter Value             ${PARAMETER}        TITLE
    ${TITLE}=           Verify Parameter Value          ${TITLE}            ${RUNITER}
    ${NAME}=            Get Parameter Value             ${PARAMETER}        NAME
    ${NAME}=            Verify Parameter Value          ${NAME}             ${RUNITER}
    Run Keyword If  '${URL}' == 'NO' and '${TITLE}' == 'NO' and '${NAME}' == 'NO'       Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${STATUS}=  Run Keyword If  ${CHECKPARAM} == True and '${URL}' != 'NO'  Run Keyword And Return Status   Select Window       ${URL}
    ...         ELSE IF  ${CHECKPARAM} == True and '${TITLE}' != 'NO'       Run Keyword And Return Status   Select Window       ${TITLE}
    ...         ELSE IF  ${CHECKPARAM} == True and '${NAME}' != 'NO'        Run Keyword And Return Status   Select Window       ${NAME}
# Write logger report function
    ${EXPECTED}=        Run Keyword If  '${URL}' != 'NO'    Plus Connect String     Select window property URL :  ${URL}
    ...         ELSE IF  '${TITLE}' != 'NO'     Plus Connect String         Select window property TITLE :  ${TITLE}
    ...         ELSE IF  '${NAME}' != 'NO'      Plus Connect String         Select window property NAME :  ${NAME}
    ${ACTUALPASS}=      Plus Connect String     Passed, Select window success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Select window not success (check parameter URL or Title or Name)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select Window   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select Window   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB CLOSE WINDOW
#Create by Chayut : 03/02/2017
    [Arguments]     ${PARAMETER}    ${RUNITER}
    ${STATUS}=      Run Keyword And Return Status   Close Window
# Write logger report function
    ${EXPECTED}=    Plus Connect String     Close window  .
    ${ACTUALPASS}=  Plus Connect String     Passed, Close window success  .
    ${ACTUALFAIL}=  Plus Connect String     Failed, Close window not success  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Close Window   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...     ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Close Window   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}
