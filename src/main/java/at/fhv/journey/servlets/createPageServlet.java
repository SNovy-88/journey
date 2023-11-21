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

import java.io.BufferedReader;
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

        // Retrieve the GPX data from the request body
        StringBuilder gpxData = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                gpxData.append(line);
            }
        }

        // Set the GPX data in your Hike object
        hike.setGpxLocation(gpxData.toString());


        DatabaseFacade db = DatabaseFacade.getInstance();
        db.saveObject(hike);

        // Simulate success or failure (modify this based on your actual logic)
        boolean hikeCreationSuccess = true;

        response.sendRedirect("/Journey_war_exploded/createHike.jsp");
    }
}
