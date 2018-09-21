Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://u2eo5hetx5.execute-api.us-east-1.amazonaws.com/dev/'

Scenario: Get Avenger by Id

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
When method get
Then status 200
And match response == {id: '#string', name: '#string', secretIdentity: '#string'}

Scenario: Creates a new Avengers

Given path 'avengers'
And request {name: 'Captain America', secretIdentity: 'Steve Rogrs'}
When method post
Then status 201
And match response == {id: '#string', name: '#string', secretIdentity: '#string'}

Scenario: Creates a new avenger without the required data

Given path 'avengers'
And request {name: 'Captain America'}
When method post
Then status 400

Scenario: Delete Avenger by Id

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
When method delete
Then status 204

Scenario: Update Avenger by Id

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
And request {name: 'Captain America', "secretIdentity": "Steve Rogers"}
When method get
Then status 200

Scenario: Update Avenger by Id (Path parameter)

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
And request {name: 'Captain America'}
When method put
Then status 400




