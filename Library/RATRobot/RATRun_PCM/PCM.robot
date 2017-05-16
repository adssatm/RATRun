*** Settings ***
Library     D:\\RATFramework\\Library\\RATLibrary
Library     D:\\RATFramework\\Library\\RATSpecific\\PCM
Library     AppiumLibrary       run_on_failure=Nothing
Library     Selenium2Library    run_on_failure=Nothing
Library     String

*** Keywords ***
RAT WEB GET OTP ESERVICE
#Create by Chayut 31/1/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${SMS}            None
    Set Test Variable   ${ASSIGNTO}       None
    Set Test Variable   ${GETOTP}         ${TRUE}
    Set Test Variable   ${CHECKPARAM}     ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        SMS          NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO     NO
    ${SMS}=             Get Parameter Value             ${PARAMETER}        SMS
    ${SMS}=             Verify Parameter Value          ${SMS}              ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${SMS}' != 'NO' and '${ASSIGNTO}' != 'NO'              Set Test Variable           ${CHECKPARAM}       ${TRUE}
    ${OTP}=             Run Keyword If  ${CHECKPARAM} == True               Get OTP eService            ${SMS}
    Run Keyword If  '${OTP}' == 'None'                  Set Test Variable   ${GETOTP}                   False
    ${STATUS}=          Run Keyword And Return Status                       Add Dictionary Assignment   ${ASSIGNTO}         ${OTP}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get OTP from message  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Get OTP from message success (your OTP is ${OTP})  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get OTP from message not success (check parameter sms and assign to)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        ${SMS}
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False or ${GETOTP} == False     Set Global Variable     ${FLAGRUNRESULT}    False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True and ${GETOTP} == True      Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Get OTP eService   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}    ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get OTP eService   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB GET MA START TIME
#Create by Chayut  24/02/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${CAMPAIGNRESPONSE}     None
    Set Test Variable   ${ASSIGNTO}             None
    Set Test Variable   ${CHECKPARAM}           ${FALSE}
    ${PARAMETER}=           Additional Parameter Value      ${PARAMETER}            CAMPAIGNRESPONSE            NO
    ${PARAMETER}=           Additional Parameter Value      ${PARAMETER}            ASSIGNTO                    NO
    ${CAMPAIGNRESPONSE}=    Get Parameter Value             ${PARAMETER}            CAMPAIGNRESPONSE
    ${CAMPAIGNRESPONSE}=    Verify Parameter Value          ${CAMPAIGNRESPONSE}     ${RUNITER}
    ${ASSIGNTO}=            Get Parameter Value             ${PARAMETER}             ASSIGNTO
    ${ASSIGNTO}=            Verify Parameter Value          ${ASSIGNTO}             ${RUNITER}
    Run Keyword If  '${CAMPAIGNRESPONSE}' != 'NO' and '${ASSIGNTO}' != 'NO'         Set Test Variable           ${CHECKPARAM}       ${TRUE}
    ${TIMEMA}=  Run Keyword If  ${CHECKPARAM} == True       Get Time Start MA       ${CAMPAIGNRESPONSE}
    ${STATUS}=  Run Keyword If  '${TIMEMA}' != '${EMPTY}' and '${TIMEMA}' != 'None'     Run Keyword And Return Status       Add Dictionary Assignment       ${ASSIGNTO}         ${TIMEMA}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get MA start time  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Start MA success on time : [ ${TIMEMA} ]  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Start MA not success (check parameter campaign reponse and assign to)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Get MA Start Time   ${EXPECTED}   ${ACTUALPASS}    PASSED     ${INDEXSHOT}    ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Get MA Start Time   ${EXPECTED}   ${ACTUALFAIL}    FAILED     ${INDEXSHOT}    ${INDEXLOGFILE}

RAT WEB CHECK SUBSCRIBER START MA EVENT
#Create by Chayut  24/02/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${STARTTIME}            None
    Set Test Variable   ${COLUMNEVENT}          Event name
    Set Test Variable   ${COLUMNEFFTIME}        Effective time
    Set Test Variable   ${RESULTCOLEVENT}       ${0}
    Set Test Variable   ${RESULTCOLEFFTIME}     ${0}
    Set Test Variable   ${FLAGCHECK}            ${FALSE}
    Set Test Variable   ${FLAGCOLEVENT}         ${FALSE}
    Set Test Variable   ${FLAGCOLEFFTIME}       ${FALSE}
    Set Test Variable   ${CHECKPARAM}           ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        STARTTIME           NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TIMEDIFF            NO
    ${STARTTIME}=       Get Parameter Value             ${PARAMETER}        STARTTIME
    ${STARTTIME}=       Verify Parameter Value          ${STARTTIME}        ${RUNITER}
    ${TIMEDIFF}=        Get Parameter Value             ${PARAMETER}        TIMEDIFF
    ${TIMEDIFF}=        Verify Parameter Value          ${TIMEDIFF}         ${RUNITER}
    Run Keyword If  '${STARTTIME}' != 'NO' and '${TIMEDIFF}' != 'NO'        Set Test Variable   ${CHECKPARAM}       ${TRUE}
    @{INLOOP}=          Run Keyword If  ${CHECKPARAM} == True               Create List         1   2   3   4   5   6   7   8   9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25
    ...     ELSE        Create List         0
    ${COUNTCOL}=        Run Keyword If  ${CHECKPARAM} == True               Get Matching Xpath Count        //div[@class='hdrcell']
    ...     ELSE        Evaluate    ${0}+${0}
    ${COUNTTABLE}=      Run Keyword If  ${CHECKPARAM} == True               Get Matching Xpath Count        //table[contains(@class, 'obj row20px')]
    ...     ELSE        Evaluate    ${0}+${0}
    :FOR    ${ITABLE}   IN RANGE    1    ${COUNTTABLE} + 1
    \   ${STATUS}=      Run Keyword And Return Status   Wait Until Element Is Visible       xpath=(//table[contains(@class, 'obj row20px')])[${ITABLE}]             1
    \   Run Keyword If      ${STATUS} == True           Set Test Variable                   ${EXPECTEDTABLE}       ${ITABLE}
    \   Run Keyword If      ${STATUS} == True           Exit For Loop
    :FOR    ${ICOL}     IN RANGE    1    ${COUNTCOL} + 1
    \   ${COLUMNVALUE}=     Get Text        xpath=(//div[@class='hdrcell'])[${ICOL}]
    \   Run Keyword If  '${COLUMNVALUE}' != '${EMPTY}' and ${FLAGCOLEVENT} == False         Set Test Variable   ${RESULTCOLEVENT}      ${RESULTCOLEVENT+1}
    \   Run Keyword If  '${COLUMNVALUE}' != '${EMPTY}' and ${FLAGCOLEFFTIME} == False       Set Test Variable   ${RESULTCOLEFFTIME}    ${RESULTCOLEFFTIME+1}
    \   Run Keyword If  '${COLUMNVALUE}' == '${COLUMNEVENT}'     Set Test Variable   ${FLAGCOLEVENT}        ${TRUE}
    \   Run Keyword If  '${COLUMNVALUE}' == '${COLUMNEFFTIME}'   Set Test Variable   ${FLAGCOLEFFTIME}      ${TRUE}
    \   Run Keyword If  ${FLAGCOLEVENT} == True and ${FLAGCOLEFFTIME} == True        Exit For Loop
    :FOR    ${ILOOP}     IN      @{INLOOP}
    \   Run Keyword If   '${ILOOP}' == '0'              Exit For Loop
    \   ${CHKTABLE}=     Run Keyword And Return Status          Wait Until Element Is Visible       xpath=(//table[contains(@class, 'obj row20px')])[${EXPECTEDTABLE}]      1
    \   ${CHECKSEARCH}=  Run Keyword If   ${CHKTABLE} == True   Get Matching Xpath Count            //*[contains(@id,'closeDotcontrolsopen0closeDotcontrolsopen0close_linkFilter')]
    \   Run Keyword If   '${CHECKSEARCH}' != '1'                Click Element                       xpath=(//*[contains(@id,'closeDotcontrolsopen0closeDotcontrolsopen0close_linkFilter')])[2]
    \   ...         ELSE    Click Element   xpath=(//*[contains(@id,'closeDotcontrolsopen0closeDotcontrolsopen0close_linkFilter')])[1]
    \   ${CELLEVENTVALUE}=      Run Keyword If   ${CHKTABLE} == True   Get Table Cell                      xpath=(//table[contains(@class, 'obj row20px')])[${EXPECTEDTABLE}]      2        ${RESULTCOLEVENT}           loglevel=DEBUG
    \   ${CELLEFFTIMEVALUE}=    Run Keyword If   ${CHKTABLE} == True   Get Table Cell                      xpath=(//table[contains(@class, 'obj row20px')])[${EXPECTEDTABLE}]      2        ${RESULTCOLEFFTIME}         loglevel=DEBUG
    \   ${RESULTCOMPARETIME}=   Verify Start MA with Effective Time     ${CELLEFFTIMEVALUE}     ${STARTTIME}        ${TIMEDIFF}
    \   Run Keyword If  '${CELLEVENTVALUE}' == 'Activate Product Upon Optin Marketing Activity Start Event' and ${RESULTCOMPARETIME} == True        Set Test Variable        ${FLAGCHECK}                ${TRUE}
    \   Run Keyword If  '${CELLEVENTVALUE}' == 'Activate Product Upon Optin Marketing Activity Start Event' and ${RESULTCOMPARETIME} == True        Exit For Loop
    \   ...         ELSE    Sleep       15s
    Log                 Check Event Start MA : >>> ${FLAGCHECK} (Start Time : ${STARTTIME} | Effective Time : ${CELLEFFTIMEVALUE})
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Check subscriber start MA event  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Check subscriber start MA event success (start time : ${STARTTIME} | effective time : ${CELLEFFTIMEVALUE})  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Check subscriber start MA event not success (not have start MA event in 5 min.)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${FLAGCHECK} == False   Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${FLAGCHECK} == True    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Check Subscriber Start MA Event   ${EXPECTED}   ${ACTUALPASS}    PASSED     ${INDEXSHOT}    ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Check Subscriber Start MA Event   ${EXPECTED}   ${ACTUALFAIL}    FAILED     ${INDEXSHOT}    ${INDEXLOGFILE}

RAT WEB CHECK FOUND VALUE IN TABLE
#Create by Chayut  24/02/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${COLUMNNAME}           None
    Set Test Variable   ${VERIFYVALUE}          None
    Set Test Variable   ${TIMEOUT}              None
    Set Test Variable   ${RESULTCOL}            ${0}
    Set Test Variable   ${FLAGCHECK}            ${FALSE}
    Set Test Variable   ${CHECKPARAM}           ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        COLUMNNAME              NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        VALUE                   NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TIMEOUT                 NO
    ${COLUMNNAME}=      Get Parameter Value             ${PARAMETER}        COLUMNNAME
    ${COLUMNNAME}=      Verify Parameter Value          ${COLUMNNAME}       ${RUNITER}
    ${VERIFYVALUE}=     Get Parameter Value             ${PARAMETER}        VALUE
    ${VERIFYVALUE}=     Verify Parameter Value          ${VERIFYVALUE}      ${RUNITER}
    ${TIMEOUT}=         Get Parameter Value             ${PARAMETER}        TIMEOUT
    ${TIMEOUT}=         Verify Parameter Value          ${TIMEOUT}          ${RUNITER}
    Run Keyword If  '${COLUMNNAME}' != 'NO' and '${VERIFYVALUE}' != 'NO' and '${TIMEOUT}' != 'NO'   Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${COUNTCOL}=        Run Keyword If  ${CHECKPARAM} == True               Get Matching Xpath Count        //div[@class='hdrcell']
    ...     ELSE        Evaluate    ${0}+${0}
    ${COUNTTABLE}=      Run Keyword If  ${CHECKPARAM} == True               Get Matching Xpath Count        //table[contains(@class, 'obj row20px')]
    ...     ELSE        Evaluate    ${0}+${0}
    :FOR    ${ITABLE}   IN RANGE    1    ${COUNTTABLE} + 1
    \   ${STATUS}=      Run Keyword And Return Status   Wait Until Element Is Visible       xpath=(//table[contains(@class, 'obj row20px')])[${ITABLE}]             1
    \   Run Keyword If      ${STATUS} == True           Set Test Variable                   ${EXPECTEDTABLE}       ${ITABLE}
    \   Run Keyword If      ${STATUS} == True           Exit For Loop
    :FOR    ${ICOL}     IN RANGE    1    ${COUNTCOL} + 1
    \   ${COLUMNVALUE}=     Get Text        xpath=(//div[@class='hdrcell'])[${ICOL}]
    \   Run Keyword If  '${COLUMNVALUE}' != '${EMPTY}'          Set Test Variable   ${RESULTCOL}    ${RESULTCOL+1}
    \   Run Keyword If  '${COLUMNVALUE}' == '${COLUMNNAME}'     Exit For Loop
    :FOR    ${ILOOP}    IN RANGE    1    ${TIMEOUT} + 1
    \   ${CHKTABLE}=     Run Keyword And Return Status          Wait Until Element Is Visible       xpath=(//table[contains(@class, 'obj row20px')])[${EXPECTEDTABLE}]      1
    \   ${CHECKSEARCH}=  Run Keyword If   ${CHKTABLE} == True   Get Matching Xpath Count            //*[contains(@id,'closeDotcontrolsopen0closeDotcontrolsopen0close_linkFilter')]
    \   Run Keyword If   '${CHECKSEARCH}' != '1'                Click Element                       xpath=(//*[contains(@id,'closeDotcontrolsopen0closeDotcontrolsopen0close_linkFilter')])[2]
    \   ...         ELSE    Click Element   xpath=(//*[contains(@id,'closeDotcontrolsopen0closeDotcontrolsopen0close_linkFilter')])[1]
    \   ${CELLVALUE}=    Run Keyword If   ${CHKTABLE} == True   Get Table Cell                      xpath=(//table[contains(@class, 'obj row20px')])[${EXPECTEDTABLE}]      2        ${RESULTCOL}           loglevel=DEBUG
    \   Run Keyword If  '${CELLVALUE}' == '${VERIFYVALUE}'      Set Test Variable                   ${FLAGCHECK}                ${TRUE}
    \   Run Keyword If  '${CELLVALUE}' == '${VERIFYVALUE}'      Exit For Loop
    \   ...         ELSE    Sleep       1s
    Log                 Check Found Value In Talbe : >>> ${FLAGCHECK} (Column : ${COLUMNNAME} | Value : ${VERIFYVALUE})
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Check found value in table  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Check found value in table success (column : ${COLUMNNAME} | value : ${VERIFYVALUE})  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Check found value in table not success (not have value ${VERIFYVALUE} on column ${COLUMNNAME} in time ${TIMEOUT} sec.)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${FLAGCHECK} == False   Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${FLAGCHECK} == True    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Check Found Value In Table   ${EXPECTED}   ${ACTUALPASS}    PASSED     ${INDEXSHOT}    ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Check Found Value In Table   ${EXPECTED}   ${ACTUALFAIL}    FAILED     ${INDEXSHOT}    ${INDEXLOGFILE}

RAT WEB SORTING DATA BY COLUMN
#Create by Chayut  02/02/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${COLUMNNAME}       None
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${FLAGCLICKCOL}     False
    Set Test Variable   ${RESULTCOL}        ${0}
    Set Test Variable   ${RESULTROW}        ${0}
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        COLUMNNAME          NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO            NO
    ${COLUMNNAME}=      Get Parameter Value             ${PARAMETER}        COLUMNNAME
    ${COLUMNNAME}=      Verify Parameter Value          ${COLUMNNAME}       ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${COLUMNNAME}' != 'NO' and '${ASSIGNTO}' != 'NO'       Set Test Variable   ${CHECKPARAM}       ${TRUE}
    Run Keyword If   ${CHECKPARAM} == True              Create Dictionary Datasorted
    ${COUNTCOL}=        Get Matching Xpath Count        //div[@class='hdrcell']
    ${TOTALROW}=        Get Text                        //td[contains(@id, 'closeDotcontrolsopen0closeDotcontrolsopen0close_noItemsPlaceHolderCell')]
    ${TOTALROW}=        Replace Empty String            ${TOTALROW}         Number of items found:
    ${COUNTROW}=        Convert To Integer              ${TOTALROW}
    ${COUNTTABLE}=      Get Matching Xpath Count        //table[contains(@class, 'obj row20px')]
    :FOR    ${ITABLE}   IN RANGE    1    ${COUNTTABLE} + 1
    \   ${STATUS}=      Run Keyword And Return Status   Wait Until Element Is Visible       xpath=(//table[contains(@class, 'obj row20px')])[${ITABLE}]             1
    \   Run Keyword If      ${STATUS} == True           Set Test Variable                   ${EXPECTEDTABLE}       ${ITABLE}
    \   Run Keyword If      ${STATUS} == True           Exit For Loop
    :FOR    ${ICOL}     IN RANGE    1    ${COUNTCOL} + 1
    \   ${COLUMNVALUE}=     Get Text        xpath=(//div[@class='hdrcell'])[${ICOL}]
    \   Run Keyword If  '${COLUMNVALUE}' != '${EMPTY}'          Set Test Variable   ${RESULTCOL}    ${RESULTCOL+1}
    \   Run Keyword If  '${COLUMNVALUE}' == '${COLUMNNAME}'     Exit For Loop
    :FOR    ${IROW}     IN RANGE    2    ${COUNTROW}
    \   ${CHKTABLE}=    Run Keyword And Return Status     Wait Until Element Is Visible     xpath=(//table[contains(@class, 'obj row20px')])[${EXPECTEDTABLE}]      1
    \   Run Keyword If  ${CHKTABLE} == True         Mouse Over          xpath=(//table[contains(@class, 'obj row20px')])[${EXPECTEDTABLE}]
    \   Run Keyword If  ${CHKTABLE} == True         Press Key           xpath=(//table[contains(@class, 'obj row20px')])[${EXPECTEDTABLE}]          \\13
    \   ${CELLVALUE}=   Run Keyword If   ${CHKTABLE} == True            Get Table Cell       xpath=(//table[contains(@class, 'obj row20px')])[${EXPECTEDTABLE}]      ${IROW}        ${RESULTCOL}       loglevel=DEBUG
    \   Run Keyword If  ${CHKTABLE} == True         Set Test Variable               ${RESULTROW}        ${RESULTROW+1}
    \   Run Keyword If  ${CHKTABLE} == True         Add Dictionary Datasorted       ${RESULTROW}        ${CELLVALUE}
    ${RESULTVALUE}=     Sorted Datadictonary By Value
    Log                 Result max row value : >>> ${RESULTVALUE}
    ${STATUS}=          Run Keyword And Return Status               Add Dictionary Assignment       ${ASSIGNTO}         ${RESULTVALUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Sorting data by column : ${COLUMNNAME}  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Sorting data by column success max value at row : ${RESULTVALUE}  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Sorting data by column not success on columne : ${COLUMNNAME}  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False     Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True      Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Sorting data by column   ${EXPECTED}   ${ACTUALPASS}    PASSED     ${INDEXSHOT}    ${INDEXLOGFILE}
    ...         ELSE    Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}  ${POSID}   Sorting data by column   ${EXPECTED}   ${ACTUALFAIL}    FAILED     ${INDEXSHOT}    ${INDEXLOGFILE}

RAT WEB SELECT ROW IN TABLE
#Create By Nam 31/01/2017
    [Arguments]         ${PARAMETER}    ${RUNITER}
    Set Test Variable   ${ROW}              None
    Set Test Variable   ${FLAGFOUND}        False
    Set Test Variable   ${COUNTVALUE}       ${0}
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ROW             NO
    ${ROW}=             Get Parameter Value             ${PARAMETER}        ROW
    ${ROW}=             Verify Parameter Value          ${ROW}              ${RUNITER}
    Run Keyword If      '${ROW}' != 'NO'                Set Test Variable   ${CHECKPARAM}   ${TRUE}
    ${COUNTROW}=        Get Matching Xpath Count        //tr[@grid='[object Object]']
    :FOR    ${IROW}     IN RANGE    1    ${COUNTROW} +1
    \   ${STATUS}=      Run Keyword And Return Status      Wait Until Element Is Visible    xpath=(//tr[@grid='[object Object]'])[${IROW}]      1
    \   Log             RealRow:= ${IROW} | Status:= ${STATUS}
    \   Run Keyword If  ${STATUS} == True             Set Test Variable       ${COUNTVALUE}         ${COUNTVALUE+1}
    \   Run Keyword If  ${COUNTVALUE} == ${ROW}       Click Element           xpath=(//tr[@grid='[object Object]'])[${IROW}]
    \   Run Keyword If  ${COUNTVALUE} == ${ROW}       Set Test Variable       ${FLAGFOUND}    True
    \   Run Keyword If  ${FLAGFOUND} == True          Exit For Loop
    Log                 Click On Real Row >>> ${COUNTVALUE}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Select row table  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Select row it success [ ${COUNTVALUE} ]  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Select row not success (check parameter row or table web)  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        None
    Run Keyword If  ${FLAGFOUND} == False or ${CHECKPARAM} == False     Set Global Variable         ${FLAGFOUND}        False
    Run Keyword If  ${FLAGFOUND} == True and ${CHECKPARAM} == True      Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select row table   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Select row table   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB VERIFY COLUMN NAME FROM TABLE
#Create by wimow : 31/12/2017
    [Arguments]         ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${COLUMNNAME}       None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        COLUMNNAME             NO
    ${COLUMNNAME}=      Get Parameter Value             ${PARAMETER}        COLUMNNAME
    ${COLUMNNAME}=      Verify Parameter Value          ${COLUMNNAME}       ${RUNITER}
    Run Keyword If  '${COLUMNNAME}' != 'NO'             Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${COUNTCOL}=        Get Matching Xpath Count        //div[@class='hdrcell']
    :FOR    ${ICOL}     IN RANGE    1    ${COUNTCOL} + 1
    \   ${COLUMNVALUE}=       Get Text                  xpath=(//div[@class='hdrcell'])[${ICOL}]
    \   Run Keyword If  '${COLUMNVALUE}' == '${COLUMNNAME}'   Set Test Variable   ${FLAGVERIFY}       True
    \   Run Keyword If  '${COLUMNVALUE}' == '${COLUMNNAME}'   Exit For Loop
    # Write logger report function
    ${EXPECTED}=     Plus Connect String     Verify column name : ${COLUMNNAME}  .
    ${ACTUALPASS}=   Plus Connect String     Passed, Verify column name success value  .
    ${ACTUALFAIL}=   Plus Connect String     Failed, Verify column name not success value  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${FLAGVERIFY} == False or ${CHECKPARAM} == False     Set Global Variable         ${FLAGRUNRESULT}    False
    Run Keyword If  ${FLAGVERIFY} == True and ${CHECKPARAM} == True      Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Verify column name from table   ${EXPECTED}   ${ACTUALPASS}    PASSED     ${INDEXSHOT}     ${INDEXLOGFILE}
    ...         ELSE       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Verify column name from table   ${EXPECTED}   ${ACTUALFAIL}    FAILED     ${INDEXSHOT}     ${INDEXLOGFILE}

RAT WEB SPLIT TEXT DATE
#Create By Sudaws49 31/01/2017
    [Arguments]         ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${MESSAGE}          None
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${GETVALUE}         None
    Set Test Variable   ${SPLITVALUE}       None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        MESSAGE         NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO        NO
    ${MESSAGE}=         Get Parameter Value             ${PARAMETER}        MESSAGE
    ${MESSAGE}=         Verify Parameter Value          ${MESSAGE}          ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${MESSAGE}' != 'NO' and '${ASSIGNTO}' != 'NO'          Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${SPLITVALUE}=      Split Date                      ${MESSAGE}
    ${GETVALUE}=        Replace Date                    ${SPLITVALUE}
    ${STATUS}=          Verify None Parameter Value     ${SPLITVALUE}
    Run Keyword If      ${STATUS} != True      Add Dictionary Assignment      ${ASSIGNTO}      ${GETVALUE}
    # Log debug for dev function
    Log     MESSAGE= ${MESSAGE} | ASSIGNTO= ${ASSIGNTO} | GETVALUE= ${GETVALUE} >>> SPLIT TEXT DATE := ${STATUS}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Message value  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Split date value : ${GETVALUE} success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Split date not success (check parameter message or assing to)  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    ${MESSAGE}
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False     Set Global Variable         ${FLAGRUNRESULT}     False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True      Write Text Log  ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Split date value   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Split date value   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB GET CURRENT PACKAGE
# Create by Chayut 1/2/2017
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${ALLPACKAGE}       None
    Set Test Variable   ${EXPIREDATE}       None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=           Additional Parameter Value      ${PARAMETER}        ASSIGNTO         NO
    ${ASSIGNTO}=            Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=            Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${ASSIGNTO}' != 'NO'                   Set Test Variable   ${CHECKPARAM}   ${TRUE}
    ${STATUSCHECKPANEL}=    Run Keyword And Return Status        Wait Until Element Is Visible       id=panelCurrentPackage
    ${COUNTPACKAGE}=        Get Matching Xpath Count    //label[@ng-bind-html='package.name | stripLine']
    ${COUNTDATEREGIS}=      Get Matching Xpath Count    //*[contains(@class,'package_date hidden_mobile')]
    ${COUNTREMINING}=       Get Matching Xpath Count    //span[@ng-bind-html='remainingItem.description |stripLine']
    :FOR    ${IPACK}    IN RANGE    1    ${COUNTPACKAGE} + 1
    \   ${PACKNAME}=        Get Text                    xpath=(//label[@ng-bind-html='package.name | stripLine'])[${IPACK}]
    \   ${REGISDATE}=       Get Text                    xpath=(//*[contains(@class,'package_date hidden_mobile')])[${IPACK}]
    \   ${REGISDATE}=       Get Registerdate Package    ${REGISDATE}
    \   ${EXPIREDATE}=      Run Keyword If  ${IPACK} != 1   Get Text            xpath=(//*[contains(@id,'txtRemainingExpiryNote')])[${IPACK}-1]
    \   ${EXPIREDATE}=      Run Keyword If  ${IPACK} != 1   Get Expiredate Package              ${EXPIREDATE}
    \   Log         Package : ${PACKNAME} : ${REGISDATE}
    \   ${ALLPACKAGE}=      Update Inolder String       ${ALLPACKAGE}       ${PACKNAME} !! ${REGISDATE} !! ${EXPIREDATE}      @@
    Log             Data Package := [${ALLPACKAGE}]
    ${STATUSASSIGN}=        Run Keyword And Return Status       Add Dictionary Assignment     ${ASSIGNTO}         ${ALLPACKAGE}
    # Write logger report function
    ${ITERSEQ}=     Get Sequence Iteration      ${RUNITER}
    ${TIMETEST}=    Get Logtime Now
    ${POSID}=       Plus Connect String     L     ${TIMETEST}
    ${EXPECTED}=    Plus Connect String     Get current package and promotion  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Get package and promotion detail (see more detail in log file)  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get package and promotion detail not success  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    ${ALLPACKAGE}
    Run Keyword If  ${STATUSASSIGN} == False or ${CHECKPARAM} == False      Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If  ${STATUSASSIGN} == True and ${CHECKPARAM} == True       Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get current package and promotion   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get current package and promotion   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB GET VALUE IN TABLE
#Create by wimow : 01/02/2017
    [Arguments]         ${PARAMETER}            ${RUNITER}
    Set Test Variable   ${TABLENAME}            None
    Set Test Variable   ${DATANAME}             None
    Set Test Variable   ${ASSIGNTO}             None
    Set Test Variable   ${VALUE}                None
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TABLENAME       NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        DATANAME        NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO        NO
    ${TABLENAME}=       Get Parameter Value             ${PARAMETER}        TABLENAME
    ${TABLENAME}=       Verify Parameter Value          ${TABLENAME}        ${RUNITER}
    ${DATANAME}=        Get Parameter Value             ${PARAMETER}        DATANAME
    ${DATANAME}=        Verify Parameter Value          ${DATANAME}         ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${TABLENAME}' != 'NO' and '${DATANAME}' != 'NO' and '${ASSIGNTO}' != 'NO'      Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${COUNTROW}=        Get Matching Xpath Count        //div[@class='hdrcell']
    Log                 xpath locator : >>>> &{ELEMENT}[${TABLENAME}]
    :FOR    ${IROW}    IN RANGE    1    ${COUNTROW}
    \   ${CHECKTABLE}=      Run Keyword and Return Status       Wait Until Element Is Visible       &{ELEMENT}[${TABLENAME}]        20
    \   ${NAMEVALUE}=       Get Table Cell                      &{ELEMENT}[${TABLENAME}]            ${IROW}                         1             loglevel=DEBUG
    \   Log                 Cell Data Name : >>>> ${NAMEVALUE}
    \   ${NAMEVALUE} =      Replace Empty String                ${NAMEVALUE}        :
    \   ${VALUE}=           Run Keyword If  '${NAMEVALUE}' == '${DATANAME}'     Get Table Cell    &{ELEMENT}[${TABLENAME}]          ${IROW}         2           loglevel=DEBUG
    \   Log                 Cell Data Value : >>>> ${VALUE}
    \   Run Keyword If  '${NAMEVALUE}' == '${DATANAME}'         Exit For Loop
    ${STATUS}=  Run Keyword If  ${CHECKTABLE} == False          Set Test Variable               ${STATUS}           False
    ...         ELSE        Run Keyword and Return Status       Add Dictionary Assignment       ${ASSIGNTO}         ${VALUE}
    # Log debug for dev function
    Log     DATANAME= ${DATANAME} | ASSIGNTO= ${VALUE} >>> GET VALUE IN TABLE := ${STATUS}
# Write logger report function
    ${EXPECTED}=            Plus Connect String     Get value column name : ${DATANAME}  .
    ${ACTUALPASS}=          Plus Connect String     Passed, Get value in table success value is : ${VALUE}  .
    ${ACTUALFAIL}=          Plus Connect String     Failed, Get value in table not success on column ${DATANAME}  .
    LOG IMAGE       ${PARAMETER}
    LOG TXT FILE    None
    Run Keyword If  ${STATUS} == False or ${CHECKPARAM} == False    Set Global Variable     ${FLAGRUNRESULT}    False
    Run Keyword If  ${STATUS} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get value in table   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE        Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get value in table   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB GET USSD NUMBER
#Create By Panumas (Nueng) 2017/01/31
    [Arguments]    ${PARAMETER}        ${RUNITER}
    Set Test Variable   ${TXT}              None
    Set Test Variable   ${ASSIGNTO}         None
    Set Test Variable   ${GETUSSD}          ${TRUE}
    Set Test Variable   ${CHECKPARAM}       ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TXT             NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        ASSIGNTO        NO
    ${TXT}=             Get Parameter Value             ${PARAMETER}        TXT
    ${TXT}=             Verify Parameter Value          ${TXT}              ${RUNITER}
    ${ASSIGNTO}=        Get Parameter Value             ${PARAMETER}        ASSIGNTO
    ${ASSIGNTO}=        Verify Parameter Value          ${ASSIGNTO}         ${RUNITER}
    Run Keyword If  '${TXT}' != 'NO' and '${ASSIGNTO}' != 'NO'              Set Test Variable   ${CHECKPARAM}       ${TRUE}
    ${USSD}=            Split USSD Code                 ${TXT}
    Run Keyword If  '${USSD}' == 'None'                 Set Test Variable   ${GETUSSD}      ${FALSE}
    ${STATUS}=      Run Keyword And Return Status       Add Dictionary Assignment           ${ASSIGNTO}             ${USSD}
    # Log debug for dev function
    Log    TEXT= ${TXT} | GETUSSD= ${GETUSSD} | ASSIGNTO= ${ASSIGNTO} >>> Get USSD Number:= ${USSD}
# Write logger report function
    ${EXPECTED}=        Plus Connect String         Get USSD from message  .
    ${ACTUALPASS}=      Plus Connect String         Passed, Get USSD from message success (your USSD is ${USSD})  .
    ${ACTUALFAIL}=      Plus Connect String         Failed, Get USSD from message not success  (check USSD on log file)
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        ${TXT}
    Run Keyword If  ${GETUSSD} == False or ${CHECKPARAM} == False       Set Global Variable       ${FLAGRUNRESULT}   False
    Run Keyword If  ${GETUSSD} == True and ${CHECKPARAM} == True        Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Split USSD Code   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}     Split USSD Code   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB GET TABLE DETAIL
#Create by poonsirc : 03/02/2017
    [Arguments]         ${PARAMETER}            ${RUNITER}
    Set Test Variable   ${TABLENAME}            None
    Set Test Variable   ${VALUE}                None
    Set Test Variable   ${REPORTLOG}            None
    Set Test Variable   ${COUNTVISIBLE}         ${0}
    Set Test Variable   ${CHECKPARAM}           ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        TABLENAME               NO
    ${TABLENAME}=       Get Parameter Value             ${PARAMETER}        TABLENAME
    ${TABLENAME}=       Verify Parameter Value          ${TABLENAME}        ${RUNITER}
    Run Keyword If  '${TABLENAME}' != 'NO'              Set Test Variable   ${CHECKPARAM}           ${TRUE}
    ${COUNTROW}=        Get Matching Xpath Count        //div[@class='hdrcell']
    Log                 xpath locator : >>>> &{ELEMENT}[${TABLENAME}]
    :FOR    ${IROW}    IN RANGE    1    ${COUNTROW}
    \   ${CHECKVISIBLE}=     Run Keyword and Return Status       Wait Until Element Is Visible       xpath=(//div[@class='hdrcell'])[${IROW}]         1
    \   Run Keyword If   ${CHECKVISIBLE} == True     Set Test Variable   ${COUNTVISIBLE}             ${COUNTVISIBLE+1}
    Log     Visible Table Row : >>> ${COUNTVISIBLE}
    :FOR    ${IVISIBLEROW}   IN RANGE    1    ${COUNTVISIBLE}
    \   ${CHECKTABLE}=       Run Keyword and Return Status       Wait Until Element Is Visible       &{ELEMENT}[${TABLENAME}]         20
    \   ${NAMEVALUE}=        Run Keyword If    ${CHECKTABLE} == True        Get Table Cell           &{ELEMENT}[${TABLENAME}]         ${IVISIBLEROW}             1             loglevel=DEBUG
    \   ${VALUE}=            Run Keyword If    ${CHECKTABLE} == True        Get Table Cell           &{ELEMENT}[${TABLENAME}]         ${IVISIBLEROW}             2             loglevel=DEBUG
    \   Log                  Cell Data : >>>> ${NAMEVALUE} : ${VALUE}
    \   ${REPORTLOG}=        Run Keyword If    ${CHECKTABLE} == True        Update Older String With Ascii      ${REPORTLOG}           ${NAMEVALUE}${VALUE}      10
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Get table detail : ${TABLENAME}  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Get table detail success  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Get table detail not success  .
    LOG IMAGE           ${PARAMETER}
    LOG TXT FILE        ${REPORTLOG}
    Run Keyword If  ${CHECKTABLE} == False or ${CHECKPARAM} == False    Set Global Variable         ${FLAGRUNRESULT}    False
    Run Keyword If  ${CHECKTABLE} == True and ${CHECKPARAM} == True     Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}    Get value in table   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE        Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Get value in table   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}

RAT WEB VERIFY BENEFIT PACKAGE
    [Arguments]         ${PARAMETER}    ${RUNITER}
    Set Test Variable   ${CURR_PACK}            None
    Set Test Variable   ${BENEFIT_PACK}         None
    Set Test Variable   ${BENEFIT_EXPIRE_DT}    None
    Set Test Variable   ${LANGUAGE}             None
    Set Test Variable   ${CHECKPARAM}           ${FALSE}
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        CURR_PACK               NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        BENEFIT_PACK            NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        BENEFIT_EXPIRE_DT       NO
    ${PARAMETER}=       Additional Parameter Value      ${PARAMETER}        LANGUAGE                NO
    ${CURR_PACK}=       Get Parameter Value             ${PARAMETER}        CURR_PACK
    ${CURR_PACK}=       Verify Parameter Value          ${CURR_PACK}        ${RUNITER}
    ${BENEFIT_PACK}=    Get Parameter Value             ${PARAMETER}        BENEFIT_PACK
    ${BENEFIT_PACK}=    Verify Parameter Value          ${BENEFIT_PACK}     ${RUNITER}
    ${BENEFIT_EXPIRE_DT}=    Get Parameter Value        ${PARAMETER}            BENEFIT_EXPIRE_DT
    ${BENEFIT_EXPIRE_DT}=    Verify Parameter Value     ${BENEFIT_EXPIRE_DT}    ${RUNITER}
    ${LANGUAGE}=         Get Parameter Value            ${PARAMETER}        LANGUAGE
    ${LANGUAGE}=         Verify Parameter Value         ${LANGUAGE}         ${RUNITER}
    Run Keyword If   '${CURR_PACK}' != 'NO' and '${BENEFIT_PACK}' != 'NO' and '${BENEFIT_EXPIRE_DT}' != 'NO' and '${LANGUAGE}' != 'NO'     Set Test Variable   ${CHECKPARAM}           ${TRUE}
    ${BENEFIT_EXPIRE_DT}=    Run Keyword If   ${CHECKPARAM} == True         Convert Date            ${BENEFIT_EXPIRE_DT}        result_format=%d/%m/%Y
    ${RESULT}=          Run Keyword If   ${CHECKPARAM} == True              Verify Benefit Package  ${CURR_PACK}        ${BENEFIT_PACK}         ${BENEFIT_EXPIRE_DT}        ${LANGUAGE}
    # Log debug for dev function
    Log   CURR_PACK= ${CURR_PACK} | BENEFIT_PACK= ${BENEFIT_PACK} | BENEFIT_EXPIRE_DT= ${BENEFIT_EXPIRE_DT} >>> Get Verify Benefit Package := ${STATUS}
# Write logger report function
    ${EXPECTED}=        Plus Connect String     Expected Result is : '${RESULT}'  .
    ${ACTUALPASS}=      Plus Connect String     Passed, Result Success is : '${RESULT}'  .
    ${ACTUALFAIL}=      Plus Connect String     Failed, Result Fail is : '${BENEFIT_PACK}' '${BENEFIT_EXPIRE_DT}'  .
    LOG IMAGE           None
    LOG TXT FILE        None
    Run Keyword If   ${RESULT} == False or ${CHECKPARAM} == False       Set Global Variable     ${FLAGRUNRESULT}   False
    Run Keyword If   ${RESULT} == True and ${CHECKPARAM} == True        Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Verify Benefit Package   ${EXPECTED}   ${ACTUALPASS}   PASSED   ${INDEXSHOT}   ${INDEXLOGFILE}
    ...         ELSE    Write Text Log   ${TXTLOG}   ${REPORTID}   ${ITERSEQ}   ${POSID}   Verify Benefit Package   ${EXPECTED}   ${ACTUALFAIL}   FAILED   ${INDEXSHOT}   ${INDEXLOGFILE}