package at.fhv.journey.servlets;

import io.hypersistence.utils.hibernate.type.range.PostgreSQLRangeType;
import io.hypersistence.utils.hibernate.type.range.Range;
import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "createPageServlet", value = "/create_hike")
public class createPageServlet extends HttpServlet {
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String name = request.getParameter("nameInput");
        String description = request.getParameter("descInput");
        int durationHour = 1;
        int durationMin = 25;
        BigDecimal distance = new BigDecimal("1.25");
        int heightDifference = 950;

        int fitnessLevel = 1;
        int stamina = 1;
        int experience = 1;
        int scenery = 1;

        /*
        Start start = new Start();
        start.setStartID(1);
        start.setName("Start");
        start.setLatitude(40.12);
        start.setLongitude(10.2);

        Destination destination = new Destination();
        destination.setDestinationID(1);
        destination.setName("Destination");
        destination.setLatitude(42.12);
        destination.setLongitude(10.12);
        */

        Hike hike = new Hike();
//        hike.setHikeID(hikeId);
        hike.setName(name);
        hike.setDescription(description);
        hike.setDistance(distance);
        hike.setDurationHour(durationHour);
        hike.setDurationMin(durationMin);
        hike.setHeightDifference(heightDifference);
        hike.setFitnessLevel(fitnessLevel);
        hike.setStamina(stamina);
        hike.setExperience(experience);
        hike.setScenery(scenery);
        hike.setRecommendedMonths(null);

        // Retrieve the GPX data from the request parameter
        String gpxData = request.getParameter("gpxData");
        hike.setGpxLocation(gpxData);

        DatabaseFacade db = DatabaseFacade.getInstance();
        db.saveObject(hike);

        // Simulate success or failure (modify this based on your actual logic)
        boolean hikeCreationSuccess = true;

        // Set the response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Prepare the JSON response
        String jsonResponse = "{\"success\": " + hikeCreationSuccess + "}";

        // Send the JSON response back to the client
        response.getWriter().write(jsonResponse);
        response.sendRedirect("/Journey_war_exploded/createHike.jsp");
    }
}

