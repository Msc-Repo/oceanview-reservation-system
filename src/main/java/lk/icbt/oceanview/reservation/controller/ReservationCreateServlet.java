package lk.icbt.oceanview.reservation.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.icbt.oceanview.reservation.service.ReservationService;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet("/reservations/create")
public class ReservationCreateServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String fullName = req.getParameter("fullName");
            String nic = req.getParameter("nic");
            String phone = req.getParameter("phone");
            String email = req.getParameter("email");

            int typeId = Integer.parseInt(req.getParameter("typeId"));
            int roomId = Integer.parseInt(req.getParameter("roomId"));

            LocalDate checkIn = LocalDate.parse(req.getParameter("checkIn"));
            LocalDate checkOut = LocalDate.parse(req.getParameter("checkOut"));
            int guestsCount = Integer.parseInt(req.getParameter("guestsCount"));

            int newId = reservationService.createReservation(fullName, nic, phone, email, typeId, roomId, checkIn, checkOut, guestsCount);

            HttpSession session = req.getSession();
            session.setAttribute("flashSuccess", "Reservation created successfully. ID: " + newId);

            resp.sendRedirect(req.getContextPath() + "/dashboard?page=reservationList");

        } catch (IllegalArgumentException ex) {
            req.setAttribute("formError", ex.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/reservation/reservation-form.jsp").forward(req, resp);

        } catch (SQLException ex) {
            // Trigger messages are very useful; show safe message
            String msg = ex.getMessage();
            if (msg != null && msg.contains("Selected room is not available")) {
                req.setAttribute("formError", "Selected room is not available for the chosen dates.");
            } else if (msg != null && msg.contains("Check-out date")) {
                req.setAttribute("formError", "Check-out date must be after check-in date.");
            } else {
                req.setAttribute("formError", "Database error. Please try again.");
            }
            req.getRequestDispatcher("/WEB-INF/views/reservation/reservation-form.jsp").forward(req, resp);

        } catch (Exception ex) {
            req.setAttribute("formError", "Invalid input. Please check your data.");
            req.getRequestDispatcher("/WEB-INF/views/reservation/reservation-form.jsp").forward(req, resp);
        }
    }
}