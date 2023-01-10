*** Settings ***
Documentation    All Libraries for example test 

Resource    libraries/pagefactory.robot
Resource    libraries/excell.robot

Library    DateTime
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***

${PASSED_TEST_COUNT}    0
${FAILED_TEST_COUNT}    0
${ONE}    1

*** Keywords ***

Check URLs and Report Status in Excell
    [Documentation]    Iterates through all rows in excell file and reads all columns
    ${row_length}=    Get Row Count    ${SHEET_NAME}
    FOR    ${i}    IN RANGE    2    ${row_length}
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
    Log To Console    Failed test count is: ${FAILED_TEST_COUNT}

Try Invalid Login Attempts and Report Status in Excell
    [Documentation]    Iterates through all rows in excell file and tries login attempts with usernames and passwords
    ${row_length} =    Get Row Count    ${SHEET_NAME}
    FOR    ${i}    IN RANGE    2    ${row_length}
        ${username}    Read Excel Cell    ${i}    1
        ${password}    Read Excel Cell    ${i}    2
        ${status}=    Run Keyword And Return Status    Try Invalid Login Attempt and Expect Failure    ${username}    ${password}
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
        Go To    ${URL}
    END

Try Invalid Login Attempt and Expect Failure
    [Documentation]    Tries login attempts with username and password
    [Arguments]    ${username}    ${password}
    Wait Element to be Visible by attribute    name    txtUsername
    Input Element found by attribute    name    txtUsername    ${username}
    Wait Element to be Visible by attribute    name    txtPassword
    Input Element found by attribute    name    txtPassword    ${password}
    Click Login button
    Wait body text to be Visible    Sorry, but the username that you entered does not exist.

Try Invalid Login Attempt template
    [Documentation]    Tries login attempts with username and password
    [Arguments]    ${username}    ${password}
    Try Invalid Login Attempt and Expect Failure    ${username}    ${password}
    Go To    ${URL}

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

Suite Setup
    [Documentation]    Example suite Setup 
    Open Browser    ${URL}    ${TESTING_BROWSER}
    Maximize Browser Window
    
Suite Teardown
    [Documentation]    Suite Teardown 
    Close All Browsers

Test case Setup
    [Documentation]    Opens given Excell Document and Sheet by name
    Open XLSX Data    excell_path=${EXCELL_PATH}    sheet_name=${SHEET_NAME}
    
Test case Teardown
    [Documentation]    Closes all Excell Documents
    ${date}=      Get Current Date      UTC      exclude_millis=yes
    ${converted}=      Convert Date      ${date}      result_format=%B%d_%H-%M
    ${filename}=    Convert To String    ${converted}.xlsx
    Save Excel    ${filename}

    Log To Console    Failed Test Count is: ${FAILED_TEST_COUNT}

    IF    ${FAILED_TEST_COUNT} != 0
    Fail    msg= "At least one URL check is failed, check result .xlsx file. Test case status: FAIL"
    END
    Log To Console    "All URLs are checked correctly. Test case status: PASS"
    Close All Excel Documents
