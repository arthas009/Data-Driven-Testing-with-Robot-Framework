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

Wait Element to be Visible by text
    [Documentation]    Finds element by name
    [Arguments]    ${name}
    Wait Until Element Is Enabled    //*[text()='${name}']    timeout=10s
    Wait Until Element Is Visible    //*[text()='${name}']    timeout=10s

Wait Element to be Visible by attribute
    [Documentation]    Finds element by name
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

Click Sign In button
    [Documentation]    Clicks on given element by xpath
    Wait Until Element Is Enabled    //*[@id="SubmitLogin"]/span/i
    Wait Until Element Is Visible    //*[@id="SubmitLogin"]/span/i
    Click Element     //*[@id="SubmitLogin"]/span/i