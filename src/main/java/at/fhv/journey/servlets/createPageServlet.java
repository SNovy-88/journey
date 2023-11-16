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

        // Simulate success or failure (modify this based on your actual logic)
        boolean hikeCreationSuccess = true;

        // Set the response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Prepare the JSON response
        String jsonResponse = "{\"success\": " + hikeCreationSuccess + "}";

        // Send the JSON response back to the client
        response.getWriter().write(jsonResponse);
    }
}

