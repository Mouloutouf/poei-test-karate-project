Feature: Add two numbers
  Scenario: Add two integers with java
    * def calculator = Java.type('utils.Calculator')
    * def result = calculator.add(1, 3)
    Then assert result == 4

  Scenario: Add two integers with javascript
    * def method =
    """
    function(arg) {
    var Calculator = Java.type('utils.Calculator');
    return Calculator.add(1, 2);
    }
    """
    * def result = call method
    Then assert result == 3
