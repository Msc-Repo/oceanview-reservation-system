package lk.icbt.oceanview.api.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.icbt.oceanview.api.util.JsonUtil;
import lk.icbt.oceanview.reservation.dao.ReservationDAO;
import lk.icbt.oceanview.reservation.model.Reservation;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/reservations")
public class ReservationsApiServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json;charset=UTF-8");

        try {
            List<Reservation> reservations = reservationDAO.findLatestWithDetails(30, null);

            StringBuilder json = new StringBuilder();
            json.append("[");

            for (int i = 0; i < reservations.size(); i++) {
                Reservation r = reservations.get(i);

                json.append("{")
                        .append("\"id\":").append(r.getId()).append(",")
                        .append("\"guestName\":\"").append(JsonUtil.escape(r.getGuestName())).append("\",")
                        .append("\"roomNumber\":\"").append(JsonUtil.escape(r.getRoomNumber())).append("\",")
                        .append("\"roomType\":\"").append(JsonUtil.escape(r.getRoomTypeName())).append("\",")
                        .append("\"checkIn\":\"").append(r.getCheckIn()).append("\",")
                        .append("\"checkOut\":\"").append(r.getCheckOut()).append("\",")
                        .append("\"guestsCount\":").append(r.getGuestsCount()).append(",")
                        .append("\"status\":\"").append(JsonUtil.escape(r.getStatus())).append("\"")
                        .append("}");

                if (i < reservations.size() - 1) {
                    json.append(",");
                }
            }

            json.append("]");
            resp.getWriter().write(json.toString());

        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"Unable to load reservations\"}");
        }
    }
}