package lk.icbt.oceanview.dashboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import lk.icbt.oceanview.reservation.dao.ReservationDAO;
import lk.icbt.oceanview.reservation.dao.RoomTypeDAO;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final RoomTypeDAO roomTypeDAO = new RoomTypeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String page = req.getParameter("page");

        HttpSession session = req.getSession(false);
        if (session != null) {
            String flashSuccess = (String) session.getAttribute("flashSuccess");
            String flashError = (String) session.getAttribute("flashError");

            if (flashSuccess != null) {
                req.setAttribute("flashSuccess", flashSuccess);
                session.removeAttribute("flashSuccess");
            }
            if (flashError != null) {
                req.setAttribute("flashError", flashError);
                session.removeAttribute("flashError");
            }
        }

        if (page == null || page.isBlank()) {
            page = "home";
        }

        if ("reservationForm".equals(page)) {
            try {
                req.setAttribute("roomTypes", roomTypeDAO.findAll());

                // Defaults
                String checkInStr = req.getParameter("checkIn");
                String checkOutStr = req.getParameter("checkOut");
                String typeIdStr = req.getParameter("typeId");

                LocalDate checkIn = (checkInStr == null || checkInStr.isBlank())
                        ? LocalDate.now()
                        : LocalDate.parse(checkInStr);

                LocalDate checkOut = (checkOutStr == null || checkOutStr.isBlank())
                        ? LocalDate.now().plusDays(1)
                        : LocalDate.parse(checkOutStr);

                req.setAttribute("checkIn", checkIn.toString());
                req.setAttribute("checkOut", checkOut.toString());

                int selectedTypeId = (typeIdStr == null || typeIdStr.isBlank())
                        ? 0
                        : Integer.parseInt(typeIdStr);

                req.setAttribute("selectedTypeId", selectedTypeId);

                // Load rooms only if a type is selected
                if (selectedTypeId > 0) {
                    lk.icbt.oceanview.reservation.dao.RoomDAO roomDAO =
                            new lk.icbt.oceanview.reservation.dao.RoomDAO();

                    req.setAttribute("availableRooms",
                            roomDAO.findAvailableRooms(selectedTypeId, checkIn, checkOut));
                }

            } catch (Exception e) {
                req.setAttribute("pageError", "Unable to load room data.");
            }
        }

        /*
        When user opens "View Reservations",
        load reservation list with joined data
        */
        if ("reservationList".equals(page)) {
            try {
                String searchIdStr = req.getParameter("searchReservationId");
                Integer searchId = (searchIdStr == null || searchIdStr.isBlank())
                        ? null
                        : Integer.parseInt(searchIdStr);

                req.setAttribute("searchReservationId", searchIdStr);
                req.setAttribute("reservations",
                        reservationDAO.findLatestWithDetails(30, searchId));

            } catch (Exception e) {
                req.setAttribute("pageError", "Unable to load reservations.");
            }
        }

        if ("reservationEdit".equals(page)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));

                var reservationDAO = new lk.icbt.oceanview.reservation.dao.ReservationDAO();
                var roomTypeDAO = new lk.icbt.oceanview.reservation.dao.RoomTypeDAO();
                var roomDAO = new lk.icbt.oceanview.reservation.dao.RoomDAO();

                var res = reservationDAO.findByIdWithDetails(id);

                if (res == null) {
                    req.setAttribute("pageError", "Reservation not found.");
                } else {
                    // Use NEW values (if user is reloading) OR fallback to DB values
                    String typeIdStr = req.getParameter("typeId");
                    String checkInStr = req.getParameter("checkIn");
                    String checkOutStr = req.getParameter("checkOut");

                    int selectedTypeId = (typeIdStr == null || typeIdStr.isBlank())
                            ? res.getRoomTypeId()
                            : Integer.parseInt(typeIdStr);

                    java.time.LocalDate selectedCheckIn = (checkInStr == null || checkInStr.isBlank())
                            ? res.getCheckIn()
                            : java.time.LocalDate.parse(checkInStr);

                    java.time.LocalDate selectedCheckOut = (checkOutStr == null || checkOutStr.isBlank())
                            ? res.getCheckOut()
                            : java.time.LocalDate.parse(checkOutStr);

                    // push selected values back to JSP so it doesn't reset
                    req.setAttribute("reservation", res);
                    req.setAttribute("roomTypes", roomTypeDAO.findAll());
                    req.setAttribute("selectedTypeId", selectedTypeId);
                    req.setAttribute("checkIn", selectedCheckIn.toString());
                    req.setAttribute("checkOut", selectedCheckOut.toString());

                    // reload rooms based on selected type/dates
                    req.setAttribute("availableRooms",
                            roomDAO.findAvailableRoomsForEdit(
                                    selectedTypeId,
                                    selectedCheckIn,
                                    selectedCheckOut,
                                    res.getId(),
                                    res.getRoomId()
                            ));
                }

            } catch (Exception e) {
                req.setAttribute("pageError", "Unable to load reservation edit details.");
            }
        }

        if ("billing".equals(page)) {
            try {
                String reservationIdStr = req.getParameter("reservationId");

                if (reservationIdStr != null && !reservationIdStr.isBlank()) {
                    int reservationId = Integer.parseInt(reservationIdStr);

                    var billingService = new lk.icbt.oceanview.billing.service.BillingService();
                    var bill = billingService.generatePreview(reservationId);

                    req.setAttribute("bill", bill);
                }

            } catch (IllegalArgumentException e) {
                req.setAttribute("pageError", "Unable to generate bill. No reservation found.");
            } catch (Exception e) {
                req.setAttribute("pageError", "Unable to generate bill.");
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