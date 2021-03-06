Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://u2eo5hetx5.execute-api.us-east-1.amazonaws.com/dev/'

 * def getToken =
"""
function() {
 var TokenGenerator = Java.type('com.iwe.avengers.test.authorization.TokenGenerator');
 var sg = new TokenGenerator();
 return sg.getToken();
}
"""
* def token = call getToken

Scenario: Should return non-authenticated access

Given path 'avengers', 'anyid'
When method get 
Then status 401

Scenario: Get not found

Given path 'avengers', 'avenger-not-found'
And header Authorization = 'Bearer ' + token
When method get
Then status 404

Scenario: Creates a new Avengers

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Captain America', secretIdentity: 'Steve Rogrs'}
When method post
Then status 201
And match response == {id: '#string', name: 'Captain America', secretIdentity: 'Steve Rogrs'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match response $ == savedAvenger

Scenario: Creates a new avenger without the required data

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Captain America'}
When method post
Then status 400

Scenario: Attempt to Delete a non-existent  Avenger
Given path 'avengers', 'avenger-not-found'
When method delete
Then status 404

Scenario:  Delete Avenger by Id 

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Super Miguel', secretIdentity: 'Super Miguel'}
When method post
Then status 201
And match response == {id: '#string', name: 'Super Miguel', secretIdentity: 'Super Miguel'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method delete
Then status 204

Given path 'avengers', savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 404


Scenario: Update the Avenger data

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Super Animal', secretIdentity: 'Super Animal'}
When method post
Then status 201
And match response == {id: '#string', name: 'Super Animal', secretIdentity: 'Super Animal'}

* def updatedAvenger = response

Given path 'avengers', updatedAvenger.id
And header Authorization = 'Bearer ' + token
And request {name: name: 'Super PET'}
When method put
Then status 400

Given path 'avengers', updatedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match response $ == updatedAvenger

Scenario: Update Avenger by Id (Path parameter)

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
And header Authorization = 'Bearer ' + token
And request {name: 'Captain America'}
When method put
Then status 400

Scenario: Update Avenger not found

Given path 'avengers', 'zzzz-bbbb-cccc-dddd'
And header Authorization = 'Bearer ' + token
And request {name: 'Z� porrinha', "secretIdentity": "Z� porrinhas"}
When method put
Then status 404




