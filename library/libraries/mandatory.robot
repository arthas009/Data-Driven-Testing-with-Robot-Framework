*** Settings ***
Documentation    Mandatory Library for example test 

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