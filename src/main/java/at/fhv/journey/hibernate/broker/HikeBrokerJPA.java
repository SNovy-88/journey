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
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class HikeBrokerJPA extends BrokerBaseJPA<Hike> {
    //Todo months filter needs to be added and the other text fields
    public List<Hike> getHikesWithFilter(String name, String fitness, String stamina, String experience, String scenery,
                                         Integer months, String heightDiff, String distance, String durationHr, String durationMin) {
        EntityManager entityManager = getEntityManager();

        // Start with base query
        StringBuilder queryString = new StringBuilder("SELECT h FROM Hike h WHERE TRIM(h.name) ILIKE :name");
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("name", "%" + name + "%");


        // Append conditions for each filter if they are not null
        if ((fitness != null) && (!fitness.isEmpty()) && (!fitness.equals("0"))) {
            System.out.println("fitness-HikeBroker: " + fitness);
            Integer fitnessInt = Integer.parseInt(fitness);
            queryString.append(" AND h.fitnessLevel = :fitness");
            parameters.put("fitness", fitnessInt);
        }
        if (stamina != null && (!stamina.isEmpty()) && (!stamina.equals("0"))) {
            Integer staminaInt = Integer.parseInt(stamina);
            queryString.append(" AND h.stamina = :stamina");
            parameters.put("stamina", staminaInt);
        }
        if (experience != null && !experience.isEmpty() && (!experience.equals("0"))){
            Integer experienceInt = Integer.parseInt(experience);
            queryString.append(" AND h.experience = :experience");
            parameters.put("experience", experienceInt);
        }
        if (scenery != null && !scenery.isEmpty() && (!scenery.equals("0"))) {
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
        if (durationHr != null && !durationHr.isEmpty()) {
            Integer durationHrInt = Integer.parseInt(durationHr);
            queryString.append(" AND h.durationHour <= :durationHr");
            parameters.put("durationHr", durationHrInt);
        }
        if (durationMin != null && !durationMin.isEmpty()) {
            Integer durationMinInt = Integer.parseInt(durationMin);
            queryString.append(" AND h.durationMin <= :durationMin");
            parameters.put("durationMin", durationMinInt);
        }

        Query query = entityManager.createQuery(queryString.toString(), Hike.class);
        for (Map.Entry<String, Object> entry : parameters.entrySet()) {
            query.setParameter(entry.getKey(), entry.getValue());
        }

        System.out.println(queryString);

        List<Hike> hikes = query.getResultList();
        entityManager.close();


        List <Hike> finalHikesList = new LinkedList<>(hikes);

        if (months != 0){
            System.out.println("Final Hikes List has been cleared");
            finalHikesList.clear();
        }
        if(months != 0) {
            for (Hike hike : hikes) {
                int bitmask = hike.getRecommendedMonths();
                System.out.println("Hikes bitmaks is: "+bitmask);
                System.out.println("Hikes months & bitmask equals: "+(months & bitmask));
                if ((months & bitmask) != 0) {
                    System.out.println("Hike added to finalHikesList");
                    finalHikesList.add(hike);
                }
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
