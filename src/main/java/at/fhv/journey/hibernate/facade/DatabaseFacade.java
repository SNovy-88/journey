package at.fhv.journey.hibernate.facade;

import at.fhv.journey.hibernate.broker.CommentBrokerJPA;
import at.fhv.journey.hibernate.broker.HikeBrokerJPA;
import at.fhv.journey.hibernate.broker.UserBrokerJPA;
import at.fhv.journey.model.Comment;
import at.fhv.journey.model.Hike;
import at.fhv.journey.model.User;

import java.time.LocalDate;
import java.util.List;

public class DatabaseFacade implements IdbFacadeJPA {

    private static DatabaseFacade _instance;

    public static DatabaseFacade getInstance(){
        if (_instance == null){
            _instance = new DatabaseFacade();
        }
        return _instance;
    }

    @Override
    public void saveObject(Object value) {
        if (value instanceof Hike) {
            try(HikeBrokerJPA hb = new HikeBrokerJPA()) {
                hb.insert((Hike) value);
            }
        }
    }

    @Override
    public void deleteObject(Object value) {
        if (value instanceof Hike) {
            try (HikeBrokerJPA hb = new HikeBrokerJPA()) {
                hb.delete((Hike) value);
            }
        }
    }


    public List<Hike> getAllHikes() {
        try (HikeBrokerJPA hb = new HikeBrokerJPA()) {
            return hb.getAll(Hike.class);
        }
    }


    public Hike getHikeByID(int id) {
        try (HikeBrokerJPA hb = new HikeBrokerJPA()) {
            return hb.getById(Hike.class, id);
        }
    }

    public List<Hike> getHikesByName(String name) {
        try (HikeBrokerJPA hb = new HikeBrokerJPA()){
            return hb.getHikesByName(name);
        }
    }

    public List<User> getUsersByEmail(String email) {
        try (UserBrokerJPA ub = new UserBrokerJPA()){
            return ub.getUsersByEmail(email);
        }
    }

    public List<Comment> getCommentsByUser(int userId) {
        try (CommentBrokerJPA cb = new CommentBrokerJPA()) {
            return cb.getCommentsByUser(userId);
        }
    }


    public static void main(String[] args) {

        DatabaseFacade facade = DatabaseFacade.getInstance();
        try {
            List<Hike> allHikes = facade.getAllHikes();

            for (Hike hike : allHikes) {
                System.out.println("Hike Name: " + hike.getName());

                List<Comment> comments = hike.getComments();
                for (Comment comment : comments) {
                    System.out.println("  Comment: " + comment.getComment_text());
                }

                System.out.println();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}