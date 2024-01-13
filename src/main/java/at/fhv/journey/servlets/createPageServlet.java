package at.fhv.journey.servlets;

import at.fhv.journey.hibernate.facade.DatabaseFacade;
import at.fhv.journey.model.Hike;
import at.fhv.journey.utils.imagePath;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.transaction.Transactional;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@WebServlet(name = "createPageServlet", value = "/create_hike")
@MultipartConfig
public class createPageServlet extends HttpServlet {
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();

        //Stepper 1
        String name = request.getParameter("nameInput");
        String description = request.getParameter("descInput");

        //Stepper 2
        int durationHour = Integer.parseInt(request.getParameter("duration-hr"));
        int durationMin = Integer.parseInt(request.getParameter("duration-min"));
        double distance = Double.parseDouble(request.getParameter("distance"));
        int heightDifference = Integer.parseInt(request.getParameter("height-difference"));

        int fitnessLevel = Integer.parseInt(request.getParameter("fitness-level"));
        int stamina = Integer.parseInt(request.getParameter("stamina"));
        int experience = Integer.parseInt(request.getParameter("experience"));
        int scenery = Integer.parseInt(request.getParameter("scenery"));

        // Defining List of months, iterating over it and the checkboxes,
        // Check they are not null and add value
        LinkedList<String> monthsList = new LinkedList<>(List.of("Jan", "Feb", "Mar", "Apr",
                "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"));
        int checkedMonths = 0;

        for (String month : monthsList) {
            String monthValue = request.getParameter(month);

            if (monthValue != null) {
                checkedMonths += Integer.parseInt(monthValue);
            }
        }

        LocalDate date = LocalDate.now();

        Hike hike = new Hike();
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
        hike.setRecommendedMonths(checkedMonths);
        hike.setDateCreated(date);
        hike.setImage("test1.jpg");

        Part filePart = request.getPart("image");
        // Get the InputStream to upload the file to the server
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream fileContent = filePart.getInputStream();
                 InputStream fileContent2 = filePart.getInputStream()) {

                String fileName = UUID.randomUUID() + ".jpg";

                // Use Paths.get instead of resolve to construct a path relative to the source directory
                Path serverImagePath = Paths.get(getServletContext().getRealPath(imagePath.getImagePath()),fileName);
                Path serverPath = Paths.get(getServletContext().getRealPath(""));
                Path subPath = serverPath.subpath(0, serverPath.getNameCount() - 2);
                Path realPath = Paths.get(serverImagePath.getRoot().toString(), subPath.toString(), imagePath.getImagePathFromRepository(), fileName);

                if (!Files.exists(serverImagePath)) {
                    Files.createDirectories(serverImagePath);
                }
                Files.copy(fileContent, serverImagePath, StandardCopyOption.REPLACE_EXISTING);
                if (!Files.exists(realPath)) {
                    Files.createDirectories(realPath);
                }
                Files.copy(fileContent2, realPath, StandardCopyOption.REPLACE_EXISTING);

                hike.setImage(fileName);
            }
        }



        //TODO needs to be changed to userId once Create is locked for normal users
        if (session.getAttribute("username") != null) {
            hike.setAuthor((String) session.getAttribute("username"));
        } else {
            hike.setAuthor("testAuthor");
        }

        // Check the switch state ('map' or 'upload')
        String switchState = request.getParameter("switchState");

        if ("upload".equals(switchState)) {
            // File Upload feature is active
            Part gpxDataUploadPart = request.getPart("gpxDataUpload");

            if (gpxDataUploadPart != null) {
                // Process the fileContent as needed and save it to the database
                InputStream fileContent = gpxDataUploadPart.getInputStream();
                String gpxDataUpload = new BufferedReader(new InputStreamReader(fileContent))
                        .lines().collect(Collectors.joining("\n"));
                hike.setGpxLocation(gpxDataUpload);
            }
        } else {
            // Map feature is active
            String gpxDataInput = request.getParameter("gpxDataInput");
            hike.setGpxLocation(gpxDataInput);
        }

        DatabaseFacade db = DatabaseFacade.getInstance();
        db.saveObject(hike);

        response.sendRedirect("/Journey_war_exploded/createHike.jsp?success=true");
    }
}