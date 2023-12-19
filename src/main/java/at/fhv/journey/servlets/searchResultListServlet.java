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
        String fitness = request.getParameter("fitness");
        String stamina = request.getParameter("stamina");
        String experience = request.getParameter("experience");
        String scenery = request.getParameter("scenery");
        String months = request.getParameter("months");

        DatabaseFacade df = new DatabaseFacade();
        List<Hike> hikeList;

        if(fitness != null) {
            hikeList = df.getHikesByName(searchString, Integer.parseInt(fitness), Integer.parseInt(stamina), Integer.parseInt(experience), Integer.parseInt(scenery), Integer.parseInt(months));

        }
        else {
            hikeList = df.getAllHikes();
        }


        // If the search string is not null or empty, filter the hikes based on the search string

            // If no search string provided, return all hikes


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