package at.fhv.journey.hibernate.facade;

import at.fhv.journey.hibernate.broker.CommentBrokerJPA;
import at.fhv.journey.hibernate.broker.HikeBrokerJPA;
import at.fhv.journey.hibernate.broker.UserBrokerJPA;
import at.fhv.journey.model.Comment;
import at.fhv.journey.model.Hike;
import at.fhv.journey.model.User;

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

    public List<Comment> getCommentsForHike(int hikeId){
        try (CommentBrokerJPA cb = new CommentBrokerJPA()){
            return cb.getCommentsForHike(hikeId);
        }
    }

    public List<Comment> getCommentsForUser(int userId){
        try (CommentBrokerJPA cbu = new CommentBrokerJPA()){
            return cbu.getCommentsForUser(userId);
        }
    }

    public static void main(String[] args) {

        DatabaseFacade facade = DatabaseFacade.getInstance();
        //Test für die getCommentForHike Methode
        int hikeIdForTest = 1;
        List<Comment> commentsForHike = facade.getCommentsForHike(hikeIdForTest);

        System.out.println("Comments for Hike with ID " + hikeIdForTest + ":");
        for (Comment comment : commentsForHike) {
            System.out.println("Comment ID: " + comment.getCommentId());
            System.out.println("User ID: " + comment.getUser().getUser_id());
            System.out.println("Comment Text: " + comment.getCommentText());
        }

        //Test für die getCommentForUser Methode
        int userIdForTest = 4;
        List<Comment> commentsForUser = facade.getCommentsForUser(userIdForTest);

        System.out.println("Comments for User with ID " + userIdForTest + ":");
        for (Comment comment : commentsForUser) {
            System.out.println("Comment ID: " + comment.getCommentId());
            System.out.println("Hike ID: " + comment.getHike().getHike_id());
            System.out.println("Comment Text: " + comment.getCommentText());
        }
    }
}