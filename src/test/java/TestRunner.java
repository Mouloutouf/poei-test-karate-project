import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class TestRunner
{
    @Test
    public void parallelTest()
    {
        Results results = Runner.path("classpath:features").tags("~@Ignore").parallel(1);
        Assertions.assertEquals(0, results.getFailCount());
    }
}
