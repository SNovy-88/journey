package at.fhv.journey.hibernate.broker;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;

import java.util.List;

public class BrokerBaseJPA<T> implements AutoCloseable {

    private EntityManager entityManager;

    public BrokerBaseJPA() {
        EntityManagerFactory fact = Persistence.createEntityManagerFactory("journey");
        entityManager = fact.createEntityManager();
    }

    public EntityManager getEntityManager() {
        return entityManager;
    }

    public void insert(T value) {
        EntityTransaction tx = entityManager.getTransaction();
        tx.begin();
        entityManager.merge(value); // merge macht update oder insert je nachdem ob es den Eintrag gibt
        tx.commit();
    }

    public void delete(T value) {
        entityManager.getTransaction().begin();
        entityManager.remove(entityManager.contains(value) ? value : entityManager.merge(value));
        entityManager.getTransaction().commit();
    }

    public T getById(Class<T> entityClass, int id) {
        T entity = entityManager.find(entityClass, id);
        return entity;
    }

    public List<T> getAll(Class<T> entityClass) {
        List<T> entities = entityManager.createQuery("select e from " + entityClass.getSimpleName() + " e", entityClass).getResultList();
        return entities;
    }



    @Override
    public void close() {
        if (entityManager != null && entityManager.isOpen()) {
            entityManager.close();
        }
    }
}