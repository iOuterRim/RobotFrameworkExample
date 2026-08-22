*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
Run Teardown Actions
    Log    Test finished, cleaning up if needed
    Delete Created Post If Exists

Delete Created Post If Exists
    Run Keyword If    '${created_id}' != '${EMPTY}'
    ...    DELETE On Session    jsonplaceholder    /posts/${created_id}