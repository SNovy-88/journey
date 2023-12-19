/*
 * Copyright (c) 2023 Sarah N
 *
 * Project Name:         Journey
 * Description:
 *
 * Date of Creation/
 * Last Update:          13/11/2023
 */

package at.fhv.journey.hibernate.broker;

import at.fhv.journey.model.Hike;
import jakarta.persistence.EntityManager;

import java.util.List;

public class HikeBrokerJPA extends BrokerBaseJPA<Hike> {

    public List<Hike> getHikesByName(String name, int fitness, int stamina, int experience, int scenery, int months) {
        EntityManager entityManager = getEntityManager();
        List<Hike> hikes = entityManager.createQuery("SELECT h FROM Hike h WHERE h.name ILIKE :name AND h.fitnessLevel >= :fitness AND h.stamina >= :stamina AND h.experience >= :experience AND h.scenery >= :scenery " +
                        //"AND h.recommendedMonths = :month" +
                        "", Hike.class)
                .setParameter("name", "%" + name + "%")
                .setParameter("fitness", fitness)
                .setParameter("stamina", stamina)
                .setParameter("experience", experience)
                .setParameter("scenery", scenery)
                //.setParameter("month", months)
                .getResultList();
        entityManager.close();
        return hikes;
    }
}
