package at.fhv.journey.broker;

import at.fhv.journey.model.Hike;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class HikeBrokerJPA extends BrokerBaseJPA<Hike> {


    @Override
    public Hike get(int value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("select h from Hike h where hike_id =: hikeID");
        query.setParameter("hikeID", value);
        Hike hik = (Hike)query.getSingleResult();
        entityManager.close();

        return hik;
    }

    @Override
    public List<Hike> getAll() {
        EntityManager entityManager = getEntityManager();
        List<Hike> hikes = (List<Hike>) entityManager.createQuery("select h from Hike h", Hike.class).getResultList();
        entityManager.close();

        return hikes;
    }
}
