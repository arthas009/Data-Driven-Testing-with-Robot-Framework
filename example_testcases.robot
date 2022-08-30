*** Settings ***
Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Timeout      15 minutes
Force Tags        sites

Resource    library/library.robot

*** Test Cases ***
First Test
    [Documentation]    Performs navigation and searching for elements based on text in given URLs and texts.
    ...    - Verifies: 
    ...    1. Given URLs has at least one element has given text in excell column
    [Tags]    first_test
    [Setup]    Test case Setup for text searching case in URLs
    Check URLs and Report Status in excell
    [Teardown]    Test case Teardown for text searching case in URLs
