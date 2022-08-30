*** Settings ***
Documentation    All Libraries for example test 

Resource    libraries/excell.robot
Resource    libraries/mandatory.robot
Resource    libraries/pagefactory.robot

Library    DateTime
Library    OperatingSystem

*** Keywords ***

Check URLs and Report Status in excell
    [Documentation]    Iterates through all rows in excell file and reads all columns
    FOR    ${i}    IN RANGE    2    ${ROW_LENGTH}
        ${url}    Read Excel Cell    ${i}    1
        ${text}    Read Excel Cell    ${i}    2
        ${status}=    Run Keyword And Return Status    Navigate ${url} and expect ${text} in page
        IF   ${status}==False
            Write Excel Cell    ${i}    4    FAIL    ${SHEET_NAME}
            Write Excel Cell    ${i}    5    No element found with given text. Keyword Failed    ${SHEET_NAME}
            Log To Console    \n ${url} NOT PASSED
            ${FAILED_TEST_COUNT}=    Evaluate    ${FAILED_TEST_COUNT}+${ONE}
        END
        IF   ${status}==True
            Log To Console    \n ${url} PASSED
            Write Excel Cell    row_num=${i}    col_num=4    value=PASS    sheet_name=${SHEET_NAME}
            ${PASSED_TEST_COUNT}=    Evaluate    ${PASSED_TEST_COUNT+1}+${ONE}
        END
    END
    ${date}=      Get Current Date      UTC      exclude_millis=yes
    ${converted}=      Convert Date      ${date}      result_format=%a%B%d_%H%M
    ${filename}=    Convert To String    ${converted}.xlsx
    Save Excel    ${filename}
    IF    ${FAILED_TEST_COUNT}!=0
    Fail    msg= "At least one URL check is failed, check result .xlsx file. Test case status: FAIL"
    END
    Log To Console    "All URLs are checked correctly. Test case status: PASS"

Navigate ${url} and expect ${text} in page
    [Documentation]    Navigates to given url and search for div and span elements by given text
    Go To    ${url}
    ${status}=    Run Keyword And Return Status    Verify Element ${text} exists by text
    Run Keyword If    ${status}==False
    ...    Fail    msg= "No element found with given text"

    
