*** Settings ***
Library     D:\\RATFramework\\Library\\RATLibrary
Library     Selenium2Library      run_on_failure=Nothing
Library     String

*** Keywords ***
RAT REPORT PRINT
    [Arguments]     ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${PRINT}            None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        PRINT               NO
    ${PRINT}=           Get Parameter Value             ${PARAMETER}        PRINT
    ${PRINT}=           Verify Parameter Value          ${PRINT}            ${RUNITER}
    Run Keyword If  '${PRINT}' != 'NO'                  Set Test Variable   ${CHECKPARAM}       ${TRUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Report print  .
    ${ACTUALPASS}=      Plus Connect String     Print : ${PRINT}  .
    ${ACTUALFAIL}=      Plus Connect String     Can not print report (check parameter print)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${CHECKPARAM} == False      Set Global Variable     ${FLAGRUNRESULT}        False
    Run Keyword If  ${CHECKPARAM} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Report print   ${EXPECTED}   ${ACTUALPASS}   PASSED    ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Report print   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT JUMP STEP WITH CONDITION
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${STATUS}          ${TRUE}
    Set Test Variable   ${EXPECT}          None
    Set Test Variable   ${ACTUAL}          None
    Set Test Variable   ${VERIFYTYPE}      None
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        EXPECT           NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ACTUAL           NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VERIFYTYPE       NO
    ${EXPECT}=          Get Parameter Value             ${PARAMETER}        EXPECT
    ${EXPECT}=          Verify Parameter Value          ${EXPECT}           ${RUNITER}
    ${ACTUAL}=          Get Parameter Value             ${PARAMETER}        ACTUAL
    ${ACTUAL}=          Verify Parameter Value          ${ACTUAL}           ${RUNITER}
    ${VERIFYTYPE}=      Get Parameter Value             ${PARAMETER}        VERIFYTYPE
    ${VERIFYTYPE}=      Verify Parameter Value          ${VERIFYTYPE}       ${RUNITER}
    ${VERIFYTYPE}=      Convert To Uppercase            ${VERIFYTYPE}
    Run Keyword If  '${EXPECT}' == 'NO' or '${ACTUAL}' == 'NO' or '${VERIFYTYPE}' == 'NO'    Set Test Variable                ${STATUS}       ${FALSE}
    ${RESULT}=          Run Keyword If   ${STATUS} == True and '${VERIFYTYPE}' == 'MATCH'   Run Keyword And Return Status     Should Be Equal       '${EXPECT}'       '${ACTUAL}'
    ...         ELSE IF  ${STATUS} == True and '${VERIFYTYPE}' == 'MISMATCH'                Run Keyword And Return Status     Should Not Be Equal   '${EXPECT}'       '${ACTUAL}'
    ...         ELSE IF  ${STATUS} == True and '${VERIFYTYPE}' == 'FIND'                    Verify Search Regexp String       '${ACTUAL}'     '${EXPECT}'
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Jump step with condition :   ${VERIFYTYPE}
    ${ACTUALPASS}=      Plus Connect String     Infomation , Expect : ${EXPECT}         Actual : ${ACTUAL}
    ${ACTUALFAIL}=      Plus Connect String     Infomation , Expect : ${EXPECT}         Actual : ${ACTUAL}
    Run Keyword If  ${RESULT} == False          Set Global Variable         ${CONDITIONJUMP}    False
    Run Keyword If  ${RESULT} == True           Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Report print  ${EXPECTED}   ${ACTUALPASS}    INFORMATION       None        None
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Report print  ${EXPECTED}   ${ACTUALFAIL}    INFORMATION       None        None

RAT REPLACE STRING
    [Arguments]         ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${MESSAGE}          None
    Set Test Variable   ${FIND}             None
    Set Test Variable   ${REPLACE}          None
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${VALUE}            None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        MESSAGE         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        FIND            NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        REPLACE         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO        NO
    ${MESSAGE}=         Get Parameter Value             ${PARAMETER}        MESSAGE
    ${MESSAGE}=         Verify Parameter Value          ${MESSAGE}          ${RUNITER}
    ${FIND}=            Get Parameter Value             ${PARAMETER}        FIND
    ${FIND}=            Verify Parameter Value          ${FIND}             ${RUNITER}
    ${REPLACE}=         Get Parameter Value             ${PARAMETER}        REPLACE
    ${REPLACE}=         Verify Parameter Value          ${REPLACE}          ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${MESSAGE}' != 'NO' and '${FIND}' != 'NO' and '${REPLACE}' != 'NO' and '${ASSIGNTO}' != 'NO'       Set Test Variable       ${CHECKPARAM}       ${TRUE}
    ${VALUE}=           Run Keyword If  ${CHECKPARAM} == True               Replace String      ${MESSAGE}      ${FIND}     ${REPLACE}
    ${CHECKVALUE}=      Verify None Parameter Value     ${VALUE}
    ${STATUS}=          Run Keyword If  ${CHECKVALUE} == True               Run Keyword And Return Status       Add Dictionary Assignment       ${ASSIGNTO}         ${VALUE}
    # Log debug for dev function
    Log                 MESSAGE= ${MESSAGE} | FIND= ${FIND} | REPLACE= ${REPLACE} >>> New Message:= ${VALUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Replace String :                            ${MESSAGE}
    ${ACTUALPASS}=      Plus Connect String     Passed, Replace string success value :      ${VALUE}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Replace string not success value :  ${VALUE}
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False or ${CHECKVALUE} == False      Set Global Variable     ${FLAGRUNRESULT}    False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True and ${CHECKVALUE} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Replace String   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Replace String   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT COMPARE EQUAL
    [Arguments]         ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${VALUE1}           None
    Set Test Variable   ${VALUE2}           None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE1         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE2         NO
    ${VALUE1}=          Get Parameter Value             ${PARAMETER}        VALUE1
    ${VALUE1}=          Verify Parameter Value          ${VALUE1}           ${RUNITER}
    ${VALUE2}=          Get Parameter Value             ${PARAMETER}        VALUE2
    ${VALUE2}=          Verify Parameter Value          ${VALUE2}           ${RUNITER}
    Run Keyword If      '${VALUE1}' != 'NO' and '${VALUE2}' != 'NO'         Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${STR1}             Convert To String               ${VALUE1}
    ${STR2}             Convert To String               ${VALUE2}
    ${STATUS} =         Run Keyword If  ${CHECKPARAM} == True          Run Keyword And Return Status                Should Be Equal     '${STR1}'       '${STR2}'
    Run Keyword If      ${STATUS} == True           Log                Test Passed : Compare value is Equal
    # Log debug for dev function
    Log                 VALUE1= ${VALUE1} | VALUE2= ${VALUE1} >>> Compare equal := ${STATUS}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Compare equal :                                 ${VALUE1} VS ${VALUE2}
    ${ACTUALPASS}=      Plus Connect String     Passed, Compare equal is success :              ${VALUE1} = ${VALUE2}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Compare equal is not success :          ${VALUE1} <> ${VALUE2}
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If      ${STATUS} == False or ${CHECKPARAM} == False      Set Global Variable         ${FLAGRUNRESULT}    False
    Run Keyword If      ${STATUS} == True and ${CHECKPARAM} == True       Write Text Log  ${TXTLOG}   ${REPORTID}         ${ITERSEQ}  ${POSID}    Compare Equal   ${EXPECTED}   ${ACTUALPASS}    PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}    Compare Equal   ${EXPECTED}   ${ACTUALFAIL}    FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT COMPARE NOT EQUAL
    [Arguments]         ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${VALUE1}           None
    Set Test Variable   ${VALUE2}           None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE1         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE2         NO
    ${VALUE1}=          Get Parameter Value             ${PARAMETER}        VALUE1
    ${VALUE1}=          Verify Parameter Value          ${VALUE1}           ${RUNITER}
    ${VALUE2}=          Get Parameter Value             ${PARAMETER}        VALUE2
    ${VALUE2}=          Verify Parameter Value          ${VALUE2}           ${RUNITER}
    Run Keyword If      '${VALUE1}' != 'NO' and '${VALUE2}' != 'NO'          Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${STR1}             Convert To String               ${VALUE1}
    ${STR2}             Convert To String               ${VALUE2}
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True          Run Keyword And Return Status                  Should not Be Equal     '${STR1}'       '${STR2}'
    Run Keyword If      ${STATUS} == True           Log                Test Passed : Compare value is Not Equal
    # Log debug for dev function
    Log                 VALUE1= '${VALUE1}' | VALUE2= '${VALUE2}' >>> Compare not equal := ${STATUS}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Compare not equal :  ${VALUE1} VS ${VALUE2}
    ${ACTUALPASS}=      Plus Connect String     Passed, Compare not equal is success :  ${VALUE1} <> ${VALUE2}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Compare not equal is not success :  ${VALUE1} = ${VALUE2}
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If      ${STATUS} == False or ${CHECKPARAM} == False       Set Global Variable         ${FLAGRUNRESULT}    False
    Run Keyword If      ${STATUS} == True and ${CHECKPARAM} == True        Write Text Log   ${TXTLOG}   ${REPORTID}         ${ITERSEQ}  ${POSID}   Compare Not Equal   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Compare Not Equal   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT GET CAL DATE
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${DAY}              None
    Set Test Variable   ${FROMDATE}         None
    Set Test Variable   ${OPER}             None
    Set Test Variable   ${TEMP}             None
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${LANGUAGE}         None
    Set Test Variable   ${GETDATERESULT}    ${TRUE}
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        DAY             NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        FROMDATE        NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        OPER            NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        LANGUAGE        EN
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO        NO
    ${DAY}=             Get Parameter Value             ${PARAMETER}        DAY
    ${DAY}=             Verify Parameter Value          ${DAY}              ${RUNITER}
    ${FROMDATE}=        Get Parameter Value             ${PARAMETER}        FROMDATE
    ${FROMDATE}=        Verify Parameter Value          ${FROMDATE}         ${RUNITER}
    ${OPER}=            Get Parameter Value             ${PARAMETER}        OPER
    ${OPER}=            Verify Parameter Value          ${OPER}             ${RUNITER}
    ${LANGUAGE}=        Get Parameter Value             ${PARAMETER}        LANGUAGE
    ${LANGUAGE}=        Verify Parameter Value          ${LANGUAGE}         ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If      '${DAY}' != 'NO' and '${FROMDATE}' != 'NO' and '${OPER}' != 'NO' and '${ASSIGNTO}' != 'NO'      Set Test Variable              ${CHECKPARAM}       ${TRUE}
    ${DATERESULT}=      Run Keyword If  ${CHECKPARAM} == True               Get Cal Date    ${DAY}      ${FROMDATE}     ${OPER}     ${LANGUAGE}
    ${DATERESULT}=      Run Keyword If  ${CHECKPARAM} == True               Convert Date    ${DATERESULT}               result_format=%Y-%m-%d
    Run Keyword If  '${DATERESULT}' == 'None'          Set Test Variable    ${GETDATERESULT}         ${FALSE}
    ${STATUS}=          Run Keyword If  ${GETDATERESULT} == True            Run Keyword And Return Status               Add Dictionary Assignment      ${ASSIGNTO}          str(${DATERESULT})
    # Log debug for dev function
    Log   VALIDITY= ${DAY} | FROMDATE= ${FROMDATE} | OPER= ${OPER} >>> Calculate DATE Status := ${STATUS}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get cal date form input :           ${FROMDATE} (${OPER}) ${DAY}
    ${ACTUALPASS}=      Plus Connect String     Passed, Get cal date success :      ${DATERESULT}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get cal date not success  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False or ${GETDATERESULT} == False     Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True and ${GETDATERESULT} == True      Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get Cal Date   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get Cal Date   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT CALCULATE NUMBER
    [Arguments]         ${PARAMETER}    ${RUNITER}
    Set Test Variable   ${A}                None
    Set Test Variable   ${B}                None
    Set Test Variable   ${OPER}             None
    Set Test Variable   ${GETRESULT}        ${TRUE}
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        A               NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        B               NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        OPER            NO
    ${A}=               Get Parameter Value             ${PARAMETER}        A
    ${A}=               Verify Parameter Value          ${A}                ${RUNITER}
    ${B}=               Get Parameter Value             ${PARAMETER}        B
    ${B}=               Verify Parameter Value          ${B}                ${RUNITER}
    ${OPER}=            Get Parameter Value             ${PARAMETER}        OPER
    ${OPER}=            Verify Parameter Value          ${OPER}             ${RUNITER}
    Run Keyword If   '${A}' != 'NO' and '${B}' != 'NO' and '${OPER}' != 'NO'    Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${RESULT}=          Run Keyword If  ${CHECKPARAM} == True       Get Calculate Number    ${A}    ${B}    ${OPER}
    Run Keyword If   '${RESULT}' == 'FAIL'              Set Test Variable   ${GETRESULT}    ${FALSE}
    ${STATUS}=          Run Keyword If   ${GETRESULT} == True       Run Keyword And Return Status          Add Dictionary Assignment        ${RESULT}         ${A}
    # Log debug for dev function
    Log   VALUE1= ${A} | VALUE2= ${B} | VALUE3= ${OPER} >>> Calculate Status := ${GETRESULT}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Calculate number :  ${A} ( ${OPER} ) ${B}
    ${ACTUALPASS}=      Plus Connect String     Passed, Result Success is :  ${RESULT}
    ${ACTUALFAIL}=      Plus Connect String     Failed, Result Fail is :  ${A} ( ${OPER} ) ${B}
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If   ${STATUS} == False or ${CHECKPARAM} == False or ${GETRESULT} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If   ${STATUS} == True and ${CHECKPARAM} == True and ${GETRESULT} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get Calculate Number   ${EXPECTED}   ${ACTUALPASS}    PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get Calculate Number   ${EXPECTED}   ${ACTUALFAIL}    FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT IS NULL
#Create by Panumas (Nueng) 2017-02-06
    [Arguments]         ${PARAMETER}    ${RUNITER}
    Set Test Variable   ${VALUE}            None
    Set Test Variable   ${ISNULL}           False
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE           NO
    ${VALUE}=           Get Parameter Value             ${PARAMETER}        VALUE
    ${VALUE}=           Verify Parameter Value          ${VALUE}            ${RUNITER}
    Run Keyword If      '${VALUE}' != 'NO'              Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${STATUS}=          Run Keyword If  ${CHECKPARAM} == True               Is Null         ${VALUE}
    # Log debug for dev function
    LOG                 VALUE:= ${VALUE} | STATUS:= ${STATUS}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Check value is null  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Value ( ${VALUE} ) is null verify success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Value is not null verify not success (check parameter value and assign to)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If      ${STATUS} == False or ${CHECKPARAM} == False        Set Global Variable         ${FLAGRUNRESULT}    False
    Run Keyword If      ${STATUS} == True and ${CHECKPARAM} == True         Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Verify Null Value   ${EXPECTED}   ${ACTUALPASS}    PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Verify Null Value   ${EXPECTED}   ${ACTUALFAIL}    FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT IS CONTAIN STRING
#Create by Panums (Nueng) 2017-02-06
    [Arguments]         ${PARAMETER}    ${RUNITER}
    Set Test Variable   ${VALUE1}           None
    Set Test Variable   ${VALUE2}           None
    Set Test Variable   ${ISCONTAIN}        None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE1          NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE2          NO
    ${VALUE1}=          Get Parameter Value             ${PARAMETER}        VALUE1
    ${VALUE1}=          Verify Parameter Value          ${VALUE1}           ${RUNITER}
    ${VALUE2}=          Get parameter Value             ${PARAMETER}        VALUE2
    ${VALUE2}=          Verify Parameter Value          ${VALUE2}           ${RUNITER}
    Run Keyword If      '${VALUE1}' != 'NO' and '${VALUE2}' != 'NO' and '${ASSIGNTO}' != 'NO'   Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${ISCONTAIN}=      Run Keyword If  ${CHECKPARAM} == True               Is Contain String       ${VALUE1}       ${VALUE2}
    # Log debug for dev function
    Log                 VALUE1:= ${VALUE1} | VALUE2:= ${VALUe2} | ISCONTAIN:= ${ISCONTAIN}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Is contain string :  ${VALUE1} VS ${VALUE2}
    ${ACTUALPASS}=      Plus Connect String     Passed, String is contain :  ${VALUE1} LIKE ${VALUE2}
    ${ACTUALFAIL}=      Plus Connect String     Failed, String is not contain :  ${VALUE1} NOT LIKE ${VALUE2}
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If      ${ISCONTAIN} == False or ${CHECKPARAM} == False        Set Global Variable         ${FLAGRUNRESULT}    False
    Run Keyword If      ${ISCONTAIN} == True and ${CHECKPARAM} == True         Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Is Contain String   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Is Contain String   ${EXPECTED}   ${ACTUALFAIL}    FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}