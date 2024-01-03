/*
 * Copyright (c) 2023 Sarah N
 *
 * Project Name:         Journey
 * Description:
 *
 * Date of Creation/
 * Last Update:          22/11/2023
 */

package at.fhv.journey.servlets;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "filterResultList", value = "/filterResultList")
public class filterResultListServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Retrieve the search string from the request parameters
        System.out.println("searchString-Filter Servlet: " + "//" + request.getParameter("searchString") + "//");
        String searchString = request.getParameter("search-input-hidden");
        String fitness = request.getParameter("fitness-level");
        String stamina = request.getParameter("stamina");
        String experience = request.getParameter("experience");
        String scenery = request.getParameter("scenery");

        LinkedList<String> monthsList = new LinkedList<>(List.of("Jan", "Feb", "Mar", "Apr",
                "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"));
        int chosenMonths = 0;
        for(String month : monthsList) {
            String monthValue = request.getParameter(month);
            if (monthValue != null) {
                chosenMonths += Integer.parseInt(monthValue);
            }
        }

        String heightDifference = request.getParameter("height-difference");
        String distance = request.getParameter("distance");
        String durationHr = request.getParameter("duration-hr");
        String durationMin = request.getParameter("duration-min");
        //TODO duration doesnt work properly as it will still find 1h 30min when 40min is selected or when only 1hr is selected
        //also when 1hr 30min is selected it will not find 0hr and 50min, the hr and min need to be calculated into min and then compared

        if(durationHr.isEmpty() && !durationMin.isEmpty()){
            durationHr = "0";
        }

        System.out.println("searchString-FilterServlet: " + searchString);

        System.out.println("Months-FilterServlet: " + chosenMonths);
        System.out.println("FilterServlet: "+"\n"+
                            "height: "+heightDifference+"\n"
                            +"distance: "+distance+"\n"
                            +"duration: "+durationHr+":"+durationMin);

        DatabaseFacade df = new DatabaseFacade();
        List<Hike> hikeList;
        System.out.println("fitness-FilterServlet: " + fitness);



        if (fitness != null || stamina != null || experience != null || scenery != null
                ||  chosenMonths != 0 || heightDifference != null || distance != null || durationHr != null || durationMin != null) {

            hikeList = df.getHikesWithFilter(searchString, fitness, stamina, experience, scenery,
                    chosenMonths, heightDifference, distance, durationHr, durationMin);

        } else if (searchString != null && !searchString.isEmpty()) {
            List<Hike> filteredHikeList = df.getHikesByName(searchString);
            request.setAttribute("hikeList", filteredHikeList);
            hikeList = df.getHikesByName(searchString);
        } else {
            // If no search string provided, return all hikes
            hikeList = df.getAllHikes();
            request.setAttribute("hikeList", hikeList);
        }

        request.setAttribute("hikeList", hikeList);

        try {
            request.getRequestDispatcher("/searchResultList.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }

    }

    public void destroy() {
    }
}