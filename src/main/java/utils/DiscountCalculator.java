package utils;

public class DiscountCalculator
{
    public double calculateDiscount(double value)
    {
        return value - (value * (value > 1000 ? 0.05 : 0.02));
    }
}
