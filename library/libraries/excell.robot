
*** Settings ***
Documentation    Excell Library for example test 

Library    ExcelLibrary
Library    Collections
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***

Open XLSX Data
    [Documentation]    Opens XLSX Data
    [Arguments]    ${excell_path}=${EXCELL_PATH}    ${sheet_name}=${SHEET_NAME}
    Open Excel Document    ${excell_path}    ${sheet_name}

Save Excel
    [Documentation]    Saves Excell Document
    [Arguments]    ${test_result_filaname}    ${excell_path}=${EXCELL_RESULT_FOLDER}
    Create Directory    ${excell_path}
    Save Excel Document    ${excell_path}${test_result_filaname}

Print All Columns
    [Documentation]    Prints all columns in opened XLSX data
    ${col1}=    Create List
    ${col2}=    Create List
    FOR    ${i}    IN RANGE    2    ROW_LENGTH
        ${username}    Read Excel Cell    ${i}    1
        ${password}    Read Excel Cell    ${i}    2
        Append To List    ${col1}    ${username}
        Append To List    ${col2}    ${password}
    END
    Log To Console    \n${col1}
    Log To Console    \n${col2}