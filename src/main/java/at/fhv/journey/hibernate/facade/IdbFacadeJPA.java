package at.fhv.journey.hibernate.facade;

import at.fhv.journey.model.Hike;

import java.util.List;

public interface IdbFacadeJPA<T> {

    // INSERT + UPDATE (SAVE)
    public void saveObject(Object value);

    // DELETE
    public void deleteObject(Object value);

    // READ
    public List<T> getAll();
    public T getByID(int id);

}
