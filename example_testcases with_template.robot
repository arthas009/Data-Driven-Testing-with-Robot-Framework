*** Settings ***
Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Timeout      15 minutes
Test Template    Try Invalid Login Attempt template
Force Tags    invalid_login_with_template

Resource    library/library.robot

*** Test Cases ***

Empty Password    usernameee    ${EMPTY}
Empty Username   ${EMPTY}    passwordddd
Empty Username and Password    ${EMPTY}    ${EMPTY}
Invalid Username    invalid_usernamee    valid_password
Invalid Username 2    invalid_username_>><<    valid_password
Invalid Password    valid_usernamee    invalid_password
Invalid Password 2    valid_usernamee    invalid_password_>><<

