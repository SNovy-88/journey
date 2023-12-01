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
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.stream.Collectors;

@WebServlet(name = "createPageServlet", value = "/create_hike")
@MultipartConfig
public class createPageServlet extends HttpServlet {
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        //Stepper 1
        String name = request.getParameter("nameInput");
        String description = request.getParameter("descInput");

        //Stepper 2
        int durationHour = 12;
        int durationMin = 12;
        BigDecimal distance = BigDecimal.valueOf(12.56);
        distance = distance.setScale(2, RoundingMode.HALF_UP);
        int heightDifference = 23;

        int fitnessLevel = 3;
        int stamina = 1;
        int experience = 4;
        int scenery = 5;

        int recommendedMonths = 101010101;
        String author = "testAuthor";
        LocalDate date = LocalDate.now();

        Hike hike = new Hike();
        hike.setHikeId(99);
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
