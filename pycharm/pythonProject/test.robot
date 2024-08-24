*** Settings ***
Library     RequestsLibrary



*** Variables ***
${Host}    https://reqres.in
${ListUser}     /api/users?page=2
${SingleUser}     /api/users/2




*** Test Cases ***
ListUserProfile

      Create Session    HostSession    ${Host}
      ${response}=    get request    HostSession    ${ListUser}
      log    ${response.status_code}
      log    ${response.content}
      StatusCode_Validation    ${response.status_code}    200
      ResponseContent_Validation    ${response.content}

SingleUser1

      Create Session    HostSession    ${Host}
      ${response}=    get request    HostSession    ${SingleUser}
      log    ${response.status_code}
      log    ${response.content}
      StatusCode_Validation    ${response.status_code}    200
      ResponseContent_Validation_1    ${response.content}


*** Keywords ***
StatusCode_Validation
     [Arguments]    ${statuscode}    ${code}
     log    ${statuscode}
     log    ${code}
     run keyword and continue on failure    should be equal as integers    ${statuscode}     ${code}



ResponseContent_Validation
     [Arguments]    ${payload}
     log    ${payload}
     ${json}=     evaluate    json.loads('''${payload}''')
     log    ${json}
     should be equal as integers    ${json['data'][0]['id']}     7
     should be equal as strings     ${json['data'][0]['first_name']}     Michael
     should be equal as integers    ${json['data'][4]['id']}     11
     should be equal as strings     ${json['data'][4]['email']}     george.edwards@reqres.in


ResponseContent_Validation_1
     [Arguments]    ${payload}
     log    ${payload}
     ${json}=     evaluate    json.loads('''${payload}''')
     log    ${json}
     should be equal as integers    ${json['data']['id']}     2
     should be equal as strings     ${json['support']['url']}    https://reqres.in/#support-heading












