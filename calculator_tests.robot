*** Settings ***
Library    CalculatorLibrary.py

*** Test Cases ***
Addition Should Work Correctly
    ${result}=    Add Numbers    5    7
    Should Be Equal As Integers    ${result}    12

Division Should Work Correctly
    ${result}=    Divide Numbers    10    2
    Should Be Equal As Integers    ${result}    5

Result Should Be Positive
    ${result}=    Add Numbers    3    4
    Number Should Be Positive    ${result}

Dividing By Zero Should Fail
    Run Keyword And Expect Error
    ...    *Cannot divide by zero
    ...    Divide Numbers    5    0