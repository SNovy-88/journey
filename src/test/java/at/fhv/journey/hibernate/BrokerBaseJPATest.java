package at.fhv.journey.hibernate;

import at.fhv.journey.hibernate.broker.BrokerBaseJPA;
import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import io.hypersistence.utils.hibernate.type.range.Range;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class BrokerBaseJPATest {

    @Test
    void insert() {
        Hike testHike = new Hike("TESTTESTTEST", 8.66, 2, 50, "This route is mostly comprised of accessible pathways, though it does require sure-footedness. Additionally, the starting point of the tour is conveniently reachable using public transportation.",390, 3, 3, 2, 4, Range.integerRange("[2,5]"), "natureNick","TEST ");

        BrokerBaseJPA<Hike> bbh = new BrokerBaseJPA<>();
        bbh.insert(testHike);

        DatabaseFacade df = new DatabaseFacade();
        List<Hike> namedHike = df.getHikesByName(testHike.getName());
        Hike testHikeFromDB = namedHike.get(0);

        //Testing Match by Name
        assertEquals(testHike.getDateCreated(), testHikeFromDB.getDateCreated());
        System.out.println("Match by Name");

        //Testing Match by Id
        Hike testHikeFromDBTestId = df.getHikeByID(testHikeFromDB.getHike_id());
        assertEquals(testHikeFromDB.getHike_id(), testHikeFromDBTestId.getHike_id());
        System.out.println("Match by Id, deleting Object: " + testHikeFromDB.getHike_id());
        df.deleteObject(testHikeFromDB);
/*
        Hike testHike2 = new Hike("TestingInsert with same ID", 9, 2, 45,
                                "This is to test if the insert works and updates the values", 143, 3, 1,3,2,
                                Range.integerRange("[2,5]"),"John","local");
        bbh.insert(testHike2);
        UUID testHike2UUID = df.getHikesByName(testHike2.getName());

        testHike2 = df.getHikeByID(testHike2UUID);
        BigDecimal dist = BigDecimal.valueOf(9.0);
        assertEquals(dist, testHike2.getDistance());
*/
    }
}