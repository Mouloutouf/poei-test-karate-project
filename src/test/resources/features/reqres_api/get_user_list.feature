Feature: Get user list
  Scenario: Get users on page 2
    Given url "https://reqres.in/api/users?page=2"
    When method get
    Then status 200
    And match response.page == 2
    And match response.data == '#[6]'
    And match response.data[0].id == 7