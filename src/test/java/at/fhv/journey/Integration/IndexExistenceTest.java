package at.fhv.journey.Integration;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class IndexExistenceTest {
    private WebDriver driver;
    private Map<String, Object> vars;
    JavascriptExecutor js;
    @Before
    public void setUp() {
        driver = new ChromeDriver();
        js = (JavascriptExecutor) driver;
        vars = new HashMap<String, Object>();
    }
    @After
    public void tearDown() {
        driver.quit();
    }

    @Test
    public void IndexExistenceTest() {
        driver.get("http://localhost:8080/Journey_war_exploded/");
        driver.manage().window().setSize(new Dimension(816, 860));
        {
            List<WebElement> elements = driver.findElements(By.cssSelector(".logo"));
            assert (elements.size() > 0);
        }
        {
            List<WebElement> elements = driver.findElements(By.linkText("DISCOVER"));
            assert (elements.size() > 0);
        }
        {
            List<WebElement> elements = driver.findElements(By.linkText("CREATE"));
            assert (elements.size() > 0);
        }
        {
            List<WebElement> elements = driver.findElements(By.cssSelector(".profile"));
            assert (elements.size() > 0);
        }
        {
            List<WebElement> elements = driver.findElements(By.cssSelector(".loginButton"));
            assert (elements.size() > 0);
        }
        driver.findElement(By.cssSelector("p")).click();
        {
            List<WebElement> elements = driver.findElements(By.cssSelector("p"));
            assert (elements.size() > 0);
        }
        {
            List<WebElement> elements = driver.findElements(By.cssSelector(".background"));
            assert (elements.size() > 0);
        }
    }
}
