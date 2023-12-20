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
import jakarta.persistence.Query;
import jakarta.persistence.criteria.CriteriaBuilder;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HikeBrokerJPA extends BrokerBaseJPA<Hike> {

    public List<Hike> getHikesWithFilter(String name, Integer fitness, Integer stamina, Integer experience, Integer scenery, Integer months) {
        EntityManager entityManager = getEntityManager();

        // Start with base query
        StringBuilder queryString = new StringBuilder("SELECT h FROM Hike h WHERE h.name ILIKE :name");
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("name", "%" + name + "%");


        // Append conditions for each filter if they are not null
        if (fitness != null) {
            queryString.append(" AND h.fitnessLevel = :fitness");
            parameters.put("fitness", fitness);
        }
       /* if (stamina != null) {
            queryString.append(" AND h.stamina <= :stamina");
            parameters.put("stamina", stamina);
        }
        if (experience != null) {
            queryString.append(" AND h.experience <= :experience");
            parameters.put("experience", experience);
        }
        if (scenery != null) {
            queryString.append(" AND h.scenery >= :scenery");
            parameters.put("scenery", scenery);
        }*/

        Query query = entityManager.createQuery(queryString.toString(), Hike.class);
        for (Map.Entry<String, Object> entry : parameters.entrySet()) {
            query.setParameter(entry.getKey(), entry.getValue());
        }

        System.out.println(queryString);

        List<Hike> hikes = query.getResultList();
        entityManager.close();
        return hikes;
    }

    public List<Hike> getHikesByName(String name) {
        EntityManager entityManager = getEntityManager();
        List<Hike> hikes = entityManager.createQuery("SELECT h FROM Hike h WHERE h.name ILIKE :name", Hike.class)
                .setParameter("name", "%" + name + "%")
                .getResultList();
        entityManager.close();
        return hikes;
    }

}
