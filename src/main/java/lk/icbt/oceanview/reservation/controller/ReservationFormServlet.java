package lk.icbt.oceanview.reservation.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.icbt.oceanview.reservation.dao.RoomDAO;
import lk.icbt.oceanview.reservation.dao.RoomTypeDAO;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/reservations/form")
public class ReservationFormServlet extends HttpServlet {

    private final RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            req.setAttribute("roomTypes", roomTypeDAO.findAll());

            // default dates (today + tomorrow) if not provided
            LocalDate checkIn = parseDate(req.getParameter("checkIn"), LocalDate.now());
            LocalDate checkOut = parseDate(req.getParameter("checkOut"), LocalDate.now().plusDays(1));

            int typeId = parseInt(req.getParameter("typeId"), 0);

            req.setAttribute("checkIn", checkIn.toString());
            req.setAttribute("checkOut", checkOut.toString());
            req.setAttribute("selectedTypeId", typeId);

            if (typeId > 0) {
                req.setAttribute("availableRooms", roomDAO.findAvailableRooms(typeId, checkIn, checkOut));
            }

        } catch (Exception e) {
            req.setAttribute("formError", "Unable to load room data. Please try again.");
        }

        // forward directly to module JSP (dashboard includes it)
        req.getRequestDispatcher("/WEB-INF/views/reservation/reservation-form.jsp").forward(req, resp);
    }

    private LocalDate parseDate(String val, LocalDate fallback) {
        try { return (val == null || val.isBlank()) ? fallback : LocalDate.parse(val); }
        catch (Exception e) { return fallback; }
    }

    private int parseInt(String val, int fallback) {
        try { return (val == null || val.isBlank()) ? fallback : Integer.parseInt(val); }
        catch (Exception e) { return fallback; }
    }
}