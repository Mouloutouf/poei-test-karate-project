Feature: Calculate discount

  Scenario: Calculate discount for multiple entries
    * def method =
    """
    function(arg) {
    var DiscountCalculatorClass = Java.type('utils.DiscountCalculator');
    var DiscountCalculator = new DiscountCalculatorClass();
    return DiscountCalculator.calculateDiscount(arg);
    }
    """
    * def result1 = call method 100
    * assert result1 == 98
    * def result2 = call method 2000
    * assert result2 == 1900

  Scenario Outline: Calculate discount for multiple entries
    * def DiscountCalculatorClass = Java.type('utils.DiscountCalculator')
    * def DiscountCalculator = new DiscountCalculatorClass()
    * def discount = DiscountCalculator.calculateDiscount(<amount>)
    * assert discount == <expected>

    Examples:
      | amount | expected |
      | 100    | 98       |
      | 2000   | 1900     |