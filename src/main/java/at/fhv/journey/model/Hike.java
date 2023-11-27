package at.fhv.journey.model;

import io.hypersistence.utils.hibernate.type.range.PostgreSQLRangeType;
import io.hypersistence.utils.hibernate.type.range.Range;
import jakarta.persistence.*;
import org.hibernate.annotations.Type;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "hiketest", schema = "journey")
public class Hike {

    private UUID _hike_id;
    private String _name;
    private BigDecimal _distance;
    private int _durationHour;
    private int _durationMin;
    private int _heightDifference;
    private int _fitnessLevel;
    private String _description;
    private Range _recommendedMonths;

    private int _stamina;
    private int _experience;
    private int _scenery;
    private String _author;
    private LocalDate _dateCreated;
    private String _gpxLocation;

    public Hike(){

    }

    public Hike( String name, double distance, int durationHour, int durationMin, String description,
                int heightDifference, int fitnessLevel, int stamina, int experience, int scenery, Range recommendedMonths,
                String author, String gpx){
        _name = name;
        _distance = BigDecimal.valueOf(distance);
        _durationHour = durationHour;
        _durationMin = durationMin;
        _heightDifference = heightDifference;
        _fitnessLevel = fitnessLevel;
        _description = description;
        _stamina = stamina;
        _experience = experience;
        _scenery = scenery;
        _recommendedMonths = recommendedMonths; //for TESTING: Range.integerRange("[2,5]")
        _author = author;
        _dateCreated = LocalDate.now();
        _gpxLocation = gpx;
    }

    @Id
    @Column(name = "hike_id")
    @GeneratedValue(generator = "uuid2")
    public UUID getHike_id() {
        return _hike_id;
    }
    public void setHike_id(UUID id) {
        _hike_id = id;
    }

    @Column(name = "name")
    public String getName() {
        return _name;
    }
    public void setName(String name) {
        _name = name;
    }

    @Column(name = "distance")
    public BigDecimal getDistance() {
        return _distance;
    }
    public void setDistance(BigDecimal distance) {
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


    @Column(name = "suggested_month", columnDefinition = "int4range")
    @Type(PostgreSQLRangeType.class)
    public Range getRecommendedMonths() {
        return _recommendedMonths;
    }

    public void setRecommendedMonths(Range recommendedMonths) {
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
