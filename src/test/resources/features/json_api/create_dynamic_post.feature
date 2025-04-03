Feature: Create dynamic post
  Background:
    Given def newPost = read('new-post.json')

  Scenario: Create post using json file
    Given url "https://jsonplaceholder.typicode.com/posts"
    And request newPost
    When method post
    Then status 201
    And match response.userId == newPost.userId
    And match response.title == newPost.title
    And match response.body == newPost.body
    And print response