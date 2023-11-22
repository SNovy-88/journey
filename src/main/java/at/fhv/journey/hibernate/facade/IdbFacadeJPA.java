package at.fhv.journey.hibernate.facade;

import at.fhv.journey.model.Hike;

import java.util.List;

public interface IdbFacadeJPA {

    // INSERT + UPDATE (SAVE)
    public void saveObject(Object value);

    // DELETE
    public void deleteObject(Object value);

    // READ
    public List<Hike> getAllHikes();
    public Hike getHikeByID(int id);

}
