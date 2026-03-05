package lk.icbt.oceanview.dashboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import lk.icbt.oceanview.reservation.dao.ReservationDAO;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String page = req.getParameter("page");

        if (page == null || page.isBlank()) {
            page = "home";
        }

        /*
        SPECIAL ROUTE:
        If user clicks "Add Reservation", we forward to ReservationFormServlet.
        That servlet loads room types + available rooms from DB.
        */
        if ("reservationForm".equals(page)) {
            req.getRequestDispatcher("/reservations/form").forward(req, resp);
            return;
        }

        /*
        When user opens "View Reservations",
        load reservation list with joined data
        */
        if ("reservationList".equals(page)) {

            try {
                req.setAttribute("reservations",
                        reservationDAO.findLatestWithDetails(30));
            } catch (Exception e) {
                req.setAttribute("pageError",
                        "Unable to load reservations.");
            }
        }

        /*
        Pass page variable to dashboard layout
        so dashboard.jsp loads the correct module
        */
        req.setAttribute("page", page);

        req.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard.jsp")
                .forward(req, resp);
    }
}