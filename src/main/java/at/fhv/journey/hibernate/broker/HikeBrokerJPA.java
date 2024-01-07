package at.fhv.journey.hibernate.broker;

import at.fhv.journey.model.Hike;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class HikeBrokerJPA extends BrokerBaseJPA<Hike> {
    public List<Hike> getHikesWithFilter(String name, String fitness, String stamina, String experience, String scenery, Integer months, String heightDiff, String distance, int duration) {
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
            Double distanceInt = Double.parseDouble(distance);
            queryString.append(" AND h.distance <= :distance");
            parameters.put("distance", distanceInt);
        }

        Query query = entityManager.createQuery(queryString.toString(), Hike.class);

        for (Map.Entry<String, Object> entry : parameters.entrySet()) {
            query.setParameter(entry.getKey(), entry.getValue());
        }

        System.out.println(queryString);

        List<Hike> hikes = query.getResultList();
        entityManager.close();

        List <Hike> finalHikesList = new LinkedList<>(hikes);

        if (months != 0 || duration != 0){
            System.out.println("Final Hikes List has been cleared");
            finalHikesList.clear();
        }

        if (months != 0 || duration != 0) {
            for (Hike hike : hikes) {
                int bitmask = hike.getRecommendedMonths();
                int hikeDuration = (hike.getDurationHour() *60)+ hike.getDurationMin();
                        System.out.println("Hikes bitmaks is: "+bitmask);
                        System.out.println("Hikes months & bitmask equals: "+(months & bitmask));
                        System.out.println("Filtered duration is: "+duration);
                        System.out.println("Hikes duration is: "+hikeDuration);
                if (((months & bitmask) != 0) || (hikeDuration <= duration )) {
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