/*
 * Copyright (c) 2023 Sarah N
 *
 * Project Name:         Journey
 * Description:
 *
 * Date of Creation/
 * Last Update:          15/11/2023
 */

package at.fhv.journey;

import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;

public class HikeTest {

    public static void main(String[] args) {
        DatabaseFacade df = new DatabaseFacade();
        Hike testHike = df.getHikeByID(1);

        System.out.println("This is Hike with the ID 1:\n");
        System.out.println("Name: "+testHike.getName());
        System.out.println("Description: "+testHike.getDescription());
        System.out.println("Stamina: "+testHike.getStamina());
        System.out.println("Experience: "+testHike.getExperience());
        System.out.println("Scenery: "+testHike.getScenery());
        System.out.println("Author: "+testHike.getAuthor());
        System.out.println("Date Created: "+testHike.getDateCreated());
    }
}
