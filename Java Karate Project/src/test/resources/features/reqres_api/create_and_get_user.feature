Feature: Create and get user
  Scenario: Create new user and get id
    Given url "https://reqres.in/api/users"
    And request { "name": "jack", "surname": "doohan" }
    When method post
    And def id = get response.id
    And url "https://reqres.in/api/users:id"
    And method get
    Then status 200
    And print response