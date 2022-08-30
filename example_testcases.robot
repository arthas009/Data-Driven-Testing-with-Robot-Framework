*** Settings ***
Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Timeout      15 minutes
Force Tags        sites

Resource    library/library.robot

*** Test Cases ***
First Test
    [Documentation]    First example test
    [Tags]    first_test
    Open XLSX Data
    Check URLs and Report Status in excell