import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.Assert;
import org.junit.Test;

public class TestRunner
{
    @Test
    public void run()
    {
        Results results = Runner.path("classpath:features").parallel(1);
        Assert.assertEquals(0, results.getFailCount());
    }
}
