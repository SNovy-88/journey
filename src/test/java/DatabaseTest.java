/*
 * Copyright (c) 2023 Sarah N
 *
 * Project Name:         Journey
 * Description:
 *
 * Date of Creation/
 * Last Update:          13/11/2023
 */

import at.fhv.journey.model.Hike;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public class DatabaseTest {

    public static void main(String[] args) {

        System.out.println("Database URL: " + System.getProperty("jakarta.persistence.jdbc.url"));
        System.out.println("Database Username: " + System.getProperty("jakarta.persistence.jdbc.user"));
        System.out.println("Database Password: " + System.getProperty("jakarta.persistence.jdbc.password"));

        EntityManagerFactory fact = Persistence.createEntityManagerFactory("journey");
        EntityManager entityManager = fact.createEntityManager();
        List<Hike> hikeList= (List<Hike>) entityManager.createQuery("from Hike").getResultList();
        for (Hike h: hikeList) {
            System.out.println(h.getHike_id()+" "+h.getName()+"\n");
        }


    }
}
