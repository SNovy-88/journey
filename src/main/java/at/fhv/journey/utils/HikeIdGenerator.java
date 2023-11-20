package at.fhv.journey.utils;

public class HikeIdGenerator {
    private static int _newId = 20;

    public static int getNewId(){
        _newId++;
        return(_newId);
    }
}
