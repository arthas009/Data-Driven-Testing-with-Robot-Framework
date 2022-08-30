*** Settings ***
Documentation    Mandatory Library for example test 

Resource    excell.robot

Library    SeleniumLibrary

*** Variables ***
${TESTING_URL}=    https://www.google.com
${PASSED_TEST_COUNT}    ${0}
${FAILED_TEST_COUNT}    ${0}
${ONE}    ${1}

*** Keywords ***

Suite Setup
    [Documentation]    Example suite Setup 
    Open Browser    ${TESTING_URL}    ${TESTING_BROWSER}
    Maximize Browser Window

Suite Teardown
    [Documentation]    Suite Teardown 
    Close All Browsers

Test case Setup for text searching case in URLs
    [Documentation]    Opens given Excell Document and Sheet by name
    Open XLSX Data    excell_path=${EXCELL_PATH}    sheet_name=${SHEET_NAME}

Test case Teardown for text searching case in URLs
    [Documentation]    Closes all Excell Documents
    Close All Excel Documents