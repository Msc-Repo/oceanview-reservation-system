package lk.icbt.oceanview.dashboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String page = req.getParameter("page");

        if (page == null || page.isBlank()) {
            page = "home";
        }

        req.setAttribute("page", page);

        req.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard.jsp")
                .forward(req, resp);
    }
}