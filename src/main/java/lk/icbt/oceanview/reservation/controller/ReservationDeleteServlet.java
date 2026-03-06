package lk.icbt.oceanview.reservation.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.icbt.oceanview.reservation.dao.ReservationDAO;

import java.io.IOException;

@WebServlet("/reservations/delete")
public class ReservationDeleteServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            reservationDAO.deleteById(id);

            HttpSession session = req.getSession();
            session.setAttribute("flashSuccess", "Reservation deleted successfully. ID: " + id);

        } catch (Exception ignored) {}

        resp.sendRedirect(req.getContextPath() + "/dashboard?page=reservationList");
    }
}