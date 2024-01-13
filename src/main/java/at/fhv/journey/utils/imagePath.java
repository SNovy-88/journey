package at.fhv.journey.utils;

public class imagePath {
    static String _path = "pictures/uploads/";
    static String _pathFromRepository ="src/main/webapp/pictures/uploads";

    public static String getImagePath(){
        return(_path);
    }
    public static String getImagePathFromRepository(){return(_pathFromRepository);}
}
