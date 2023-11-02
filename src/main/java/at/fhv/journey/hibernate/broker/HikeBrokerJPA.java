package at.fhv.journey.hibernate.broker;

import at.fhv.journey.model.Hike;
import jakarta.persistence.EntityManager;

import java.util.List;

public class HikeBrokerJPA extends BrokerBaseJPA<Hike> {


    @Override
    public Hike get(int hikeID) {
        EntityManager entityManager = getEntityManager();
        Hike hike = entityManager.find(Hike.class, hikeID);
        entityManager.close();
        return hike;
    }

    @Override
    public List<Hike> getAll() {
        EntityManager entityManager = getEntityManager();
        List<Hike> hikes = (List<Hike>) entityManager.createQuery("select h from Hike h", Hike.class).getResultList();
        entityManager.close();
        return hikes;
    }
}
