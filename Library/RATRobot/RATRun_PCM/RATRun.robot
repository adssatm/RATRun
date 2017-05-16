*** Settings ***
Library          D:\\RATFramework\\Library\\RATLibrary
Library          Collections
Test Setup       Prepare data
Resource         UtilityAction.robot
Resource         WebActionCommon.robot
Resource         MobileActionCommon.robot
Resource         PCM.robot

*** Testcases ***
Rule of RAT Application Testing
    [Template]   RAT Step test
    :FOR  ${ICASE}   in   @{TESTCASE}
    \    ${PROJECT}     ${ICASE}

*** Keywords ***
RAT Step test
    [Arguments]    ${PROJECT}    ${TESTCASE}
    Log         PROJECT RUN : ${PROJECT}
    Log         TEST CASE : ${TESTCASE}
    ${REPORTID}=    Create Report Id
    ${RUNLOGPATH}=  Create Folder           ${LOGPATH}          ${REPORTID}
    ${RUNLOGIMG}=   Create Folder           ${RUNLOGPATH}       Images
    ${RUNLOGFILE}=  Create Folder           ${RUNLOGPATH}       LogFile
    ${TXTLOG}=      Create Text Logger      ${RUNLOGPATH}
    ${XLSLOG}=      Create Excel Logger     ${RUNLOGPATH}       ${TESTLC}
    Set Global Variable     ${REPORTID}
    Set Global Variable     ${TXTLOG}
    Set Global Variable     ${XLSLOG}
    Set Global Variable     ${RUNLOGIMG}
    Set Global Variable     ${RUNLOGFILE}
    Add element item to dictionary          ${PROJECT}
    @{ITERATION}=   Get Iteration           ${PROJECT}          ${TESTCASE}
    Log To Console  >>>>>>>>>
    Log To Console  =======================================================
    Log To Console  Run Test Case : [${TESTCASE}]
    Log To Console  =======================================================
    Log To Console  -------------------- Testing Start --------------------
    :FOR    ${IITER}    in      @{ITERATION}
    \   Set Test Variable   ${TESTRESULT}       True
    \   Set Global Variable  ${GOLITER}         ${IITER}
    \   ${ITERSEQ}=     Get Sequence Iteration      ${GOLITER}
    \   Log To Console  ---------------- [ ${ITERSEQ} ] -------------------
    \   Case step     ${PROJECT}    ${TESTCASE}     ${TESTRESULT}
    ${REPORTNAME}=      Plus Connect String     Report :       ${PROJECT}
    ${TESTSCRIPT}=      Plus Connect String     RAT Run Application :       ${PROJECT}
    ${NUMOFITER}=   Get Number Of Iteration
    ${LOGDATE}=     Get Date Description
    Write Excel Report Description      ${XLSLOG}    ${REPORTID}     ${REPORTNAME}      ${TESTSCRIPT}      ${TESTER}     ${NUMOFITER}     ${PROJECT}     ${LOGDATE}
    Write Complete Log From Text To Excel       ${TXTLOG}       ${XLSLOG}
    Log To Console  -------------------- Testing Stop ----------------------

Prepare data
    ${PATHLOCAL}=   Get Config Path
    ${RESULTPATH}=  Get Result Path
    ${CONFIG}=      Get Config File
    ${PROJECT}=     Get Run Project
    @{TESTCASE}=    Get Run Testcase
    ${TESTLC}=      Get Run Location
    ${TESTER}=      Get Run Tester
    ${LOGPATH}=     Create Folder   ${RESULTPATH}   ${PROJECT}
    Set Test Variable    ${PROJECT}                 ${PROJECT}
    Set Test Variable    @{TESTCASE}                @{TESTCASE}
    Set Global Variable  ${TESTER}
    Set Global Variable  ${LOGPATH}
    Set Global Variable  ${TESTLC}
    Get Run Global Parameter
    Create Dictionary Assignment

Add element item to dictionary
    [Arguments]    ${PROJECT}
    &{ELEMENT}=    Add Element To Dictionary    ${PROJECT}
    Set Global Variable  &{ELEMENT}

Case step
     [Arguments]    ${PROJECT}    ${TESTCASE}       ${TESTRESULT}
    @{TESTSTEP}=    Get Test Step       ${PROJECT}      ${TESTCASE}
    Set Global Variable     @{TESTSTEP}             @{TESTSTEP}
    Set Global Variable     ${STEPJUMPER}           None
    Set Global Variable     ${CONDITIONJUMP}        ${TRUE}
    Set Global Variable     ${FLAGRUNRESULT}        ${TRUE}
    Set Global Variable     ${FALGJUMPSTEP}         ${FALSE}
    ${ITERSEQ}=             Get Sequence Iteration          ${GOLITER}
    ${SCENARIONAME}=        Get Test Scenario Name          ${GOLITER}
    Set Global Variable     ${ITERSEQ}
    :FOR  ${ISTEP}   in   @{TESTSTEP}
    \       Run Keyword If  ${FALGJUMPSTEP} == True     Exit For Loop
    \       ${FLAGJUMP}=    Convert To Boolean          ${CONDITIONJUMP}
    \       Run Keyword If  ${FLAGJUMP} == False        Set Global Variable      ${CONDITIONJUMP}      True
    \       ${FLAGTEST}=    Convert To Boolean          ${FLAGRUNRESULT}
    \       Run Keyword If  ${FLAGTEST} == False        Set Global Variable      ${FLAGRUNRESULT}      True
    \       ${APPLICATION}=     Get Test Application    ${ISTEP}
    \       ${MACHINE}=     Get Test Machine            ${ISTEP}
    \       ${ACTION}=      Get Test Action             ${ISTEP}
    \       ${PARMETER}=    Get Test Parameter          ${ISTEP}
    \       ${JUMPER}=      Get Test Jumper             ${ISTEP}
    \       ${ERROR}=       Get Test Errorexception     ${ISTEP}
    \       ${FLAGERROR}=   Convert To Boolean          ${ERROR}
    \       Log To Console  Test Step Detail ${ISTEP} / ${APPLICATION} / ${MACHINE} / ${ACTION}
    \       ${TIMETEST}=    Get Logtime Now
    \       ${POSID}=       Plus Connect String     L   ${TIMETEST}
    \       Set Global Variable     ${POSID}
    \       ${STATUS}=      Run Keyword And Return Status    ${ACTION}        ${PARMETER}          ${GOLITER}
    \       ${FLAGTEST}=    Convert To Boolean          ${FLAGRUNRESULT}
    \       Log         Flag test step ${ISTEP} is = ${FLAGTEST}
    \       Run Keyword If    ${FLAGTEST} == True and ${STATUS} == True     Set Test Variable     ${FLAGSTATUS}        Pass
    \       ...    ELSE       Set Test Variable         ${FLAGSTATUS}       Fail
    \       Log To Console  Test Step Result >>>>>>>>>> ${FLAGSTATUS} <<<<<<<<<<
    \       Run Keyword If  ${FLAGTEST} == False        Set Test Variable       ${TESTRESULT}         False
    \       Run Keyword If  ${STATUS} == False          Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    ${ACTION}   Error setp : ${ISTEP}   Error, have some error in function (see more on temp html logger)    FAILED     None     None
    \       Run Keyword If  ${STATUS} == False and ${FLAGERROR} == False        Exit For Loop
    \       Run Keyword If  ${FLAGTEST} == False and ${FLAGERROR} == False      Exit For Loop
    \       Run Keyword If  '${JUMPER}' != 'None'       Set Global Variable     ${STEPJUMPER}         ${JUMPER}
    \       Run Keyword If  '${JUMPER}' != 'None' and ${FLAGTEST} == True and ${STATUS} == True and ${CONDITIONJUMP} == True           Jumper Step              ${STEPJUMPER}
    ${FLAGLOG}=     Convert To Boolean          ${TESTRESULT}
    Run Keyword If  ${FLAGLOG} == True and ${STATUS} == True     Write Excel Report Iteration     ${XLSLOG}        ${REPORTID}      ${ITERSEQ}       ${ITERSEQ}      PASSED     ${SCENARIONAME}
    ...       ELSE  Write Excel Report Iteration        ${XLSLOG}       ${REPORTID}      ${ITERSEQ}       ${ITERSEQ}       FAILED       ${SCENARIONAME}

Jumper step
    [Arguments]     ${STEPJUMPER}
    Log     Step Jumping to := ${STEPJUMPER}
    ${TOTALSTEP}=   Get Total Teststep
    Log     Total Test Step := ${TOTALSTEP}
    Set Test Variable       ${TOTALSTEP}        ${TOTALSTEP}
    Set Test Variable       ${STARTJUMP}        ${STEPJUMPER}
    Set Test Variable       ${FLAGBREAK}        ${FALSE}
    Set Global Variable     ${STEPJUMPER}       None
    Set Global Variable     ${FALGJUMPSTEP}       ${TRUE}
    Log To Console  ---------- Step Jumping ----------
    :FOR  ${IJUMPSTEP}   IN RANGE     ${STARTJUMP}      ${TOTALSTEP}+1
    \       Run Keyword If  ${FLAGBREAK} == True        Exit For Loop
    \       ${FLAGTEST}=    Convert To Boolean          ${FLAGRUNRESULT}
    \       Run Keyword If  ${FLAGTEST} == False        Set Global Variable      ${FLAGRUNRESULT}      True
    \       ${APPLICATION}=     Get Test Application    ${IJUMPSTEP}
    \       ${MACHINE}=     Get Test Machine            ${IJUMPSTEP}
    \       ${ACTION}=      Get Test Action             ${IJUMPSTEP}
    \       ${PARMETER}=    Get Test Parameter          ${IJUMPSTEP}
    \       ${JUMPER}=      Get Test Jumper             ${IJUMPSTEP}
    \       ${ERROR}=       Get Test Errorexception     ${IJUMPSTEP}
    \       ${FLAGERROR}=   Convert To Boolean          ${ERROR}
    \       Log To Console  Test Step Detail ${IJUMPSTEP} / ${APPLICATION} / ${MACHINE} / ${ACTION}
    \       ${TIMETEST}=    Get Logtime Now
    \       ${LOGID}=       Plus Connect String     L   ${TIMETEST}
    \       Set Global Variable     ${POSID}            ${LOGID}
    \       ${STATUS}=      Run Keyword And Return Status    ${ACTION}        ${PARMETER}          ${GOLITER}
    \       ${FLAGTEST}=    Convert To Boolean          ${FLAGRUNRESULT}
    \       Log         Flag test step ${IJUMPSTEP} is = ${FLAGTEST}
    \       Run Keyword If    ${FLAGTEST} == True and ${STATUS} == True     Set Test Variable     ${FLAGSTATUS}        Pass
    \       ...    ELSE       Set Test Variable         ${FLAGSTATUS}       Fail
    \       Log To Console  Test Step Result >>>>>>>>>> ${FLAGSTATUS} <<<<<<<<<<
    \       Run Keyword If  ${FLAGTEST} == False        Set Test Variable       ${TESTRESULT}         False
    \       Run Keyword If  ${STATUS} == False          Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    ${ACTION}   Error setp : ${IJUMPSTEP}   Error, have some error in function (see more on temp html logger)    FAILED     None     None
    \       Run Keyword If  ${STATUS} == False and ${FLAGERROR} == False        Exit For Loop
    \       Run Keyword If  ${FLAGTEST} == False and ${FLAGERROR} == False      Exit For Loop
    \       Run Keyword If  ${IJUMPSTEP} == ${TOTALSTEP}                        Set Test Variable       ${FLAGBREAK}        ${TRUE}
    \       Run Keyword If  ${IJUMPSTEP} == ${TOTALSTEP}                        Exit For Loop
    \       Run Keyword If  '${JUMPER}' != 'None'       Set Global Variable     ${STEPJUMPER}           ${JUMPER}
    \       Run Keyword If  '${JUMPER}' != 'None' and ${FLAGTEST} == True and ${STATUS} == True and ${CONDITIONJUMP} == True           Jumper Step              ${STEPJUMPER}




