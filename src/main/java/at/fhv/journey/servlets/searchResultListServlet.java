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
import java.util.List;

import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "searchResultList", value = "/searchResultList")
public class searchResultListServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Retrieve the search string from the request parameters
        String searchString = request.getParameter("searchString");

        // If the search string is not null or empty, filter the hikes based on the search string
        if (searchString != null && !searchString.isEmpty()) {
            DatabaseFacade df = new DatabaseFacade();
            List<Hike> filteredHikeList = df.getHikesByName(searchString);
            request.setAttribute("hikeList", filteredHikeList);
        } else {
            // If no search string provided, return all hikes
            DatabaseFacade df = new DatabaseFacade();
            List<Hike> hikeList = df.getAllHikes();
            request.setAttribute("hikeList", hikeList);
        }

        try {
            request.getRequestDispatcher("/searchResultList.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    public void destroy() {
    }
}