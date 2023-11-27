package at.fhv.journey;/*
 * Copyright (c) 2023 Sarah N
 *
 * Project Name:         Journey
 * Description:
 *
 * Date of Creation/
 * Last Update:          13/11/2023
 */

import at.fhv.journey.hibernate.broker.BrokerBaseJPA;
import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import io.hypersistence.utils.hibernate.type.range.Range;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public class DatabaseTest {

    public static void main(String[] args) {

       /* System.out.println("Database URL: " + System.getProperty("jakarta.persistence.jdbc.url"));
        System.out.println("Database Username: " + System.getProperty("jakarta.persistence.jdbc.user"));
        System.out.println("Database Password: " + System.getProperty("jakarta.persistence.jdbc.password"));

        EntityManagerFactory fact = Persistence.createEntityManagerFactory("journey");
        EntityManager entityManager = fact.createEntityManager();
        List<Hike> hikeList= (List<Hike>) entityManager.createQuery("from Hike").getResultList();
        for (Hike h: hikeList) {
            System.out.println(h.getHike_id()+" "+h.getName()+"\n");
        }*/


        //Facade Tests

        DatabaseFacade df = new DatabaseFacade();

        /*( String name, double distance, int durationHour, int durationMin, String description,
        int heightDifference, int fitnessLevel, int stamina, int experience, int scenery,
        Range recommendedMonths, String author, String gpx)*/

        Hike newHike = new Hike("Alplochschlucht - Kirchle loop from Kehlegg", 8.66, 2, 50, "This is test description",
                390, 3, 1, 1, 3,
                Range.integerRange("[2,5]"),"John","local");
        Hike newHike1 = new Hike("TEST", 8.66, 2, 50, "This is test description", 390, 3, 1, 1, 3,
                Range.integerRange("[2,5]"),"John","local");

        df.saveObject(newHike);
        df.saveObject(newHike1);

        List<Hike> testlist = df.getAllHikes();

        for (Hike h: testlist) {
            System.out.println(h.getHike_id() + " " + h.getName());
        }


    }
}
