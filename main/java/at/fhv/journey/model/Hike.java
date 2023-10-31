package at.fhv.journey.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "journey.hike")
public class Hike {

    private int hike_id;
    private String name;
    private double distance;
    private int durationHour;
    private int durationMin;
    private int heightDifference;
    private int fitnessLevel;


    @Id
    @Column(name = "hike_id")
    public int getHike_id() {
        return hike_id;
    }
    public void setHike_id(int hike_id) {
        this.hike_id = hike_id;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "distance")
    public double getDistance() {
        return distance;
    }
    public void setDistance(double distance) {
        this.distance = distance;
    }

    @Column(name = "duration_hour")
    public int getDurationHour() {
        return durationHour;
    }
    public void setDurationHour(int durationHour) {
        this.durationHour = durationHour;
    }

    @Column(name = "duration_min")
    public int getDurationMin() {
        return durationMin;
    }
    public void setDurationMin(int durationMin) {
        this.durationMin = durationMin;
    }

    @Column(name = "height_difference")
    public int getHeightDifference() {
        return heightDifference;
    }
    public void setHeightDifference(int heightDifference) {
        this.heightDifference = heightDifference;
    }

    @Column(name = "fitness_level")
    public int getFitnessLevel() {
        return fitnessLevel;
    }
    public void setFitnessLevel(int fitnessLevel) {
        this.fitnessLevel = fitnessLevel;
    }
}
