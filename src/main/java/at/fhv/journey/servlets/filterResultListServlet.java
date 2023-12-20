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

        DatabaseFacade df = new DatabaseFacade();
        List<Hike> hikeList;
        System.out.println("fitness-FilterServlet: " + fitness);

        //Todo months is empty, needs to be changed to bootstrap checkboxes and code changed

        if (fitness != null || stamina != null || experience != null || scenery != null) {
            System.out.println("Months-FilterServlet: " + chosenMonths);
            hikeList = df.getHikesWithFilter(searchString, fitness, stamina, experience, scenery, chosenMonths);

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