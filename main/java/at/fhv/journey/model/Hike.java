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
}
