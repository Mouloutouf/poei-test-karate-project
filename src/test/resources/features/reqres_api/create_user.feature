Feature: Create user
  Scenario: Create new user Morpheus
    Given url "https://reqres.in/api/users"
    And request { "name": "morpheus", "job": "leader" }
    When method post
    Then status 201
    And match response.name == 'morpheus'
    And match response.job == 'leader'
    And match response.id != null
    And print response
    And def id = get response.id