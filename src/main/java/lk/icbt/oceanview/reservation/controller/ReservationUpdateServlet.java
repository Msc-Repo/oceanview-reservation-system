package lk.icbt.oceanview.reservation.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.icbt.oceanview.reservation.service.ReservationService;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/reservations/update")
public class ReservationUpdateServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        String reservationIdStr = req.getParameter("reservationId");

        try {
            int reservationId = Integer.parseInt(reservationIdStr);
            int guestId = Integer.parseInt(req.getParameter("guestId"));
            int typeId = Integer.parseInt(req.getParameter("typeId"));
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            int currentRoomId = Integer.parseInt(req.getParameter("currentRoomId"));

            String fullName = req.getParameter("fullName");
            String phone = req.getParameter("phone");
            String email = req.getParameter("email");

            LocalDate checkIn = LocalDate.parse(req.getParameter("checkIn"));
            LocalDate checkOut = LocalDate.parse(req.getParameter("checkOut"));
            int guestsCount = Integer.parseInt(req.getParameter("guestsCount"));

            reservationService.updateReservation(
                    reservationId, guestId, fullName, phone, email,
                    typeId, roomId, checkIn, checkOut, guestsCount, currentRoomId
            );

            req.getSession().setAttribute("flashSuccess",
                    "Reservation updated successfully. ID: " + reservationId);

            resp.sendRedirect(req.getContextPath() + "/dashboard?page=reservationList");

        } catch (IllegalArgumentException ex) {
            req.getSession().setAttribute("flashError", ex.getMessage());
            resp.sendRedirect(req.getContextPath()
                    + "/dashboard?page=reservationEdit&id=" + reservationIdStr);

        } catch (Exception ex) {
            req.getSession().setAttribute("flashError",
                    "Unable to update reservation. Please try again.");
            resp.sendRedirect(req.getContextPath()
                    + "/dashboard?page=reservationEdit&id=" + reservationIdStr);
        }
    }
}