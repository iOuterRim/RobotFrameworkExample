*** Settings ***
Library    RequestsLibrary
Library    Collections
Suite Setup       Create Session    jsonplaceholder    ${BASE_URL}
Suite Teardown    Log    All API tests finished
Test Setup        Log    Starting a new test case
Test Teardown     Run Teardown Actions

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com
${created_id}    ${EMPTY}

*** Keywords ***
Delete Created Post If Exists
    Run Keyword If    '${created_id}' != '${EMPTY}'
    ...    DELETE On Session    jsonplaceholder    /posts/${created_id}

Run Teardown Actions
    Log    Test finished, cleaning up if needed
    Delete Created Post If Exists

*** Test Cases ***
Get Single Post Should Return Correct Data
    ${response}=    GET On Session    jsonplaceholder    /posts/1
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Integers    ${response.json()}[id]    1
    Should Not Be Empty    ${response.json()}[title]

Create New Post Should Succeed
    &{payload}=    Create Dictionary
    ...    title=My Test Post
    ...    body=This is a test
    ...    userId=1
    ${response}=    POST On Session    jsonplaceholder    /posts    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    201
    Should Be Equal    ${response.json()}[title]    My Test Post
    Set Suite Variable    ${created_id}    ${response.json()}[id]

Get Nonexistent Post Should Return 404
    ${response}=    GET On Session    jsonplaceholder    /posts/99999    expected_status=404
    Should Be Equal As Integers    ${response.status_code}    404