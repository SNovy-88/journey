package at.fhv.journey.utils;

import io.hypersistence.utils.hibernate.type.range.Range;
import org.junit.jupiter.api.Test;



import static org.junit.jupiter.api.Assertions.*;

class MonthsFunctionsTest {

    Range<Integer> testRange = Range.open(2, 5);

    @Test
    void testGetStartMonthWhenValidRangeThenReturnStartMonth() {
        // Arrange
        String expectedStartMonth = "February";

        // Act
        String actualStartMonth = MonthsFunctions.getStartMonth(testRange);

        // Assert
        assertEquals(expectedStartMonth, actualStartMonth, "The start month should be February");
    }

    @Test
    void testGetEndMonthWhenValidRangeThenReturnEndMonth() {
        // Arrange
        String expectedEndMonth = "May";

        // Act
        String actualEndMonth = MonthsFunctions.getEndMonth(testRange);

        // Assert
        assertEquals(expectedEndMonth, actualEndMonth, "The end month should be May");
    }
}