/*
 * Copyright (c) 2023 Sarah N
 *
 * Project Name:         Journey
 * Description:
 *
 * Date of Creation/
 * Last Update:          24/11/2023
 */

package at.fhv.journey;

import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
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
        //DatabaseFacade df = new DatabaseFacade();

        /*Hike newHike = new Hike(1, "Alplochschlucht - Kirchle loop from Kehlegg", 8.66, 2, 50, "This is test description",390, 3);
        Hike newHike1 = new Hike(2, "TEST", 8.66, 2, 50, "This is test description", 390, 3);

        df.saveObject(newHike);
        df.saveObject(newHike1);

        List<Hike> testlist = df.getAllHikes();

        for (Hike h: testlist) {
            System.out.println(h.getHike_id() + " " + h.getName());
        }*/


    }
}