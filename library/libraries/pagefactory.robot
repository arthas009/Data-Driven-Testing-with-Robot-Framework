*** Settings ***
Documentation    Library for example test 

Library    SeleniumLibrary

*** Keywords ***

Click on ${element_text}
    [Documentation]    Clicks element by its text
    Verify Element ${element_text} exists by text
    Click Element    //*[contains(text(),'${element_text}')]

Verify Element ${text} exists by text
    [Documentation]    Verifies that page has a visible span element by given text
    Wait Until Element Is Enabled    //*[contains(text(),'${text}')]    timeout=10s
    Wait Until Element Is Visible    //*[contains(text(),'${text}')]    timeout=10s
