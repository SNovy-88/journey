package at.fhv.journey.hibernate;

import at.fhv.journey.hibernate.broker.BrokerBaseJPA;
import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

class BrokerBaseJPATest {

    @Test
    void insert() {
        Hike testHike = new Hike(9999, "TestingInsert", 12.3, 2, 45, "This is to test if the insert works", 143, 3);
        BrokerBaseJPA<Hike> bbh = new BrokerBaseJPA<>();
        bbh.insert(testHike);

        DatabaseFacade df = new DatabaseFacade();
        Hike testHike2 = df.getHikeByID(9999);
        assertEquals(9999, testHike2.getHike_id());

        Hike testHikevs2 = new Hike(9999, "TestingInsert with same ID", 9, 2, 45, "This is to test if the insert works and updates the values", 143, 3);
        bbh.insert(testHikevs2);

        testHike2 = df.getHikeByID(9999);
        BigDecimal dist = BigDecimal.valueOf(9.0);
        assertEquals(dist, testHike2.getDistance());

    }
}