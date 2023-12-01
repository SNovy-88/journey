/*
 * Copyright (c) 2023 Sarah N
 *
 * Project Name:         Journey
 * Description:
 *
 * Date of Creation/
 * Last Update:          01/12/2023
 */

package at.fhv.journey.model;

public class RecommendedMonthsHandler {

    private int _bitmask;

    public RecommendedMonthsHandler(){
        _bitmask = 0;
    }

    public RecommendedMonthsHandler(int bitmask){
        _bitmask = bitmask;
    }

    public int addMonth(MonthBitmaskFlags month){
        _bitmask = _bitmask | month.getValue();
        return _bitmask;
    }

    public int removeMonth(MonthBitmaskFlags month){
        _bitmask = _bitmask & ~ month.getValue();
        return _bitmask;
    }

    public boolean checkMonth(MonthBitmaskFlags month){
        if((_bitmask & month.getValue()) == 1){
            return true;
        }
        return false;
    }



    public int getBitmask() {
        return _bitmask;
    }
}
