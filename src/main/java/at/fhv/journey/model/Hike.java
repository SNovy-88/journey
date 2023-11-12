package at.fhv.journey.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.math.BigDecimal;

@Entity
@Table(name = "hike", schema = "journey")
public class Hike {

    private int _hike_id;
    private String _name;
    private BigDecimal _distance;
    private int _durationHour;
    private int _durationMin;
    private int _heightDifference;
    private int _fitnessLevel;
    private String _description;

    public Hike(){

    }

    public Hike(int hike_id, String name, double distance, int durationHour, int durationMin, String Description,
                int heightDifference, int fitnessLevel){
        _hike_id = hike_id;
        _name = name;
        BigDecimal dist = BigDecimal.valueOf(distance);
        _distance = dist;
        _durationHour = durationHour;
        _durationMin = durationMin;
        _heightDifference = heightDifference;
        _fitnessLevel = fitnessLevel;
        _description = Description;
    }

    @Id
    @Column(name = "hike_id")
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
    public void setDescription(String Description) {
        _description = Description;
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
