*** Settings ***
Documentation    Library for example test 

Library    SeleniumLibrary
Library    XML

*** Keywords ***

Click on ${element_text}
    [Documentation]    Clicks element by its text
    Verify Element ${element_text} exists by text
    Click Element    //*[contains(text(),'${element_text}')]

Verify Element ${text} exists by text
    [Documentation]    Verifies that page has a visible span element by given text
    Wait Until Element Is Enabled    //*[contains(text(),'${text}')]    timeout=10s
    Wait Until Element Is Visible    //*[contains(text(),'${text}')]    timeout=10s

Wait Element to be Visible by text
    [Documentation]    Waits for element to visible by text
    [Arguments]    ${text}
    Wait Until Element Is Enabled    //*[contains(text(),'${text}')]    timeout=10s
    Wait Until Element Is Visible    //*[contains(text(),'${text}')]    timeout=10s

Wait body text to be Visible
    [Documentation]    Waits for element to visible by text
    [Arguments]    ${text}
    ${body_text}=    Get Text    //body
    Should Contain    ${body_text}    ${text}
    
Wait Element to be Visible by attribute
    [Documentation]   Waits for element to visible by attribute
    [Arguments]    ${attribute}    ${name}
    Wait Until Element Is Enabled    //*[@${attribute}='${name}']    timeout=10s
    Wait Until Element Is Visible    //*[@${attribute}='${name}']    timeout=10s

Input Element found by attribute
    [Documentation]    Inputs element by finding it using attribute
    [Arguments]    ${attribute}    ${attribute_value}    ${text}
    Wait Until Element Is Enabled    //*[@${attribute}='${attribute_value}']    timeout=10s
    Wait Until Element Is Visible    //*[@${attribute}='${attribute_value}']    timeout=10s
    Input Text     //*[@${attribute}='${attribute_value}']    ${text}

Click Element found by attribute
    [Documentation]    Clicks element by finding it using attribute
    [Arguments]    ${attribute}    ${attribute_value}
    Wait Until Element Is Enabled    //*[@${attribute}='${attribute_value}']    timeout=10s
    Wait Until Element Is Visible    //*[@${attribute}='${attribute_value}']    timeout=10s
    Click Element     //*[@${attribute}='${attribute_value}']

Click Login button
    [Documentation]    Clicks on Login button which is value = Login
    Wait Until Element Is Enabled    //*[@value="Login"]
    Wait Until Element Is Visible    //*[@value="Login"]
    Click Element     //*[@value="Login"]