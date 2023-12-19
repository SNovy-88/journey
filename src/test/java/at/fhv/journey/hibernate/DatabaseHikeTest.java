package at.fhv.journey.hibernate;

import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;

import java.util.List;

public class DatabaseHikeTest {
    public static void main(String[] args){
        DatabaseFacade df = new DatabaseFacade();
        List<Hike> testlist = df.getAllHikes();

        for (Hike h: testlist) {
            System.out.println(h.getHike_id() + " " + h.getName());
        }
    }
}
