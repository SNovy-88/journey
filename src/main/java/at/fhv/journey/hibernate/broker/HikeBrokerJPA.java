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
        List<Hike> hikes = entityManager.createQuery("select h from Hike h", Hike.class).getResultList();
        entityManager.close();
        return hikes;
    }

    public List<Hike> getHikesByName(String name) {
        EntityManager entityManager = getEntityManager();
        List<Hike> hikes = entityManager.createQuery("SELECT h FROM Hike h WHERE h.name LIKE :name", Hike.class)
                .setParameter("name", "%" + name + "%")
                .getResultList();
        entityManager.close();
        return hikes;
    }
}