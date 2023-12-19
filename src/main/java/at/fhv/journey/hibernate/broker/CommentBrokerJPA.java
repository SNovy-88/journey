package at.fhv.journey.hibernate.broker;

import at.fhv.journey.model.Comment;
import jakarta.persistence.EntityManager;

import java.util.List;

public class CommentBrokerJPA extends BrokerBaseJPA<Comment> {

    public List<Comment> getCommentsByUser(int userId) {
        EntityManager entityManager = getEntityManager();
        List<Comment> comments = entityManager.createQuery("SELECT c FROM Comment c WHERE c.user.user_id = :userId", Comment.class)
                .setParameter("userId", userId)
                .getResultList();
        entityManager.close();
        return comments;
    }
}
