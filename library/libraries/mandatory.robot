*** Settings ***
Documentation    Mandatory Library for example test 

Resource    excell.robot

Library    DateTime
Library    SeleniumLibrary

*** Variables ***
${PASSED_TEST_COUNT}    ${0}
${FAILED_TEST_COUNT}    ${0}
${ONE}    ${1}

*** Keywords ***

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
    IF    ${FAILED_TEST_COUNT}!=0
    Fail    msg= "At least one URL check is failed, check result .xlsx file. Test case status: FAIL"
    END
    Log To Console    "All URLs are checked correctly. Test case status: PASS"
    Close All Excel Documents