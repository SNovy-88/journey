package at.fhv.journey.model;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class RecommendedMonthsHandlerTest {

    @Test
    void addMonth() {
        RecommendedMonthsHandler rec = new RecommendedMonthsHandler();
        rec.addMonth(MonthBitmaskFlags.Apr);
        System.out.println(rec.getBitmask());
    }
    @Test
    void addSeveralMonths(){
        RecommendedMonthsHandler rec = new RecommendedMonthsHandler(8);
        rec.addMonth(MonthBitmaskFlags.Jan);
        rec.addMonth(MonthBitmaskFlags.Feb);
        System.out.println(rec.getBitmask());
    }
    @Test
    void removeMonth(){
        RecommendedMonthsHandler rec = new RecommendedMonthsHandler(32);
        rec.removeMonth(MonthBitmaskFlags.Jun);
        System.out.println(rec.getBitmask());
    }

    @Test
    void checkMonth(){
        RecommendedMonthsHandler rec = new RecommendedMonthsHandler(5);
        System.out.println(rec.checkMonth(MonthBitmaskFlags.Jan));
        System.out.println(rec.checkMonth(MonthBitmaskFlags.Feb));
        System.out.println(rec.getBitmask());
    }
}