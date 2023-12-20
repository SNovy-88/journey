package at.fhv.journey.hibernate.facade;

import at.fhv.journey.model.Hike;

import java.util.List;

public interface IdbFacadeJPA {

    // INSERT + UPDATE (SAVE)
    void saveObject(Object value);

    // DELETE
    void deleteObject(Object value);

    // READ
    List<Hike> getAllHikes();
    Hike getHikeByID(int id);
    List<Hike> getHikesWithFilter(String name, String fitness, String stamina, String experience, String scenery, int months);
    List<Hike> getHikesByName(String name);

}