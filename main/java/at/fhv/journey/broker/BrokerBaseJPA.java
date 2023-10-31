package at.fhv.journey.broker;

import at.fhv.journey.model.Hike;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public abstract class BrokerBaseJPA<T> {

    public EntityManager getEntityManager() {
        EntityManagerFactory fact = Persistence.createEntityManagerFactory("journey");
        EntityManager entityManager = fact.createEntityManager();

        return entityManager;
    }

    public void save(T value) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.merge(value);
        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public void delete(T value) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.remove(entityManager.contains(value) ? value : entityManager.merge(value));
        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public abstract T get(int value);

    public abstract List<Hike> getAll();
}
