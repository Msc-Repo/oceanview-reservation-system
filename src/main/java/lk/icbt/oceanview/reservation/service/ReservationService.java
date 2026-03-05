package lk.icbt.oceanview.reservation.service;

import lk.icbt.oceanview.reservation.dao.*;
import lk.icbt.oceanview.reservation.model.Guest;

import java.sql.SQLException;
import java.time.LocalDate;

public class ReservationService {

    private final GuestDAO guestDAO = new GuestDAO();
    private final RoomDAO roomDAO = new RoomDAO();
    private final ReservationDAO reservationDAO = new ReservationDAO();

    public int createReservation(String fullName, String nic, String phone, String email,
                                 int typeId, int roomId, LocalDate checkIn, LocalDate checkOut, int guestsCount)
            throws SQLException {

        // Service-layer validation (and DB trigger also protects)
        if (fullName == null || fullName.trim().isEmpty()) throw new IllegalArgumentException("Guest name is required.");
        if (nic == null || nic.trim().isEmpty()) throw new IllegalArgumentException("NIC/Passport is required.");
        if (phone == null || phone.trim().isEmpty()) throw new IllegalArgumentException("Phone is required.");
        if (checkIn == null || checkOut == null) throw new IllegalArgumentException("Check-in/out dates are required.");
        if (!checkOut.isAfter(checkIn)) throw new IllegalArgumentException("Check-out must be after check-in.");
        if (guestsCount <= 0) throw new IllegalArgumentException("Guests count must be greater than 0.");

        // Ensure selected room is still available (double safety)
        if (roomDAO.findAvailableRooms(typeId, checkIn, checkOut).stream().noneMatch(r -> r.getId() == roomId)) {
            throw new IllegalArgumentException("Selected room is not available for the chosen dates.");
        }

        // Find or create guest
        Guest existing = guestDAO.findByNic(nic);
        int guestId;
        if (existing != null) {
            guestId = existing.getId();
        } else {
            Guest g = new Guest();
            g.setFullName(fullName);
            g.setNicPassport(nic);
            g.setPhone(phone);
            g.setEmail(email);
            guestId = guestDAO.insert(g);
        }

        // Create reservation
        return reservationDAO.insert(guestId, roomId, checkIn, checkOut, guestsCount);
    }
}