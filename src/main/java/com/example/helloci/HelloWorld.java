import static spark.Spark.*;

public class HelloWorld {
    public static void main(String[] args) {
        port(8421);
        get("/", (req, res) -> "Hello World");
    }
}
