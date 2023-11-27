package at.fhv.journey.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.util.UUID;

@Entity
@Table(name = "hikeTEST", schema = "journey")
public class HikeTEST {
    private UUID id;
    private String _name;

    public HikeTEST(){

    }

    @Id
    @Column(name = "hike_id")
    public UUID getHike_id() {
        return id;
    }
    public void setHike_id(UUID hike_id) {
        id = hike_id;
    }

    @Column(name = "name")
    public String getName() {
        return _name;
    }
    public void setName(String name) {
        _name = name;
    }
}
