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

@WebServlet(name = "loginPageServlet", value = "/loginPageServlet")
public class loginPageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (isValidUser(email, password)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("email", email);
            response.sendRedirect("success.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private boolean isValidUser(String email, String password) {
        try {
            DatabaseFacade df = new DatabaseFacade();
            List<User> users = df.getUsersByEmail(email);

            return users != null && !users.isEmpty() && Objects.equals(users.get(0).getPassword(), password);

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
