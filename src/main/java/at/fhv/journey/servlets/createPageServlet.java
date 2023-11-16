package at.fhv.journey.servlets;

import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "createHike", value = "/createHike")
public class createPageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the GPX data from the request parameter
        String gpxData = request.getParameter("gpxData");

        // Do something with the GPX data, such as saving it to a file or processing it
        // For demonstration purposes, let's print it to the console
        System.out.println("Received GPX data:\n" + gpxData);

        // Send a response back to the client (optional)
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Hike created successfully");

        // You might want to perform further processing or error handling here
    }
}

