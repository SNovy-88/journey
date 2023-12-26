/*
 * Copyright (c) 2023 Sarah N
 *
 * Project Name:         Journey
 * Description:
 *
 * Date of Creation/
 * Last Update:          21/11/2023
 */

package at.fhv.journey.servlets;

import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Comment;
import at.fhv.journey.model.User;
import at.fhv.journey.model.Hike;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.http.HttpSession;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;


import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet(name = "detailPage", value = "/detailPage")
public class detailPageServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        int hikeId = Integer.parseInt(request.getParameter("hike-id"));

        DatabaseFacade df = new DatabaseFacade();
        Hike chosenhike = df.getHikeByID(hikeId);
        request.setAttribute("hike", chosenhike);

        String xmlText = chosenhike.getGpxLocation();

        request.setAttribute("xmlText", xmlText);

        extractWaypoints(xmlText, request);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/hikeDetails.jsp");
        dispatcher.forward(request, response);

    }

    public void destroy(){

    }


    public void extractWaypoints(String xmlText, HttpServletRequest request) {
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();

            InputStream stream = new ByteArrayInputStream(xmlText.getBytes(StandardCharsets.UTF_8));
            Document document = builder.parse(stream);

            NodeList waypointNodes = document.getElementsByTagName("wpt");

            List<Map<String, String>> waypointsList = new ArrayList<>();

            // Iterate through Waypoints and add them to the list
            for (int i = 0; i < waypointNodes.getLength(); i++) {
                Element waypoint = (Element) waypointNodes.item(i);
                String latitude = waypoint.getAttribute("lat");
                String longitude = waypoint.getAttribute("lon");
                String name = waypoint.getElementsByTagName("name").item(0).getTextContent();
                String type = waypoint.getElementsByTagName("type").item(0).getTextContent();
                String description = waypoint.getElementsByTagName("desc").item(0).getTextContent();

                Map<String, String> waypointMap = new HashMap<>();
                waypointMap.put("latitude", latitude);
                waypointMap.put("longitude", longitude);
                waypointMap.put("name", name);
                waypointMap.put("type", type);
                waypointMap.put("description", description);

                waypointsList.add(waypointMap);
            }

            // Add Waypoint-List to the request
            request.setAttribute("waypointsList", waypointsList);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Retrieve the hike ID from the request parameter
        //int hikeId = Integer.parseInt(request.getParameter("hike-id"));
        int hikeId = 1;
        // Create a new comment for the hike
        HttpSession session = request.getSession();
        if (true) { //TODO (session.getAttribute("username") != null) --> überprüft ob angemeldet
            String commentText = request.getParameter("commentText"); // Assuming you have an input field for comment text
            DatabaseFacade df = new DatabaseFacade();
            User currentUser = df.getUserByID(9);
            Hike chosenHike = df.getHikeByID(hikeId);

            Comment comment = new Comment(currentUser, chosenHike, commentText, LocalDate.now(),
                    LocalTime.now().getHour(), LocalTime.now().getMinute());

            // Save the comment to the database
            df.saveObject(comment);
        }

        // Forward the request to the hikeDetails.jsp page or any other appropriate page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/hikeDetails.jsp");
        dispatcher.forward(request, response);
    }





}
