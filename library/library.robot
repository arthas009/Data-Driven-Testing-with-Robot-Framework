*** Settings ***
Documentation    All Libraries for example test 

Resource    libraries/mandatory.robot
Resource    libraries/pagefactory.robot

Library    OperatingSystem

*** Keywords ***

Check URLs and Report Status in Excell
    [Documentation]    Iterates through all rows in excell file and reads all columns
    FOR    ${i}    IN RANGE    2    ${ROW_LENGTH}
        ${url}    Read Excel Cell    ${i}    1
        ${text}    Read Excel Cell    ${i}    2
        ${status}=    Run Keyword And Return Status    Navigate ${url} and expect ${text} in page
        IF   ${status}==False
            Write Excel Cell    ${i}    4    FAIL    ${SHEET_NAME}
            Write Excel Cell    ${i}    5    No element found with given text. Keyword Failed    ${SHEET_NAME}
            Print red log to Console    URL '${url}' with text '${text}' NOT PASSED
            ${FAILED_TEST_COUNT}=    Evaluate    ${FAILED_TEST_COUNT}+${ONE}
        END
        IF   ${status}==True
            Print Green Log to Console    URL '${url}' with text '${text}' PASSED
            Write Excel Cell    row_num=${i}    col_num=4    value=PASS    sheet_name=${SHEET_NAME}
            ${PASSED_TEST_COUNT}=    Evaluate    ${PASSED_TEST_COUNT+1}+${ONE}
        END
    END

Try Invalid Login Attempts and Report Status in Excell
    [Documentation]    Iterates through all rows in excell file and tries login attempts with usernames and passwords
    FOR    ${i}    IN RANGE    2    ${ROW_LENGTH}
        ${username}    Read Excel Cell    ${i}    1
        ${password}    Read Excel Cell    ${i}    2
        ${status}=    Run Keyword And Return Status    Try Invalid Login Attempt and Expect Failure    ${username}    ${status}
        IF   ${status}==False
            Write Excel Cell    ${i}    4    FAIL    ${SHEET_NAME}
            Write Excel Cell    ${i}    5    No element found about login failure. Keyword Failed    ${SHEET_NAME}
            Print red log to Console    URL '${username}' with password '${password}' NOT PASSED
            ${FAILED_TEST_COUNT}=    Evaluate    ${FAILED_TEST_COUNT}+${ONE}
        END
        IF   ${status}==True
            Print Green Log to Console    URL '${username}' with password '${password}' PASSED
            Write Excel Cell    row_num=${i}    col_num=4    value=PASS    sheet_name=${SHEET_NAME}
            ${PASSED_TEST_COUNT}=    Evaluate    ${PASSED_TEST_COUNT+1}+${ONE}
        END
    END

Try Invalid Login Attempt and Expect Failure
    [Documentation]    Tries login attempts with username and password
    [Arguments]    ${username}    ${password}
    Wait Element to be Visible by attribute    title    Log in to your customer account
    Click Element found by attribute    title    Log in to your customer account
    Wait Element to be visible by attribute    name    email
    Wait Element to be visible by attribute    name    passwd
    Input Element found by attribute    name    email    ${username}
    Input Element found by attribute    name    passwd    ${password}
    Click Sign In button
    Wait Element to be visible by text    There is 1 error

Navigate ${url} and expect ${text} in page
    [Documentation]    Navigates to given url and search for div and span elements by given text
    Go To    ${url}
    ${status}=    Run Keyword And Return Status    Verify Element ${text} exists by text
    Run Keyword If    ${status}==False
    ...    Fail    msg= "No element found with given text"

Print Red Log to Console
    [Documentation]    Uses red color while printing log to Console
    [Arguments]    ${log_text}
    ${red_text}=    Evaluate    "\\033[31m" "\\n${log_text}\\033[0m"
    Log To Console    ${red_text}

Print Green Log to Console
    [Documentation]    Uses green color while printing log to Console
    [Arguments]    ${log_text}
    ${green_text}=    Evaluate    "\\033[32m" "\\n${log_text}\\033[0m"
    Log To Console    ${green_text}
