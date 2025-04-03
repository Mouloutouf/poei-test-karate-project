import com.aspose.zip.Archive;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import java.io.*;
import java.util.ArrayList;
import java.util.Objects;

import static io.restassured.RestAssured.given;

public class TestRunner
{
    private static final String credentialsJsonFile = "credentials.json";
    private static final String credentialsJsonFilePath = "src/test/resources/" + credentialsJsonFile;

    private static final String featuresZipFileDestinationPath = "C:\\Users\\IB\\Desktop\\dev\\temp\\features.zip";

    private static final String featuresFileName = "test_features";
    private static final String featuresFolderPath = "src/test/resources/features/reqres_api";

    private static String token;

    private static ArrayList<String> featureNames = new ArrayList<String>();

    @BeforeClass
    public static void init() throws IOException
    {
        getAuthToken();

        getFeatures("POEI20252-632", 0);
    }

    public static void getAuthToken()
    {
        File clientJson = new File(credentialsJsonFilePath);

        token = given()
                .baseUri("https://xray.cloud.getxray.app/api/v2/authenticate")
                .contentType(ContentType.JSON)
                .body(clientJson)
                .when()
                .post()
                .then()
                .statusCode(200)
                .log().all()
                .extract().asString().replace("\"", "");
    }

    public static String getParametersPath(String keys, int filter)
    {
        String path = "";
        if (keys.isEmpty() == false)
            path = "keys=" + keys;

        if (filter != 0)
        {
            if (path.isEmpty() == false)
                path += "&";
            path += "filter=" + filter;
        }
        return path;
    }

    public static void getFeatures(String keys, int filter) throws IOException
    {
        String parameters = getParametersPath(keys, filter);

        Response response = given()
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + token)
                .get("https://xray.cloud.getxray.app/api/v2/export/cucumber?" + parameters);

        if (response.statusCode() == 200)
        {
            // extract response into zip file
            try (InputStream inputStream = response.asInputStream();
                 FileOutputStream outputStream = new FileOutputStream(featuresZipFileDestinationPath))
            {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1)
                {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }

            // extract zip content into features folder
            try (Archive archive = new Archive(featuresZipFileDestinationPath))
            {
                archive.extractToDirectory(featuresFolderPath);
            }

            System.out.println("Feature files saved as zip at: " + featuresZipFileDestinationPath);

            featureNames.clear();
            File folder = new File(featuresFolderPath);

            for (File file : Objects.requireNonNull(folder.listFiles()))
            {
                if (file.isFile())
                    featureNames.add(file.getName());
            }
        }
        else
        {
            System.out.println("Failed to download feature files: " + response.getBody().asString());
        }
    }

    @Test
    public void run()
    {
        Results results = Runner.path("classpath:features").tags("@Maxence_Droz").parallel(1);
        Assert.assertEquals(0, results.getFailCount());
    }

    @AfterClass
    public static void exit() throws FileNotFoundException
    {
        publishResults();
    }

    public static void publishResults() throws FileNotFoundException
    {
        for (String featureName : featureNames)
        {
            // TODO Create a new json report using all the feature reports
        }

        // TODO This will not work, need to either send each report separately or complete the code above to send a single report
        File resultJson = new File("target/surefire-reports/features.reqres_api." + featuresFileName + ".json");

        Response response = given()
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + token)
                .body(resultJson)
                .post("https://xray.cloud.getxray.app/api/v2/import/execution/cucumber");

        if (response.statusCode() == 200)
        {
            System.out.println("Result json successfully sent to xray");
        }
        else
        {
            System.out.println("Failed to publish results: " + response.getBody().asString());
        }
    }
}
