package at.fhv.journey.servlets;

import at.fhv.journey.model.User;
import at.fhv.journey.hibernate.facade.DatabaseFacade;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "registerPageServlet", value = "/registerPageServlet")
public class registerPageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (!isExistingUser(email)) {
            // Hash the password before storing it in the database
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            User newUser = new User();
            newUser.setUsername(username);
            newUser.setEmail(email);
            newUser.setHashedPassword(hashedPassword);

            try {
                DatabaseFacade df = new DatabaseFacade();
                df.saveObject(newUser);

                // Set session attribute for successful registration
                HttpSession session = request.getSession();
                session.setAttribute("registrationSuccess", true);

                request.getRequestDispatcher("login.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("register.jsp?error=registration_failed");
            }
        } else {
            // Redirect to registration page with an error message
            response.sendRedirect("register.jsp?error=user_exists");
        }
    }

    private boolean isExistingUser(String email) {
        try {
            DatabaseFacade df = new DatabaseFacade();
            List<User> existingUser = df.getUsersByEmail(email);
            return existingUser != null && !existingUser.isEmpty();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
