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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HikeBrokerJPA extends BrokerBaseJPA<Hike> {
    //Todo months filter needs to be added and the other text fields
    public List<Hike> getHikesWithFilter(String name, String fitness, String stamina, String experience, String scenery,
                                         Integer months, String heightDiff, String distance, String duration) {
        EntityManager entityManager = getEntityManager();

        // Start with base query
        StringBuilder queryString = new StringBuilder("SELECT h FROM Hike h WHERE TRIM(h.name) ILIKE :name");
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("name", "%" + name + "%");


        // Append conditions for each filter if they are not null
        if ((fitness != null) && (!fitness.isEmpty())) {
            System.out.println("fitness-HikeBroker: " + fitness);
            Integer fitnessInt = Integer.parseInt(fitness);
            queryString.append(" AND h.fitnessLevel = :fitness");
            parameters.put("fitness", fitnessInt);
        }
        if (stamina != null && (!stamina.isEmpty())) {
            Integer staminaInt = Integer.parseInt(stamina);
            queryString.append(" AND h.stamina = :stamina");
            parameters.put("stamina", staminaInt);
        }
        if (experience != null && !experience.isEmpty()) {
            Integer experienceInt = Integer.parseInt(experience);
            queryString.append(" AND h.experience = :experience");
            parameters.put("experience", experienceInt);
        }
        if (scenery != null && !scenery.isEmpty()) {
            Integer sceneryInt = Integer.parseInt(scenery);
            queryString.append(" AND h.scenery = :scenery");
            parameters.put("scenery", sceneryInt);
        }
        if (heightDiff != null && !heightDiff.isEmpty()) {
            Integer heightDiffInt = Integer.parseInt(heightDiff);
            queryString.append(" AND h.heightDifference <= :heightDiff");
            parameters.put("heightDiff", heightDiffInt);
        }
        if (distance != null && !distance.isEmpty()) {
            Integer distanceInt = Integer.parseInt(distance);
            queryString.append(" AND h.distance <= :distance");
            parameters.put("distance", distanceInt);
        }
        if (duration != null && !duration.isEmpty()) {
            Integer durationInt = Integer.parseInt(duration);
            queryString.append(" AND h.duration <= :duration");
            parameters.put("duration", durationInt);
        }

        Query query = entityManager.createQuery(queryString.toString(), Hike.class);
        for (Map.Entry<String, Object> entry : parameters.entrySet()) {
            query.setParameter(entry.getKey(), entry.getValue());
        }

        System.out.println(queryString);

        List<Hike> hikes = query.getResultList();
        entityManager.close();

        List <Hike> finalHikesList = null;

        for (Hike hike : hikes) {
            int bitmask = hike.getRecommendedMonths();
            if ((months & bitmask) != 0) {
                finalHikesList.add(hike);
            }
        }

        return finalHikesList;
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
