package at.fhv.journey.facade;

import at.fhv.journey.broker.HikeBrokerJPA;
import at.fhv.journey.model.Hike;

import java.util.List;

public class DatabaseFacade implements IdbFacadeJPA {
    @Override
    public void save(Object value) {
        if (value instanceof Hike) {
            HikeBrokerJPA hb = new HikeBrokerJPA();
            hb.save((Hike) value);
        }
    }

    @Override
    public void delete(Object value) {
        if (value instanceof Hike) {
            HikeBrokerJPA hb = new HikeBrokerJPA();
            hb.delete((Hike) value);
        }
    }

    @Override
    public List<Hike> getAllHikes() {
        HikeBrokerJPA hb = new HikeBrokerJPA();
        List<Hike> hikes = hb.getAll();

        return hikes;
    }

    @Override
    public Hike getHikeByID(int id) {
        HikeBrokerJPA hb = new HikeBrokerJPA();
        Hike hike = hb.get(id);

        return hike;
    }
}
