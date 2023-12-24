package at.fhv.journey.servlets;

import at.fhv.journey.model.User;
import at.fhv.journey.hibernate.facade.DatabaseFacade;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;


@WebServlet(name = "loginPageServlet", value = "/loginPageServlet")
public class loginPageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (isValidUser(email, password)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("email", email);

            String username = getUsernameFromDatabase(email);
            session.setAttribute("username", username);

            response.sendRedirect("success.jsp");
        } else {
            request.setAttribute("loginError", true);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private boolean isValidUser(String email, String password) {
        try {
            DatabaseFacade df = new DatabaseFacade();
            List<User> users = df.getUsersByEmail(email);

            if (users != null && !users.isEmpty()) {
                User user = users.get(0);
                String hashedPassword = user.getHashedPassword();
                return hashedPassword != null && BCrypt.checkpw(password, hashedPassword);
            } else {
                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private String getUsernameFromDatabase(String email) {
        try {
            DatabaseFacade df = new DatabaseFacade();
            List<User> users = df.getUsersByEmail(email);

            if (users != null && !users.isEmpty()) {
                return users.get(0).getUsername();
            } else {
                return null;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
