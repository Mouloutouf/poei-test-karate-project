function fn()
{
    var config = {
        urlServer: "https://reqres.in"
    };

    var env = "json-api";

    if (env == "json-api") {
        config.urlServer = "https://jsonplaceholder.typicode.com";
    } else if (env == "restful-api") {
        config.urlServer = "https://restful-booker.herokuapp.com";
    }

    return config;
}