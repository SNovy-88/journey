package at.fhv.journey.hibernate.facade;

import at.fhv.journey.model.Hike;

import java.util.List;
import java.util.UUID;

public interface IdbFacadeJPA {

    // INSERT + UPDATE (SAVE)
    void saveObject(Object value);

    // DELETE
    void deleteObject(Object value);

    // READ
    List<Hike> getAllHikes();
    Hike getHikeByID(UUID id);
    List<Hike> getHikesByName(String name);
}
