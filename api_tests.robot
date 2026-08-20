*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com

*** Test Cases ***
Get Single Post Should Return Correct Data
    Create Session    jsonplaceholder    ${BASE_URL}
    ${response}=    GET On Session    jsonplaceholder    /posts/1
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Integers    ${response.json()}[id]    1
    Should Not Be Empty    ${response.json()}[title]

Create New Post Should Succeed
    Create Session    jsonplaceholder    ${BASE_URL}
    &{payload}=    Create Dictionary
    ...    title=My Test Post
    ...    body=This is a test
    ...    userId=1
    ${response}=    POST On Session    jsonplaceholder    /posts    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    201
    Should Be Equal    ${response.json()}[title]    My Test Post

Get Nonexistent Post Should Return 404
    Create Session    jsonplaceholder    ${BASE_URL}
    ${response}=    GET On Session    jsonplaceholder    /posts/99999    expected_status=404
    Should Be Equal As Integers    ${response.status_code}    404