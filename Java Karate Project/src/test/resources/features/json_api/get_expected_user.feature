Feature: Get expected user
  Scenario: Get first user and compare it to expected user json
    Given url "https://jsonplaceholder.typicode.com/users/1"
    * def jsonFile = read('expected-user.json')
    When method get
    Then status 200
    And match response == jsonFile
    Then print response