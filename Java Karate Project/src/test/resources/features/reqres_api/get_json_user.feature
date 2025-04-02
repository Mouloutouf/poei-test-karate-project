Feature: Get user in json format
  Scenario: Get user 2 in json
    Given url "https://reqres.in/api/users/2"
    When method get
    Then status 200
    And header accept = 'application/json'