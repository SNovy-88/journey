package at.fhv.journey.hibernate.broker;

import at.fhv.journey.model.Hike;
import at.fhv.journey.model.User;
import jakarta.persistence.EntityManager;

import java.util.List;

public class UserBrokerJPA extends BrokerBaseJPA<User>{

    public List<User> getUsersByEmail(String email) {
        EntityManager entityManager = getEntityManager();
        List<User> users = entityManager.createQuery("SELECT u FROM User u WHERE u.email ILIKE :email", User.class)
                .setParameter("email", "%" + email + "%")
                .getResultList();
        entityManager.close();
        return users;
    }
}
