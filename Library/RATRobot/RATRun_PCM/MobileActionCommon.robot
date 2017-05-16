*** Settings ***
Library          D:\\RATFramework\\Library\\RATLibrary
Library          AppiumLibrary     run_on_failure=Nothing

*** Keywords ***
RAT MOBILE START APPIUM SERVER
    [Arguments]    ${PARAMETER}         ${RUNITER}
    Set Test Variable   ${TESTDEVICE}   None
    Set Test Variable   ${PORT1}        None
    Set Test Variable   ${PORT2}        None
    Set Test Variable   ${DEVICEID1}    None
    Set Test Variable   ${DEVICEID2}    None
    Set Test Variable   ${CHECKPARAM}   ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TESTDEVICE          SINGLE
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        PORT1               NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        PORT2               NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        DEVICEID1           NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        DEVICEID2           NO
    ${TESTDEVICE}=      Get Parameter Value             ${PARAMETER}        TESTDEVICE
    ${TESTDEVICE}=      Verify Parameter Value          ${TESTDEVICE}       ${RUNITER}
    ${PORT1}=           Get Parameter Value             ${PARAMETER}        PORT1
    ${PORT1}=           Verify Parameter Value          ${PORT1}            ${RUNITER}
    ${PORT2}=           Get Parameter Value             ${PARAMETER}        PORT2
    ${PORT2}=           Verify Parameter Value          ${PORT2}            ${RUNITER}
    ${DEVICEID1}=       Get Parameter Value             ${PARAMETER}        DEVICEID1
    ${DEVICEID1}=       Verify Parameter Value          ${DEVICEID1}       ${RUNITER}
    ${DEVICEID2}=       Get Parameter Value             ${PARAMETER}        DEVICEID2
    ${DEVICEID2}=       Verify Parameter Value          ${DEVICEID2}       ${RUNITER}
    ${TESTDEVICE}=      Convert To Uppercase            ${TESTDEVICE}
    Run Keyword If  '${TESTDEVICE}' == 'SINGLE'         Set Test Variable   ${CHECKPARAM}       ${TRUE}
    Run Keyword If  '${TESTDEVICE}' == 'MULTI' and '${PORT1}' != 'NO' and '${PORT2}' != 'NO' and '${DEVICEID1}' != 'NO' and '${DEVICEID2}' != 'NO'      Set Test Variable   ${CHECKPARAM}       ${TRUE}
    Run Keyword If   ${CHECKPARAM} == True              Stop Appium Server
    Run Keyword If   ${CHECKPARAM} == True              Sleep   2s
    ${STATUS}=          Run Keyword If   ${CHECKPARAM} == True and '${TESTDEVICE}' == 'SINGLE'      Run Keyword and Return Status        Start Appium Server Default
    ...                 ELSE IF  ${CHECKPARAM} == True and '${TESTDEVICE}' == 'MULTI'               Run Keyword and Return Status        Start Appium Server Multidevice    ${PORT1}    ${PORT2}    ${DEVICEID1}    ${DEVICEID2}
    Run Keyword If   ${CHECKPARAM} == True              Sleep   15s
# Write logger report function
    ${EXPECTED}=    Plus Connect String     Start appium server  .
    ${ACTUALPASS}=  Run Keyword If  '${TESTDEVICE}' == 'SINGLE'      Plus Connect String     Passed, Start appium server test with single device  .
    ...             ELSE IF         '${TESTDEVICE}' == 'MULTI'       Plus Connect String     Passed, Start appium server test with multi device  .
    ${ACTUALFAIL}=  Plus Connect String     Failed, Can not start appium server   (check appium install on machine or parameter)
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Start Appium Server   ${EXPECTED}   ${ACTUALPASS}    PASSED     None       ${INDEXLOGFILE}
    ...         ELSE                        Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Start Appium Server   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE STOP APPIUM SERVER
    [Arguments]    ${PARAMETER}         ${RUNITER}
    ${STATUS}=     Run Keyword and Return Status       Stop Appium Server
    Sleep   2s
# Write logger report function
    ${EXPECTED}=    Plus Connect String     Stop appium server  .
    ${ACTUALPASS}=  Plus Connect String     Passed, Stop appium server success  .
    ${ACTUALFAIL}=  Plus Connect String     Failed, Stop appium server not success  .
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Stop Appium Server   ${EXPECTED}   ${ACTUALPASS}    PASSED     None      ${INDEXLOGFILE}
    ...         ELSE                        Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Stop Appium Server   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE OPEN APPLICATION
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${HOSTAPPIUM}       None
    Set Test Variable   ${PLATFORMNAME}     None
    Set Test Variable   ${PLATFORMVERSION}  None
    Set Test Variable   ${DEVICE}           None
    Set Test Variable   ${PACKAGE}          None
    Set Test Variable   ${ACTIVITY}         None
    Set Test Variable   ${ALIAS}            None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=        Additional Parameter Value     ${PARAMETER}        APPIUMSERVER        NO
    ${PARAMETER}=        Additional Parameter Value     ${PARAMETER}        PLATFORMNAME        NO
    ${PARAMETER}=        Additional Parameter Value     ${PARAMETER}        PLATFORMVERSION     NO
    ${PARAMETER}=        Additional Parameter Value     ${PARAMETER}        DEVICENAME          NO
    ${PARAMETER}=        Additional Parameter Value     ${PARAMETER}        PACKAGE             NO
    ${PARAMETER}=        Additional Parameter Value     ${PARAMETER}        LANUCHACTIVITY      NO
    ${PARAMETER}=        Additional Parameter Value     ${PARAMETER}        ALIAS               DEVICE1
    ${HOSTAPPIUM}=       Get Parameter Value            ${PARAMETER}        APPIUMSERVER
    ${HOSTAPPIUM}=       Verify Parameter Value         ${HOSTAPPIUM}       ${RUNITER}
    ${PLATFORMNAME}=     Get Parameter Value            ${PARAMETER}        PLATFORMNAME
    ${PLATFORMNAME}=     Verify Parameter Value         ${PLATFORMNAME}     ${RUNITER}
    ${PLATFORMVERSION}=  Get Parameter Value            ${PARAMETER}        PLATFORMVERSION
    ${PLATFORMVERSION}=  Verify Parameter Value         ${PLATFORMVERSION}  ${RUNITER}
    ${DEVICE}=           Get Parameter Value            ${PARAMETER}        DEVICENAME
    ${DEVICE}=           Verify Parameter Value         ${DEVICE}           ${RUNITER}
    ${PACKAGE}=          Get Parameter Value            ${PARAMETER}        PACKAGE
    ${PACKAGE}=          Verify Parameter Value         ${PACKAGE}          ${RUNITER}
    ${ACTIVITY}=         Get Parameter Value            ${PARAMETER}        LANUCHACTIVITY
    ${ACTIVITY}=         Verify Parameter Value         ${ACTIVITY}         ${RUNITER}
    ${ALIAS}=            Get Parameter Value            ${PARAMETER}        ALIAS
    ${ALIAS}=            Verify Parameter Value         ${ALIAS}            ${RUNITER}
    Run Keyword If  '${HOSTAPPIUM}' != 'NO' and '${PLATFORMNAME}' != 'NO' and '${PLATFORMVERSION}' != 'NO' and '${DEVICE}' != 'NO' and '${PACKAGE}' != 'NO' and '${ACTIVITY}' != 'NO'       Set Test Variable       ${CHECKPARAM}       ${TRUE}
    ${STATUS}=          Run Keyword And Return Status   Open Application    ${HOSTAPPIUM}   ${ALIAS}    platformName=${PLATFORMNAME}     platformVersion=${PLATFORMVERSION}      deviceName=${DEVICE}       appPackage=${PACKAGE}      appActivity=${ACTIVITY}      newCommandTimeout=10000
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Open Application :  ${PACKAGE}
    ${ACTUALPASS}=      Plus Connect String     Passed, Can open application :  ${PACKAGE}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Can not open application :  ${PACKAGE}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False     Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True      Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Open Application  ${EXPECTED}   ${ACTUALPASS}    PASSED     None       ${INDEXLOGFILE}
    ...         ELSE      Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Open Application   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE CLOSE APPLICATION
    [Arguments]    ${PARAMETER}        ${RUNITER}
    ${STATUS}=          Run Keyword And Return Status   Close Application
    Sleep   2s
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Close application  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Can close application  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Can not close application  .
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Close Application   ${EXPECTED}   ${ACTUALPASS}    PASSED     None      ${INDEXLOGFILE}
    ...         ELSE                        Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Close Application   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE CLOSE ALL APPLICATIONS
    [Arguments]    ${PARAMETER}         ${RUNITER}
    ${STATUS}=     Run Keyword and Return Status       Close All Applications
    Sleep   2s
# Write logger report function
    ${EXPECTED}=    Plus Connect String     Close All Applications  .
    ${ACTUALPASS}=  Plus Connect String     Passed, Close all applications success  .
    ${ACTUALFAIL}=  Plus Connect String     Failed, Close all applications not success  .
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Close All Applications   ${EXPECTED}   ${ACTUALPASS}    PASSED     None      ${INDEXLOGFILE}
    ...         ELSE                        Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Close All Applications   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE WAIT TIME
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${WAIT}             None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TIME        NO
    ${WAIT}=            Get Parameter Value             ${PARAMETER}        TIME
    ${WAIT}=            Verify Parameter Value          ${WAIT}             ${RUNITER}
    Run Keyword If  '${WAIT}' != 'NO'       Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True   Run Keyword And Return Status       Sleep       ${WAIT}s
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Wait time  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Application waiting success  (time ${WAIT}s)
    ${ACTUALFAIL}=      Plus Connect String     Failed, Application waiting not success  (check parameter time)
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Wait time  ${EXPECTED}   ${ACTUALPASS}    PASSED     None       ${INDEXLOGFILE}
    ...         ELSE       Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Wait time   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE WAIT UNTIL ELEMENT IS VISIBLE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${ELEMENTNAME}      None
    Set Test Variable   ${TIMEOUT}          None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ELEMENTNAME         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TIMEOUT             30
    ${ELEMENTNAME}=     Get Parameter Value             ${PARAMETER}        ELEMENTNAME
    ${ELEMENTNAME}=     Verify Parameter Value          ${ELEMENTNAME}      ${RUNITER}
    ${TIMEOUT}=         Get Parameter Value             ${PARAMETER}        TIMEOUT
    ${TIMEOUT}=         Verify Parameter Value          ${TIMEOUT}          ${RUNITER}
    Run Keyword If  '${ELEMENTNAME}' != 'NO'            Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} != True               Run Keyword And Return Status       Mobile Wait Until Element Is Visible    &{ELEMENT}[${ELEMENTNAME}]      ${TIMEOUT}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Wait until element is visible .
    ${ACTUALPASS}=      Plus Connect String     Passed, Element is name ${ELEMENTNAME} visible  (timeout : ${TIMEOUT})
    ${ACTUALFAIL}=      Plus Connect String     Failed, Element is name ${ELEMENTNAME} not visible  (timeout : ${TIMEOUT})
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True       Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Wait until element is visible  ${EXPECTED}   ${ACTUALPASS}    PASSED     None       ${INDEXLOGFILE}
    ...         ELSE      Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Wait until element is visible  ${EXPECTED}   ${ACTUALFAIL}    FAILED     None       ${INDEXLOGFILE}

RAT MOBILE CLICK BUTTON
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${BUTTONNAME}       None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        BUTTONNAME         NO
    ${BUTTONNAME}=      Get Parameter Value             ${PARAMETER}        BUTTONNAME
    ${BUTTONNAME}=      Verify Parameter Value          ${BUTTONNAME}       ${RUNITER}
    Run Keyword If  '${BUTTONNAME}' != 'NO'             Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${CHECKBUTTON}=     Run Keyword If  ${CHECKPARAM} == True      Run Keyword And Return Status           Mobile Wait Until Element Is Visible            &{ELEMENT}[${BUTTONNAME}]       20
    ${STATUS}=          Run Keyword If  ${CHECKBUTTON} == True     Run Keyword And Return Status           Mobile Click Element                            &{ELEMENT}[${BUTTONNAME}]
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Click button :                    ${BUTTONNAME}
    ${ACTUALPASS}=      Plus Connect String     Passed, Click button success      ${BUTTONNAME}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Click button not success  (check element keyword : ${BUTTONNAME})
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False     Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True      Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Click Button   ${EXPECTED}   ${ACTUALPASS}    PASSED     None      ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Click Button   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE INPUT TEXT
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
    Run Keyword If  '${TEXTBOXNAME}' != 'NO' and '${VALUE}' != 'NO'         Set Test Variable   ${CHECKPARAM}         ${TRUE}
    ${CHECKINPUT}=      Run Keyword If  ${CHECKPARAM} == True               Mobile Wait Until Element Is Visible      &{ELEMENT}[${TEXTBOXNAME}]       20
    ${STATUS}=          Run Keyword If  ${CHECKINPUT} == True               Run Keyword And Return Status             Mobile Input Text                &{ELEMENT}[${TEXTBOXNAME}]                       ${VALUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Inupt text  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Inupt text on textbox name : ${TEXTBOXNAME} value : ${VALUE}  is success
    ${ACTUALFAIL}=      Plus Connect String     Failed, Inupt text not success value :          (check parameter textbox name and value)
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True       Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Inupt text   ${EXPECTED}   ${ACTUALPASS}    PASSED        None        ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Inupt text   ${EXPECTED}   ${ACTUALFAIL}    FAILED       None         ${INDEXLOGFILE}

RAT MOBILE ANSWER THE PHONE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Sleep       5s
    ${CHECKDOWNV6}=     Run Keyword And Return Status               Wait Activity        InCallScreen           8
    ${CHECKUPV6}=       Run Keyword If  ${CHECKDOWNV6} == False     Wait Activity        InCallActivity         8
    ${STATUS}=          Run Keyword If  ${CHECKDOWNV6} == True or ${CHECKUPV6} == True   Run Keyword And Return Status      Press Keycode       5
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Answer the phone  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Answer the phone success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Answer the phone not success  .
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Answer the phone   ${EXPECTED}   ${ACTUALPASS}    PASSED     None      ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Answer the phone   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE HANG UP THE PHONE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${HANGUP}      ${FALSE}
    ${CHECKDOWNV6}=     Run Keyword And Return Status               Wait Activity        InCallScreen           8
    ${CHECKUPV6}=       Run Keyword If  ${CHECKDOWNV6} == False     Wait Activity        InCallActivity         8
    ${STATUS}=          Run Keyword If  ${CHECKDOWNV6} == True or ${CHECKUPV6} == True   Run Keyword And Return Status      Press Keycode        6
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Hang up the phone         ${VALNON}
    ${ACTUALPASS}=      Plus Connect String     Passed, Hang up the phone the phone success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Hang up the phone the phone not success  .
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Hang up the phone  ${EXPECTED}   ${ACTUALPASS}    PASSED     None       ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Hang up the phone   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE CALL THE PHONE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${MOBILENO}         None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        MOBILENO         NO
    ${MOBILENO}=        Get Parameter Value             ${PARAMETER}        MOBILENO
    ${MOBILENO}=        Verify Parameter Value          ${MOBILENO}         ${RUNITER}
    Run Keyword If      '${MOBILENO}' != 'NO'           Set Test Variable   ${CHECKPARAM}    ${TRUE}
    ${STATUSAPP}=       Run Keyword And Return Status   Start Activity      appPackage=com.android.contacts     appActivity=com.android.contacts.DialtactsActivity
    ${STATUSTAB}=       Run Keyword And Return Status   Mobile Wait Until Element Is Visible                    id=com.android.contacts:id/tab_custom_view_icon         10
    Run Keyword If  ${STATUSAPP} == True and ${STATUSTAB} == True           Mobile Click Element                id=com.android.contacts:id/tab_custom_view_icon
    ${STATUSDEL}=       Run Keyword And Return Status   Mobile Wait Until Element Is Visible                    id=com.android.contacts:id/deleteButton                 10
    ${STATUSPRESS}=     Run Keyword If  ${STATUSDEL} == True                Run Keyword And Return Status       Long Press                                              id=com.android.contacts:id/deleteButton
    Run Keyword If  ${STATUSPRESS} == True              Mobile Input Text   id=com.android.contacts:id/digits   ${MOBILENO}
    ${CHECKCALLDOWNV6}=  Run Keyword And Return Status  Mobile Wait Until Element Is Visible                    id=com.android.contacts:id/callbutton                   5
    ${CHECKCALLUPV6}=   Run Keyword And Return Status   Mobile Wait Until Element Is Visible                    id=com.android.contacts:id/dialButton                   5
    Run Keyword If  ${CHECKCALLDOWNV6} == True          Mobile Click Element       id=com.android.contacts:id/callbutton
    Run Keyword If  ${CHECKCALLUPV6} == True            Mobile Click Element       id=com.android.contacts:id/dialButton
    Run Keyword If  ${CHECKCALLDOWNV6} == True          Wait Activity              InCallScreen                 10
    Run Keyword If  ${CHECKCALLDOWNV6} == False and ${CHECKCALLUPV6} == False      Set Test Variable            ${STATUS}         ${FALSE}
    ...         ELSE    Set Test Variable          ${STATUS}      ${TRUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Call the phone no :  ${MOBILENO}
    ${ACTUALPASS}=      Plus Connect String     Passed, Call the phone success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Call the phone not success  (check parameter mobileno).
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False     Set Global Variable     ${FLAGRUNRESULT}       False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True      Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Call the phone  ${EXPECTED}   ${ACTUALPASS}    PASSED     None        ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Call the phone    ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE GET BALANCE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${ASSIGNTO}    None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO            NO
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If      '${ASSIGNTO}' != 'NO'           Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${STATUSUSSDMSG}=   Run Keyword And Return Status   Mobile Wait Until Element Is Visible    id=android:id/message   3
    ${STATUSUSSDDIA}=   Run Keyword If  ${STATUSUSSDMSG} == False           Run Keyword And Return Status               Mobile Wait Until Element Is Visible        id=com.android.phone:id/dialog_message     3
    ${USSD}=            Run Keyword If  ${STATUSUSSDMSG} == True            Mobile Get Text                             id=android:id/message
    ...                 ELSE IF         ${STATUSUSSDDIA} == True            Mobile Get Text                             id=com.android.phone:id/dialog_message
    ${USSD}=            Convert To String    ${USSD}
    Log                 USSD >>>>> ${USSD}
    ${BALANCE}=         Get Money Balance    ${USSD}
    ${BALANCE}=         Convert To String    ${BALANCE}
    ${STATUS}=          Run Keyword And Return Status     Add Dictionary Assignment     ${ASSIGNTO}         ${BALANCE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get Balance and assing value :   ${ASSIGNTO}
    ${ACTUALPASS}=      Plus Connect String     Passed, Get balance success  (your balance : ${BALANCE})
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get balance not success  (check parameter assignto or USSD network).
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Get balance  ${EXPECTED}   ${ACTUALPASS}    PASSED     None        ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Get balance   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE GET VALIDITY
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${ASSIGNTO}    None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO            NO
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If      '${ASSIGNTO}' != 'NO'           Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${STATUSUSSDMSG}=   Run Keyword And Return Status   Mobile Wait Until Element Is Visible    id=android:id/message   3
    ${STATUSUSSDDIA}=   Run Keyword If  ${STATUSUSSDMSG} == False           Run Keyword And Return Status               Mobile Wait Until Element Is Visible        id=com.android.phone:id/dialog_message     3
    ${USSD}=            Run Keyword If  ${STATUSUSSDMSG} == True            Mobile Get Text                             id=android:id/message
    ...                 ELSE IF         ${STATUSUSSDDIA} == True            Mobile Get Text                             id=com.android.phone:id/dialog_message
    ${USSD}=            Convert To String    ${USSD}
    Log                 USSD >>>>> ${USSD}
    ${VALIDITY}=        Get Date Validity    ${USSD}
    ${VALIDITY}=        Convert To String    ${VALIDITY}
    ${STATUS}=          Run Keyword And Return Status     Add Dictionary Assignment     ${ASSIGNTO}         ${VALIDITY}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get validity and assing value :   ${ASSIGNTO}
    ${ACTUALPASS}=      Plus Connect String     Passed, Get validity success  (your validity : ${VALIDITY})
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get validity not success  (check parameter assign to or USSD network).
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Get Validity  ${EXPECTED}   ${ACTUALPASS}    PASSED     None        ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Get Validity   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE GET MOBILE NUMBER
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO            NO
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If      '${ASSIGNTO}' != 'NO'           Set Test Variable   ${CHECKPARAM}       ${TRUE}
    Sleep       5s
    ${STATUSUSSDMSG}=   Run Keyword And Return Status   Mobile Wait Until Element Is Visible    id=android:id/message   3
    ${STATUSUSSDDIA}=   Run Keyword If  ${STATUSUSSDMSG} == False           Run Keyword And Return Status               Mobile Wait Until Element Is Visible        id=com.android.phone:id/dialog_message           3
    ${GETVALUE}=        Run Keyword If  ${STATUSUSSDMSG} == True            Mobile Get Text                             id=android:id/message
    ...                 ELSE IF         ${STATUSUSSDDIA} == True            Mobile Get Text                             id=com.android.phone:id/dialog_message
    ${GETVALUE}=        Convert To String               ${GETVALUE}
    ${GETVALUE}=        Replace Ascii String            ${GETVALUE}         10
    ${MOBILENO}=        Get Mobile Number               ${GETVALUE}
    ${STATUS}=          Run Keyword And Return Status   Add Dictionary Assignment     ${ASSIGNTO}         ${MOBILENO}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get mobile number  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Get mobile number success  (your mobile number : ${MOBILENO})
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get mobile number not success    (check parameter assign to or USSD network)
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} != True       Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}     Get mobile number   ${EXPECTED}   ${ACTUALPASS}    PASSED     None       ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}     Get mobile number   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None       ${INDEXLOGFILE}

RAT MOBILE CLEAR UNREAD MESSAGE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${STATUS}      ${FALSE}
    ${STARTSMS}=            Run Keyword And Return Status           Start Activity                          appPackage=com.sec.android.app.launcher                 appActivity=com.android.launcher2.Launcher
    ${CHECKCALLDOWNV6}=     Run Keyword If  ${STARTSMS} == True     Run Keyword And Return Status           Mobile Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='Messaging']      10
    ${CHECKCALLUPV6}=       Run Keyword If  ${STARTSMS} == True     Run Keyword And Return Status           Mobile Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='Messages']       10
    Run Keyword If  ${CHECKCALLDOWNV6} == True      Mobile Click Element         xpath=//android.widget.TextView[@text='Messaging']
    Run Keyword If  ${CHECKCALLUPV6} == True        Mobile Click Element         xpath=//android.widget.TextView[@text='Messages']
    ${TITLEBAR}=            Run Keyword And Return Status           Mobile Wait Until Element Is Visible    id=android:id/action_bar_title          5
    Run Keyword If  ${TITLEBAR} == False            Press Keycode   4
    Run Keyword If  ${TITLEBAR} == False            Sleep           3s
    ${COUNT}=               Mobile Get Matching Xpath Count         //android.widget.TextView[@resource-id='com.android.mms:id/unread_count']
    :FOR  ${INDEX}   IN RANGE    1    ${COUNT} + 1
    \   ${UNREAD}=   Run Keyword And Return Status   Mobile Wait Until Element Is Visible   xpath=(//android.widget.TextView[@resource-id='com.android.mms:id/unread_count'])[${INDEX}]
    \   Run Keyword If  ${UNREAD} == True    Mobile Click Element      xpath=(//android.widget.TextView[@resource-id='com.android.mms:id/unread_count'])[${INDEX}]
    \   Run Keyword If  ${UNREAD} == True    Press Keycode   4
    ${CHECKUNREAD}=   Run Keyword And Return Status   Mobile Wait Until Element Is Visible   id=com.android.mms:id/unread_count                     3
    Run Keyword If  ${CHECKUNREAD} == False  Set Test Variable       ${STATUS}       ${TRUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Clear unread message  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Clear unread message success  (clear message total : ${COUNT})
    ${ACTUALFAIL}=      Plus Connect String     Failed, Clear unread message not success  .
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}     Clear unread message   ${EXPECTED}   ${ACTUALPASS}    PASSED     None       ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}     Clear unread message   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None       ${INDEXLOGFILE}

RAT MOBILE GET UNREAD MESSAGE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${SENDER}         None
    Set Test Variable   ${UNREAD}         None
    Set Test Variable   ${ASSIGNTO}       None
    Set Test Variable   ${AMOUNT}         None
    Set Test Variable   ${CHECKPARAM}     ${FALSE}
    Set Test Variable   ${UPDATESTRING}   ${EMPTY}
    Set Test Variable   ${FLAGCHECK}      ${TRUE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}            SENDER         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}            UNREAD         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}            ASSIGNTO       NO
    ${SENDER}=          Get Parameter Value             ${PARAMETER}     SENDER
    ${SENDER}=          Verify Parameter Value          ${SENDER}        ${RUNITER}
    ${UNREAD}=          Get Parameter Value             ${PARAMETER}     UNREAD
    ${UNREAD}=          Verify Parameter Value          ${UNREAD}        ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}     ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}      ${RUNITER}
    Run Keyword If  '${SENDER}' != 'NO' and '${UNREAD}' != 'NO' and '${ASSIGNTO}' != 'NO'       Set Test Variable   ${CHECKPARAM}     ${TRUE}
    ${STARTSMS}=         Run Keyword And Return Status   Start Activity      appPackage=com.sec.android.app.launcher      appActivity=com.android.launcher2.Launcher
    Run Keyword If  ${STARTSMS} == True    Sleep    3s
    ${CHECKCALLDOWNV6}=  Run Keyword And Return Status               Mobile Wait Until Element Is Visible        xpath=//android.widget.TextView[@text='Messaging']         5
    ${CHECKCALLUPV6}=    Run Keyword And Return Status               Mobile Wait Until Element Is Visible        xpath=//android.widget.TextView[@text='Messages']          5
    Run Keyword If  ${CHECKCALLDOWNV6} == True      Mobile Click Element         xpath=//android.widget.TextView[@text='Messaging']
    Run Keyword If  ${CHECKCALLUPV6} == True        Mobile Click Element         xpath=//android.widget.TextView[@text='Messages']
    Run Keyword If  ${CHECKCALLDOWNV6} == False and ${CHECKCALLUPV6} == False    Set Test Variable       ${FLAGCHECK}         ${FALSE}
    ${TITLEBAR}=         Run Keyword And Return Status              Mobile Wait Until Element Is Visible    id=android:id/action_bar_title      5
    Run Keyword If  ${TITLEBAR} == False          Press Keycode   4
    Sleep       3s
    ${SENDERTAG}=      Run Keyword And Return Status         Mobile Wait Until Element Is Visible        xpath=//android.widget.TextView[@text='${SENDER}']          30
    ${UNREADTAG}=      Run Keyword And Return Status         Mobile Wait Until Element Is Visible        id=com.android.mms:id/unread_count                          30
    Run Keyword If  ${UNREADTAG} == False                    Set Test Variable      ${FLAGCHECK}         ${FALSE}
    ${AMOUNT}=         Run Keyword If  ${UNREADTAG} == True  Mobile Get Text        id=com.android.mms:id/unread_count
    Run Keyword If  '${AMOUNT}' == 'None'                    Set Test Variable      ${AMOUNT}            0
    Run Keyword If  '${UNREAD}' != '${AMOUNT}'               Set Test Variable      ${AMOUNT}            0
    Run Keyword If  '${UNREAD}' != '${AMOUNT}'               Set Test Variable      ${FLAGCHECK}         ${FALSE}
    Run Keyword If  ${SENDERTAG} == True                     Mobile Click Element   xpath=//android.widget.TextView[@text='${SENDER}']
    Run Keyword If  ${FLAGCHECK} == True                     Mobile Wait Until Element Is Visible        id=com.android.mms:id/body_text_view                         20
    ${COUNT}=    Mobile Get Matching Xpath Count            //android.widget.TextView[@resource-id='com.android.mms:id/body_text_view']
    :FOR  ${ISMS}  IN RANGE  0  ${COUNT} - 1
    \   Run Keyword If  ${AMOUNT} == 0                       Exit For Loop
    \   ${UNREADSMS}=        Mobile Get Text                 xpath=(//android.widget.TextView[@resource-id='com.android.mms:id/body_text_view'])[${COUNT} - ${ISMS}]
    \   ${UPDATESTRING}=     Update Inolder String           ${UPDATESTRING}         ${UNREADSMS}         |
    \   ${IGETSMS}=          Convert to String               ${ISMS+1}
    \   Run Keyword If  ${AMOUNT} == ${IGETSMS}              Exit For Loop
    ${STATUS}=          Run Keyword And Return Status        Add Dictionary Assignment     ${ASSIGNTO}    ${UPDATESTRING}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get unread message  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Get unread message success unread amount input ${UNREAD} = indevice ${AMOUNT}  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get unread message not success  (unread input : ${UNREAD} indevice : ${AMOUNT}).
    LOG TXT FILE        ${UPDATESTRING}
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False or ${FLAGCHECK} == False     Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True and ${FLAGCHECK} == True      Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}     Get unread message   ${EXPECTED}   ${ACTUALPASS}    PASSED     None       ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get unread message   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None   ${INDEXLOGFILE}

RAT MOBILE GET USSD PACKAGE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${PACKAGE}         None
    Set Test Variable   ${PROFILE}         None
    Set Test Variable   ${ASSIGNTO}        None
    Set Test Variable   ${CHECKPARAM}      ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        PACKAGE       NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        PROFILE       NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO      NO
    ${PACKAGE}=         Get Parameter Value             ${PARAMETER}        PACKAGE
    ${PACKAGE}=         Verify Parameter Value          ${PACKAGE}          ${RUNITER}
    ${PROFILE}=         Get Parameter Value             ${PARAMETER}        PROFILE
    ${PROFILE}=         Verify Parameter Value          ${PROFILE}          ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${PACKAGE}' != 'NO' and '${PROFILE}' != 'NO' and ${ASSIGNTO}' != 'NO'      Set Test Variable       ${CHECKPARAM}      ${TRUE}
    ${STATUSUSSDMSG}=   Run Keyword And Return Status   Mobile Wait Until Element Is Visible    id=android:id/message   10
    ${STATUSUSSDDIA}=   Run Keyword If  ${STATUSUSSDMSG} == False           Run Keyword And Return Status               Mobile Wait Until Element Is Visible        id=com.android.phone:id/dialog_message           10
    ${USSD}=            Run Keyword If  ${STATUSUSSDMSG} == True            Mobile Get Text                             id=android:id/message
    ...                 ELSE IF         ${STATUSUSSDDIA} == True            Mobile Get Text                             id=com.android.phone:id/dialog_message
    ${USSD}=            Convert To String    ${USSD}
    Log                 USSD >>>>> ${USSD}
    ${KEYNO}=           Get Ussd Package                  ${PROFILE}        ${USSD}       ${PACKAGE}
    ${STATUS}=          Run Keyword And Return Status     Add Dictionary Assignment       ${ASSIGNTO}         ${KEYNO}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get USSD package on profile : ${PROFILE}
    ${ACTUALPASS}=      Plus Connect String     Passed, Get USSD Package  (your select on menu key ${KEYNO})
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get USSD Package not success  (check parameter package)
    LOG TXT FILE        ${USSD}
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False       Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True        Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Get USSD package  ${EXPECTED}   ${ACTUALPASS}    PASSED     None        ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Get USSD package    ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE SELECT UMB PACKAGE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${SELECT}           None
    Set Test Variable   ${PROFILE}          None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        SELECT      NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        PROFILE     NO
    ${SELECT}=          Get Parameter Value             ${PARAMETER}        SELECT
    ${SELECT}=          Verify Parameter Value          ${SELECT}          ${RUNITER}
    ${PROFILE}=         Get Parameter Value             ${PARAMETER}        PROFILE
    ${PROFILE}=         Verify Parameter Value          ${PROFILE}          ${RUNITER}
    Run Keyword If  '${SELECT}' != 'NO' and '${PROFILE}' != 'NO'            Set Test Variable       ${CHECKPARAM}      ${TRUE}
    @{SELECTED}=        Split String With Separator     ${SELECT}             ;
    :FOR    ${ISELECT}    IN        @{SELECTED}
    \   Run Keyword If  ${CHECKPARAM} == False          Exit For Loop
    \   Sub Select UMB Package      ${ISELECT}          ${PROFILE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Select UMB package profile language : ${PROFILE}  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Select UMB success (your select step ${SELECT})  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get USSD Package not success (check parameter select or package)  .
    LOG TXT FILE        None
    Run Keyword If  ${CHECKSELECTED} == False or ${CHECKPARAM} == False       Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${CHECKSELECTED} == True and ${CHECKPARAM} == True        Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select UMB Package   ${EXPECTED}   ${ACTUALPASS}   PASSED   None   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select UMB Package   ${EXPECTED}   ${ACTUALFAIL}   FAILED   None   ${INDEXLOGFILE}

SUB SELECT UMB PACKAGE
    [Arguments]     ${PACKAGE}        ${PROFILE}
    Set Global Variable     ${CHECKSELECTED}    ${TRUE}
    Set Test Variable       ${FLAGCHECKUMB}     ${FALSE}
    @{LISTLOOP}=    Create List     1   2   3   4   5
    :FOR   ${ILOOP}     IN      @{LISTLOOP}
    \   ${STATUSUSSDMSG}=   Run Keyword And Return Status       Mobile Wait Until Element Is Visible            id=android:id/message                       5
    \   ${STATUSUSSDDIA}=   Run Keyword If  ${STATUSUSSDMSG} == False           Run Keyword And Return Status   Mobile Wait Until Element Is Visible        id=com.android.phone:id/dialog_message          5
    \   ${USSD}=            Run Keyword If  ${STATUSUSSDMSG} == True            Mobile Get Text                 id=android:id/message
    \   ...                 ELSE IF         ${STATUSUSSDDIA} == True            Mobile Get Text                 id=com.android.phone:id/dialog_message
    \   ${USSD}=            Convert To String    ${USSD}
    \   Log                 USSD >>>>> ${USSD}
    \   ${KEYNO}=        Get USSD Package               ${PROFILE}      ${USSD}     ${PACKAGE}
    \   Run Keyword If  '${KEYNO}' != '9' and '${KEYNO}' != '0' and ${KEYNO} != False         Set Test Variable       ${FLAGCHECKUMB}         ${TRUE}
    \   Run Keyword If  ${KEYNO} == False               Set Test Variable   ${CHECKSELECTED}    ${FALSE}
    \   ${STATUSSELECT}  Run Keyword If  ${KEYNO} != False      Run Keyword And Return Status   Mobile Input Text   id=com.android.phone:id/input_field     ${KEYNO}
    \   Run Keyword If  ${STATUSSELECT} == False        Set Test Variable   ${CHECKSELECTED}    ${FALSE}
    \   ...         ELSE    Mobile Click Element        id=android:id/button1
    \   Run Keyword If  ${FLAGCHECKUMB} == True         Exit For Loop

RAT MOBILE GET USSD MESSAGE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO        NO
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${ASSIGNTO}' != 'NO'    Set Test Variable  ${CHECKPARAM}     ${TRUE}
    ${STATUSDIALOG}=    Run Keyword And Return Status               Mobile Wait Until Element Is Visible        id=com.android.phone:id/dialog_message      10
    ${STATUSMESSAGE}=   Run Keyword If  ${STATUSDIALOG} == False    Run Keyword And Return Status               Mobile Wait Until Element Is Visible        id=android:id/message          10
    ${USSD}=            Run Keyword If  ${STATUSDIALOG} == True     Mobile Get Text              id=com.android.phone:id/dialog_message
    ...                 ELSE IF  ${STATUSMESSAGE} == True           Mobile Get Text              id=android:id/message
    ${USSD}=             Convert To String    ${USSD}
    Log                 USSD >>>>> ${USSD}
    ${STATUS}=          Add Dictionary Assignment       ${ASSIGNTO}         ${USSD}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get USSD message  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Get USSD message success  (see detail USSD on log text file)
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get USSD message not success  (check parameter assign to or USSD network)
    LOG TXT FILE        ${USSD}
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Get USSD message  ${EXPECTED}   ${ACTUALPASS}    PASSED       None        ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Get USSD message    ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE CALCULATE BALANCE
    [Arguments]         ${PARAMETER}            ${RUNITER}
    Set Test Variable   ${BEFORE}               None
    Set Test Variable   ${AFTER}                None
    Set Test Variable   ${ASSIGNTO}             None
    Set Test Variable   ${CHECKPARAM}           ${FALSE}
    ${PARAMETER}=       Additional Parameter Value          ${PARAMETER}            BEFORE        NO
    ${PARAMETER}=       Additional Parameter Value          ${PARAMETER}            AFTER         NO
    ${PARAMETER}=       Additional Parameter Value          ${PARAMETER}            ASSIGNTO      NO
    ${BEFORE}=          Get Parameter Value                 ${PARAMETER}            BEFORE
    ${BEFORE}=          Verify Parameter Value              ${BEFORE}               ${RUNITER}
    ${AFTER}=           Get Parameter Value                 ${PARAMETER}            AFTER
    ${AFTER}=           Verify Parameter Value              ${AFTER}                ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value                 ${PARAMETER}            ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value              ${ASSIGNTO}             ${RUNITER}
    Run Keyword If  '${BEFORE}' != 'NO' and '${AFTER}' != 'NO' and '${ASSIGNTO}' != 'NO'  Set Test Variable     ${CHECKPARAM}       ${TRUE}
    ${BALANCE}=         Run Keyword If  ${STATUS} == True   Get Calculate Number    ${BEFORE}     ${AFTER}      -
    ${BALANCE}=         Convert To String                   ${BALANCE}
    ${CHECKEMPTY}=      Run Keyword And Return Status       Should Not Be Empty     ${BALANCE}
    ${STATUS}=          Run Keyword If  ${CHECKEMPTY} == True   Run Keyword And Return Status     Add Dictionary Assignment         ${ASSIGNTO}             ${BALANCE}
# Write logger report function
    ${EXPECTED}=    Plus Connect String     Calculate Balance :  ${BEFORE} - ${AFTER}
    ${ACTUALPASS}=  Plus Connect String     Before : ${BEFORE} (-) After : ${AFTER} =  ${BALANCE}
    ${ACTUALFAIL}=  Plus Connect String     Failed, Can not calculate balance  (check parameter before, after and assign to)
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Calculate Balance   ${EXPECTED}   ${ACTUALPASS}    PASSED     None     ${INDEXLOGFILE}
    ...     ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Calculate Balance   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None     ${INDEXLOGFILE}

RAT MOBILE CAPTURE MOBILE SCREENSHOT
#Create by Jay 31-1-2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${FILEPATH}         None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value          ${PARAMETER}            FILEPATH        NO
    ${FILEPATH}=        Get Parameter Value                 ${PARAMETER}            FILEPATH
    ${FILEPATH}=        Verify Parameter Value              ${FILEPATH}             ${RUNITER}
    Run Keyword If  '${FILEPATH}' != 'NO'  Set Test Variable     ${CHECKPARAM}      ${TRUE}
    ${FOUNDFOLDER} =    Get File Exist                      ${FILEPATH}${/}${REPORTID}
    Run Keyword If      ${FOUNDFOLDER} != True              Create Folder           ${FILEPATH}     ${REPORTID}
    ${FILENAME}=        Create File Name With Index         ${FILEPATH}${/}${REPORTID}              Screenshot          png
    ${STATUS}=          Run Keyword And Return Status       Mobile Capture Page screenshot          ${FILEPATH}${/}${REPORTID}${/}${FILENAME}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Capture mobile screenshot to :  ${FILEPATH}${/}${FILENAME}
    ${ACTUALPASS}=      Plus Connect String     Passed, capture mobile screenshot success :  ${FILEPATH}${/}${FILENAME}
    ${ACTUALFAIL}=      Plus Connect String     Failed, capture mobile screenshot not success  (check parameter file path)
    Set Test Variable   ${CAPTURE}            False
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}    CAPTURE         False
    ${CAPTURE}=         Get Parameter Value             ${PARAMETER}    CAPTURE
    ${INDEXSHOT}=       Create file name by index       ${RUNLOGIMG}    png
    ${FLAGCAPTURE}=     Convert To Boolean              ${CAPTURE}
    Run Keyword If      ${FLAGCAPTURE} == True     Mobile Capture Page screenshot        ${RUNLOGIMG}${/}${INDEXSHOT}
    ...     ELSE        Set Test Variable               ${INDEXSHOT}     None
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Capture mobile screenshot   ${EXPECTED}   ${ACTUALPASS}    PASSED     ${INDEXSHOT}     ${INDEXLOGFILE}
    ...     ELSE        Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Capture mobile screenshot   ${EXPECTED}   ${ACTUALFAIL}    FAILED     ${INDEXSHOT}     ${INDEXLOGFILE}

RAT MOBILE VERIFY MESSAGE BY KEYWORDS
#Create by Chayut 09/02/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${MESSAGE}          None
    Set Test Variable   ${KEYWORD}          None
    Set Test Variable   ${STATUS}           ${FALSE}
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        MESSAGE       NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        KEYWORD       NO
    ${MESSAGE}=         Get Parameter Value             ${PARAMETER}        MESSAGE
    ${MESSAGE}=         Verify Parameter Value          ${MESSAGE}          ${RUNITER}
    ${KEYWORD}=         Get Parameter Value             ${PARAMETER}        KEYWORD
    ${KEYWORD}=         Verify Parameter Value          ${KEYWORD}          ${RUNITER}
    Run Keyword If  '${MESSAGE}' != 'NO' and '${KEYWORD}' != 'NO'           Set Test Variable       ${CHECKPARAM}       ${TRUE}
    ${MESSAGEHASKEY}=    Verify Message Detail by Keywords                  ${MESSAGE}              ${KEYWORD}
    Run Keyword If  '${MESSAGEHASKEY}' == 'None'        Set Test Variable   ${STATUS}               ${TRUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Verify message by keywords :  ${KEYWORD}
    ${ACTUALPASS}=      Plus Connect String     Message :  ${MESSAGEHASKEY}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Not have keyword (${KEYWORD}) in message    (check parameter message and keyword)
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Verify message by keywords   ${EXPECTED}   ${ACTUALPASS}    PASSED     None     ${INDEXLOGFILE}
    ...     ELSE        Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Verify message by keywords   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None     ${INDEXLOGFILE}

RAT MOBILE SWITCH APPLICATION
#Create by Chayut 09/02/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable    ${INDEX}           None
    Set Test Variable    ${ALIAS}           None
    Set Test Variable    ${CHECKPARAM}      ${FALSE}
    ${PARAMETER}=        Additional Parameter Value      ${PARAMETER}            INDEX          NO
    ${PARAMETER}=        Additional Parameter Value      ${PARAMETER}            ALIAS          NO
    ${INDEX}=            Get Parameter Value             ${PARAMETER}            INDEX
    ${INDEX}=            Verify Parameter Value          ${INDEX}                ${RUNITER}
    ${ALIAS}=            Get Parameter Value             ${PARAMETER}            ALIAS
    ${ALIAS}=            Verify Parameter Value          ${ALIAS}                ${RUNITER}
    Run Keyword If  '${INDEX}' != 'NO' or '${ALIAS}' != 'NO'  Set Test Variable  ${CHECKPARAM}  ${TRUE}
    ${STATUS}=           Run Keyword If   ${CHECKPARAM} == True and '${INDEX}' != 'NO'   Run Keyword And Return Status      Switch application      ${INDEX}
    ...         ELSE IF  ${CHECKPARAM} == True and '${ALIAS}' != 'NO'                    Run Keyword And Return Status      Switch application      ${ALIAS}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Switch Application  .
    ${ACTUALPASS}=      Run Keyword If  '${INDEX}' != 'NO'      Plus Connect String     Passed, Switch application on index :  ${INDEX}
    ...                 ELSE IF  '${ALIAS}' != 'NO'             Plus Connect String     Passed, Switch application on alias :  ${ALIAS}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Can not switch application     (check parameter index or alias)
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False       Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True        Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Switch Application  ${EXPECTED}   ${ACTUALPASS}    PASSED       None        ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Switch Application    ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE SET NETWORK CONNECTION
#Create by Chayut 09/02/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable    ${CONNECT}             None
    Set Test Variable    ${CHECKPARAM}          ${FALSE}
    Set Test Variable    ${CHECKNETWORK}        ${FALSE}
    ${PARAMETER}=        Additional Parameter Value      ${PARAMETER}            CONNECTION         NO
    ${CONNECT}=          Get Parameter Value             ${PARAMETER}            CONNECTION
    ${CONNECT}=          Verify Parameter Value          ${CONNECT}              ${RUNITER}
    Run Keyword If       '${CONNECT}' != 'NO'            Set Test Variable       ${CHECKPARAM}      ${TRUE}
    ${CONNECT}=          Convert To Uppercase            ${CONNECT}
    Run Keyword If       ${CHECKPARAM} == True and '${CONNECT}' == 'WIFI'         Set Test Variable  ${NETWORKVALUE}     2
    ...         ELSE IF  ${CHECKPARAM} == True and '${CONNECT}' == 'DATA'         Set Test Variable  ${NETWORKVALUE}     4
    ...         ELSE     Set Test Variable  ${NETWORKVALUE}     6
    ${STATUSSET}=        Run Keyword If   ${CHECKPARAM} == True                   Run Keyword And Return Status          Set Network Connection Status          ${NETWORKVALUE}
    ${CURRENTSTATUS}=    Run Keyword If   ${STATUSSET} == True                    Run Keyword And Return Status          Get Network Connection Status
    Run Keyword If       '${NETWORKVALUE}' == '${CURRENTSTATUS}'                  Set Test Variable  ${CHECKNETWORK}     ${TRUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Set network connection  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Set network connection success :       ${CONNECT}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Set network connection not success    (check parameter connection)
    LOG TXT FILE        None
    Run Keyword If  ${CHECKPARAM} == False or ${STATUSSET} == False    Set Global Variable         ${FLAGRUNRESULT}   False
    Run Keyword If  ${CHECKPARAM} == True and ${STATUSSET} == True     Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Set Network Connection   ${EXPECTED}   ${ACTUALPASS}    PASSED       None    ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Set Network Connection    ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}

RAT MOBILE GET TEXT
#Create by Chayut 15/02/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${ELEMENTNAME}      None
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}            ELEMENTNAME         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}            ASSIGNTO            NO
    ${ELEMENTNAME}=     Get Parameter Value             ${PARAMETER}            ELEMENTNAME
    ${ELEMENTNAME}=     Verify Parameter Value          ${ELEMENTNAME}          ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}            ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${VALUE}                ${RUNITER}
    Run Keyword If  '${ELEMENTNAME}' != 'NO' and '${ASSIGNTO}' != 'NO'          Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${TEXTVALUE}=       Run Keyword If  ${CHECKPARAM} == True                   Mobile Get Text     &{ELEMENT}[${ELEMENTNAME}]
    ${TEXTVALUE}=       Convert To String               ${TEXTVALUE}
    Log                 TEXT VALUE >>>>> ${TEXTVALUE}
    ${STATUS}=          Run Keyword And Return Status   Add Dictionary Assignment    ${ASSIGNTO}    ${TEXTVALUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get text element name :  ${ELEMENTNAME}
    ${ACTUALPASS}=      Plus Connect String     Passed, Text value :  ${TEXTVALUE}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get text not success  (check parameter element name and assign to)
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False   Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Get Text   ${EXPECTED}   ${ACTUALPASS}    PASSED        None        ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Get Text   ${EXPECTED}   ${ACTUALFAIL}    FAILED       None         ${INDEXLOGFILE}

RAT MOBILE GO HOME
#Create by Chayut 15/02/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    ${STATUS}=          Run Keyword And Return Status      Press Keycode       0
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Go home  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Go to home menu success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Go to home menu not success  .
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True       Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Go Home   ${EXPECTED}   ${ACTUALPASS}    PASSED     None      ${INDEXLOGFILE}
    ...         ELSE
    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Go Home   ${EXPECTED}   ${ACTUALFAIL}    FAILED     None      ${INDEXLOGFILE}
