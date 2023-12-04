package at.fhv.journey.servlets;

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
import java.util.LinkedList;
import java.util.List;
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
        int durationHour = Integer.parseInt(request.getParameter("duration-hr"));
        int durationMin = Integer.parseInt(request.getParameter("duration-min"));
        BigDecimal distance = BigDecimal.valueOf(Double.parseDouble(request.getParameter("distance")));
        distance = distance.setScale(2, RoundingMode.HALF_UP);
        int heightDifference = Integer.parseInt(request.getParameter("height-difference"));

        int fitnessLevel = Integer.parseInt(request.getParameter("fitness-level"));
        int stamina = Integer.parseInt(request.getParameter("stamina"));
        int experience = Integer.parseInt(request.getParameter("experience"));
        int scenery = Integer.parseInt(request.getParameter("scenery"));

        //defining List of months, iterating over it and the checkboxes,
        //check they are not null and add value
        LinkedList<String> monthsList = new LinkedList<>(List.of("Jan", "Feb", "Mar", "Apr",
                "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"));
        int checkedMonths = 0;
        for(String month : monthsList) {
            String monthValue = request.getParameter(month);
            if (monthValue != null) {
                checkedMonths += Integer.parseInt(monthValue);
            }
        }

        String author = "testAuthor";
        LocalDate date = LocalDate.now();

        Hike hike = new Hike();
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
        hike.setRecommendedMonths(checkedMonths);
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
