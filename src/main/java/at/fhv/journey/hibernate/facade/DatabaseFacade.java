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
            HikeBrokerJPA hb = new HikeBrokerJPA();
            hb.save((Hike) value);
        }
    }

    @Override
    public void deleteObject(Object value) {
        if (value instanceof Hike) {
            HikeBrokerJPA hb = new HikeBrokerJPA();
            hb.delete((Hike) value);
        }
    }

    @Override
    public List<Hike> getAllHikes() {
        HikeBrokerJPA hb = new HikeBrokerJPA();
        return hb.getAll();
    }

    @Override
    public Hike getHikeByID(int id) {
        HikeBrokerJPA hb = new HikeBrokerJPA();
        return hb.get(id);
    }

    public static void main(String[] args) {
        DatabaseFacade df = new DatabaseFacade();
       /* List allHikes = df.getAllHikes();
        for (Hike h : (List<Hike>) allHikes){
            System.out.println(h.getName());
        }*/

        /*Hike testHike = df.getHikeByID(1);
        System.out.println(testHike.getHike_id()+" "+testHike.getName());*/

        //Hike newHike = new Hike(1, "Alplochschlucht - Kirchle loop from Kehlegg", 8.66, 2, 50, 390, 3  );
        //Hike newHike1 = new Hike(2, "TEST", 8.66, 2, 50, 390, 3  );
        //df.saveObject(newHike);
        //df.saveObject(newHike1);

        List<Hike> testlist = df.getAllHikes();

        //System.out.println(newHike.getHike_id()+" "+newHike.getName());
        for (Hike h: testlist) {
            System.out.println(h.getHike_id() + " " + h.getName());
        }
    }
}
