Feature: Send results

  @SendResults
  Scenario: Send results
    * def jsonFile = read('cucumber.json')
    * url "https://xray.cloud.getxray.app/api/v2/import/execution/cucumber"
    * def token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnQiOiJiNmNhZGQwNS1lMzQxLTNmMTctYjU1Zi00OTM0MTI4MWQ4MmEiLCJhY2NvdW50SWQiOiI3MTIwMjA6ZGFlMjMzMmUtODUwMC00NTJjLWEwYWUtNzM1NjI2OWU0ZjQ5IiwiaXNYZWEiOmZhbHNlLCJpYXQiOjE3NDM0MjY4MDQsImV4cCI6MTc0MzUxMzIwNCwiYXVkIjoiRTU3N0Y5Q0FFQzhBNDE3MTk4NUQyRjgyRjEyOUQ3M0YiLCJpc3MiOiJjb20ueHBhbmRpdC5wbHVnaW5zLnhyYXkiLCJzdWIiOiJFNTc3RjlDQUVDOEE0MTcxOTg1RDJGODJGMTI5RDczRiJ9.V_Q7qYQ7xvIunpGLrfAepT3I96d0oGkAkZSnucgJGFM"
    * header Content-Type = "application/json"
    * header Authorization = "Bearer " + token
    * request jsonFile
    * method post
    * status 200