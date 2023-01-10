*** Settings ***
Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Timeout      15 minutes

Resource    library/library.robot

*** Test Cases ***
Search Texts
    [Documentation]    Performs navigation and searching for elements based on text in given URLs and texts.
    ...    - Verifies: 
    ...    1. Given URLs has at least one element has given text in excell column
    [Tags]    text_searching
    [Setup]    Test case Setup
    Check URLs and Report Status in excell
    [Teardown]    Test case Teardown

Invalid Logins
    [Documentation]    Tries invalid login attempts
    ...    - Verifies: 
    ...    1. Each invalid username/password combination is redirecting to error page
    [Tags]    invalid_login
    [Setup]    Test case Setup
    Try Invalid Login Attempts and Report Status in Excell
    [Teardown]    Test case Teardown