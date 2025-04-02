Feature: Create dynamic user
  Background:
    Given def user = read('user.json')

  Scenario: Create new user John Doe
    Given url "https://reqres.in/api/users"
    And request user
    When method post
    Then status 201
    And match response.name == 'John Doe'
    And match response.job == 'Automation Tester'
    And match response.id != null
    And print response