package at.fhv.journey.hibernate;

import at.fhv.journey.hibernate.broker.BrokerBaseJPA;
import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import io.hypersistence.utils.hibernate.type.range.Range;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

class BrokerBaseJPATest {

    @Test
    void insert() {
        Hike testHike = new Hike("TestingInsert", 12.3, 2, 45,
                        "This is to test if the insert works",143, 1, 3, 1, 1,
                                  Range.integerRange("[2,5]"),"John","local");
        BrokerBaseJPA<Hike> bbh = new BrokerBaseJPA<>();
        bbh.insert(testHike);
        UUID testHikeUUID = testHike.getHike_id();

        DatabaseFacade df = new DatabaseFacade();

        assertEquals(testHike.getHike_id(), testHikeUUID);

        Hike testHike2 = new Hike("TestingInsert with same ID", 9, 2, 45,
                                "This is to test if the insert works and updates the values", 143, 3, 1,3,2,
                                Range.integerRange("[2,5]"),"John","local");
        bbh.insert(testHike2);
        UUID testHike2UUID = testHike.getHike_id();

        testHike2 = df.getHikeByID(testHike2UUID);
        BigDecimal dist = BigDecimal.valueOf(9.0);
        assertEquals(dist, testHike2.getDistance());

    }
}