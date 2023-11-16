/*
 * Copyright (c) 2023 Sarah N
 *
 * Project Name:         Journey
 * Description:
 *
 * Date of Creation/
 * Last Update:          16/11/2023
 */

package at.fhv.journey.utils;

import io.hypersistence.utils.hibernate.type.range.Range;

import java.util.LinkedList;
import java.util.List;

public class MonthsFunctions {

    private static final LinkedList<String> _months = new LinkedList<>(List.of("January", "February", "March", "April", "May", "June", "July",
            "August", "September", "October", "November", "December"));


    private static String getMonthString(int index){
        return _months.get(index);
    }

    public static String getStartMonth(Range recommendedMonths){
        return getMonthString((Integer)recommendedMonths.lower()-1);
    }

    public static String getEndMonth(Range recommendedMonths){
        return getMonthString((Integer) recommendedMonths.upper()-1);
    }

    public static Integer getStartMonthInt(Range recommendedMonths){
        return ((Integer)recommendedMonths.lower())-1;
    }

    public static Integer getEndMonthInt(Range recommendedMonths){
        return ((Integer) recommendedMonths.upper()-1);
    }

}
