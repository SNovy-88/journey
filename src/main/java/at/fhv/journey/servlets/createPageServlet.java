package at.fhv.journey.servlets;

import io.hypersistence.utils.hibernate.type.range.Range;
import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.transaction.Transactional;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.stream.Collectors;

@WebServlet(name = "createPageServlet", value = "/create_hike")
@MultipartConfig
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

        Range<Integer> recommendedMonths = Range.closed(2, 5);
        String author = "testAuthor";
        LocalDate date = LocalDate.now();

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
        hike.setRecommendedMonths(recommendedMonths);
        hike.setAuthor(author);
        hike.setDateCreated(date);

        // Check the switch state
        String switchState = request.getParameter("switchState");

        if ("upload".equals(switchState)) {
            // File Upload feature is active
            Part gpxDataUploadPart = request.getPart("gpxDataUpload");
            if (gpxDataUploadPart != null) {
                // Process the fileContent as needed and save it to the database
                InputStream fileContent = gpxDataUploadPart.getInputStream();
                String gpxDataUpload = new BufferedReader(new InputStreamReader(fileContent))
                        .lines().collect(Collectors.joining("\n"));
                hike.setGpxLocation(gpxDataUpload);
            }
        } else {
            // Map feature is active
            String gpxDataInput = request.getParameter("gpxDataInput");
            hike.setGpxLocation(gpxDataInput);
        }

        DatabaseFacade db = DatabaseFacade.getInstance();
        db.saveObject(hike);

        response.sendRedirect("/Journey_war_exploded/createHike.jsp?success=true");
    }
}
