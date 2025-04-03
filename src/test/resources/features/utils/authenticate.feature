Feature: Authentication Xray

  @Authentication
  Scenario: Authenticate
    * header Content-Type = "application/json"
    * url "https://xray.cloud.getxray.app/api/v2/authenticate"
    * request { "client_id": "AF9B668299D347BD94A5B483625695DE", "client_secret": "122844954716c4634d2a0fa63817998fb045981813fb2dc7f3a002d087a55b97" }
    * method post
    * status 200
    * print response