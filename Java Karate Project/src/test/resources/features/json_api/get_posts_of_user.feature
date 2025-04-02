Feature: Get posts of specific user
  Scenario: Get posts of first user
    Given url "https://jsonplaceholder.typicode.com/users"
    When method get
    * def userId = get response[0].id
    Given url "https://jsonplaceholder.typicode.com/posts/" + userId
    When method get
    Then match response.userId == userId