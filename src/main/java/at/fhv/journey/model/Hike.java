package at.fhv.journey.model;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "hike", schema = "journey")
public class Hike {

    private int _hike_id;
    private String _name;
    private double _distance;
    private int _durationHour;
    private int _durationMin;
    private int _heightDifference;
    private int _fitnessLevel;
    private String _description;
    private int _recommendedMonths;

    private int _stamina;
    private int _experience;
    private int _scenery;
    private String _author;
    private LocalDate _dateCreated;
    private String _gpxLocation;

    public Hike(){

    }

    public Hike(int hike_id, String name, double distance, int durationHour, int durationMin, String description,
                int heightDifference, int fitnessLevel){
        _hike_id = hike_id;
        _name = name;
        _distance = distance;
        _durationHour = durationHour;
        _durationMin = durationMin;
        _heightDifference = heightDifference;
        _fitnessLevel = fitnessLevel;
        _description = description;
    }

    @Id
    @Column(name = "hike_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getHike_id() {
        return _hike_id;
    }
    public void setHike_id(int hike_id) {
        _hike_id = hike_id;
    }

    @Column(name = "name")
    public String getName() {
        return _name;
    }
    public void setName(String name) {
        _name = name;
    }

    @Column(name = "distance")
    public double getDistance() {
        return _distance;
    }
    public void setDistance(double distance) {
        _distance = distance;
    }

    @Column(name = "duration_hour")
    public int getDurationHour() {
        return _durationHour;
    }
    public void setDurationHour(int durationHour) {
        _durationHour = durationHour;
    }

    @Column(name = "duration_min")
    public int getDurationMin() {
        return _durationMin;
    }
    public void setDurationMin(int durationMin) {
        _durationMin = durationMin;
    }

    @Column(name = "height_difference")
    public int getHeightDifference() {
        return _heightDifference;
    }
    public void setHeightDifference(int heightDifference) {
        _heightDifference = heightDifference;
    }

    @Column(name = "fitness_level")
    public int getFitnessLevel() {
        return _fitnessLevel;
    }
    public void setFitnessLevel(int fitnessLevel) {
        _fitnessLevel = fitnessLevel;
    }

    @Column(name = "description")
    public String getDescription() {
        return _description;
    }
    public void setDescription(String description) {
        _description = description;
    }


    @Column(name = "stamina")
    public int getStamina() {
        return _stamina;
    }
    public void setStamina(int stamina) {
        _stamina = stamina;
    }

    @Column(name = "experience")
    public int getExperience() {
        return _experience;
    }
    public void setExperience(int experience) {
        _experience = experience;
    }

    @Column(name = "scenery")
    public int getScenery() {
        return _scenery;
    }
    public void setScenery(int scenery) {
        _scenery = scenery;
    }

    @Column(name = "author")
    public String getAuthor() {
        return _author;
    }
    public void setAuthor(String author) {
        _author = author;
    }

    @Column(name = "date")
    public LocalDate getDateCreated() {
        return _dateCreated;
    }
    public void setDateCreated(LocalDate dateCreated) {
        _dateCreated = dateCreated;
    }

    @Column(name = "gpx")
    public String getGpxLocation() {
        return _gpxLocation;
    }
    public void setGpxLocation(String gpxLocation) {
        _gpxLocation = gpxLocation;
    }


    @Column(name = "suggested_months")
    public int getRecommendedMonths() {
        return _recommendedMonths;
    }

    public void setRecommendedMonths(int recommendedMonths) {
        _recommendedMonths = recommendedMonths;
    }


    //Functions to convert 1-5 Scales into String output

    public String convertFitnessLevelToString() {

        switch (_fitnessLevel) {
            case 1:
                return "EASY";
            case 2:
                return "MODERATE";
            case 3:
                return "INTERMEDIATE";
            case 4:
                return "CHALLENGING";
            case 5:
                return "EXPERT";
            default:
                return "UNKNOWN";
        }
    }
}
