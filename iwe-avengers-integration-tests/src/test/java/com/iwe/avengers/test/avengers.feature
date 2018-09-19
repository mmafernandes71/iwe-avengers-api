Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://u2eo5hetx5.execute-api.us-east-1.amazonaws.com/dev/'

Scenario: Get Avenger by Id

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
When method get
Then status 200

Scenario: Creates a new Avengers

Given path 'avengers'
And request {name: 'Capit�o Am�rica', secretIdentity: 'Steve Rogrs'}
When method post
Then status 201
