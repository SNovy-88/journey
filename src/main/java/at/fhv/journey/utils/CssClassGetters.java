/*
 * Copyright (c) 2023 Sarah N
 *
 * Project Name:         Journey
 * Description:
 *
 * Date of Creation/
 * Last Update:          22/11/2023
 */

package at.fhv.journey.utils;

import at.fhv.journey.model.Hike;

public class CssClassGetters {

    public static String getFitnessLevelCSSClass(Hike hike) {
        switch (hike.getFitnessLevel()) {
            case 1:
                return "fitness-level-easy";
            case 2:
                return "fitness-level-moderate";
            case 3:
                return "fitness-level-intermediate";
            case 4:
                return "fitness-level-challenging";
            case 5:
                return "fitness-level-expert";
            default:
                return "fitness-level-unknown";
        }
    }
}