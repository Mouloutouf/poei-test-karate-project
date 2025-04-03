Feature: Create and delete user
  @Ignore
  Scenario: Create then delete user
    Given def id = call read('create_user.feature')
    And url "https://reqres.in/api/users/" + id
    When method delete
    Then status 204