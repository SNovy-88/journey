package at.fhv.journey.servlets;

import java.io.*;
import java.util.List;

import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "searchResultList", value = "/searchResultList")
public class searchResultListServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");


        DatabaseFacade df = new DatabaseFacade();
        List<Hike> hikeList = df.getAllHikes();

        /* connects the attribute name hikeList with the object _hikeList. the variable name hikeList
           can then be used in .jsp file */
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