package at.fhv.journey.model;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MonthBitmaskFlagsTest {

    @Test
    void valueOf() {
        int i = MonthBitmaskFlags.Dec.ordinal();
        System.out.println(MonthBitmaskFlags.Sep.getValue());
        System.out.println(i);
    }
}