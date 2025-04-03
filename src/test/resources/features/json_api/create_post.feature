Feature: Create new post
  Scenario: Create a post
    Given url "https://jsonplaceholder.typicode.com/posts"
    And request { "userId": "1", "title": "why is the roi de coeur the new meta in tarot ?", "body": "let me explain..." }
    When method post
    Then status 201
    And match response.id == "#notnull"
    And match response.userId == "1"
    And match response.title == "why is the roi de coeur the new meta in tarot ?"
    And match response.body == "let me explain..."