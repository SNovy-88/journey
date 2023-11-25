package at.fhv.journey.servlets;

import io.hypersistence.utils.hibernate.type.range.Range;
import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

@WebServlet(name = "createPageServlet", value = "/create_hike")
public class createPageServlet extends HttpServlet {
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        //Stepper 1
        String name = request.getParameter("nameInput");
        String description = request.getParameter("descInput");

        //Stepper 2
        int durationHour = Integer.parseInt(request.getParameter("duration-hr"));
        int durationMin = Integer.parseInt(request.getParameter("duration-min"));
        BigDecimal distance = BigDecimal.valueOf(Double.parseDouble(request.getParameter("distance")));
        System.out.println(distance);
        int heightDifference = Integer.parseInt(request.getParameter("height-difference"));

        int fitnessLevel = Integer.parseInt(request.getParameter("physical-cond"));
        int stamina = Integer.parseInt(request.getParameter("stamina"));
        int experience = Integer.parseInt(request.getParameter("experience"));
        int scenery = Integer.parseInt(request.getParameter("scenery"));

        Range<Integer> recommendedMonths = Range.closed(2, 5);
        String author = "testAuthor";
        LocalDate date = LocalDate.now();

        Hike hike = new Hike();
//      hike.setHikeID(hikeId);
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

        // Set the GPX data in your Hike object
        String gpxData = request.getParameter("gpxData");
        hike.setGpxLocation(gpxData);

        DatabaseFacade db = DatabaseFacade.getInstance();
        db.saveObject(hike);

        response.sendRedirect("/Journey_war_exploded/createHike.jsp?success=true");
    }
}
