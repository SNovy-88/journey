package at.fhv.journey.servlets;

import at.fhv.journey.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;

@WebServlet(name = "createPageServlet", value = "/create_hike")
public class SaveDataServlet extends HttpServlet {
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        /*
        String title = request.getParameter("titleInput");
        String description = request.getParameter("descriptionInput");
        */
        String title = "Test";
        String description = "Description";
        double durationHour = 1;
        double durationMinute = 25;
        double distance = 1.1;
        int altitude = 1;

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

        int strength = 1;
        int stamina = 1;
        int experience = 1;
        int landscape = 1;
        boolean january = true;
        boolean february = false;
        boolean march = false;
        boolean april = false;
        boolean may = false;
        boolean june = false;
        boolean july = false;
        boolean august = false;
        boolean september = false;
        boolean october = false;
        boolean november = false;
        boolean december = false;
        String routeDescription = "New Route Description";

        Hike hike = new Hike();
//        hike.setHikeID(hikeId);
        hike.setName(title);
        hike.setDescription(description);
        hike.setDuration(duration);
        hike.setDistance(distance);
        hike.setAltitude(altitude);
        hike.setStart(start);
        hike.setDestination(destination);
        hike.setStrength(strength);
        hike.setStamina(stamina);
        hike.setExperience(experience);
        hike.setLandscape(landscape);
        hike.setJanuary(january);
        hike.setFebruary(february);
        hike.setMarch(march);
        hike.setApril(april);
        hike.setMay(may);
        hike.setJune(june);
        hike.setJuly(july);
        hike.setAugust(august);
        hike.setSeptember(september);
        hike.setOctober(october);
        hike.setNovember(november);
        hike.setDecember(december);
        hike.setRouteDescription(routeDescription);

        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        facadeJPA.save(hike);

        response.sendRedirect("/search_results.jsp");
    }
}

