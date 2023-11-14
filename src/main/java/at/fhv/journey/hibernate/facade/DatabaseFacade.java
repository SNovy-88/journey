package at.fhv.journey.hibernate.facade;

import at.fhv.journey.hibernate.broker.HikeBrokerJPA;
import at.fhv.journey.model.Hike;

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
                hb.save((Hike) value);
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

    public List<Hike> getHikesByName(String name) {
        HikeBrokerJPA hb = new HikeBrokerJPA();
        return hb.getHikesByName(name);
    }

    public static void main(String[] args) {
        DatabaseFacade df = new DatabaseFacade();

        Hike newHike = new Hike(1, "Alplochschlucht - Kirchle loop from Kehlegg", 8.66, 2, 50, 390, 3);
        Hike newHike1 = new Hike(2, "TEST", 8.66, 2, 50, 390, 3);

        df.saveObject(newHike);
        df.saveObject(newHike1);

        List<Hike> testlist = df.getAllHikes();

        for (Hike h: testlist) {
            System.out.println(h.getHike_id() + " " + h.getName());
        }
    }
}
