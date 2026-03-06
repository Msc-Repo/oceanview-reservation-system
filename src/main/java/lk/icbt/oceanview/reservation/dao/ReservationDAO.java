package lk.icbt.oceanview.reservation.dao;

import lk.icbt.oceanview.common.db.DBConnection;
import lk.icbt.oceanview.reservation.model.Reservation;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    public int insert(int guestId, int roomId, LocalDate checkIn, LocalDate checkOut, int guestsCount) throws SQLException {
        String sql = """
            INSERT INTO reservations(guest_id, room_id, check_in, check_out, guests_count, status)
            VALUES(?, ?, ?, ?, ?, 'CONFIRMED')
        """;
        Connection conn = DBConnection.getInstance().getConnection();

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, guestId);
            ps.setInt(2, roomId);
            ps.setDate(3, Date.valueOf(checkIn));
            ps.setDate(4, Date.valueOf(checkOut));
            ps.setInt(5, guestsCount);
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return 0;
    }

    public List<Reservation> findLatestWithDetails(int limit) throws SQLException {
        String sql = """
            SELECT res.id, res.check_in, res.check_out, res.guests_count, res.status,
                   g.full_name AS guest_name,
                   rm.room_number,
                   rt.type_name AS room_type
            FROM reservations res
            JOIN guests g ON res.guest_id = g.id
            JOIN rooms rm ON res.room_id = rm.id
            JOIN room_types rt ON rm.type_id = rt.id
            ORDER BY res.created_at DESC, res.id DESC
            LIMIT ?
        """;

        List<Reservation> list = new ArrayList<>();
        Connection conn = DBConnection.getInstance().getConnection();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reservation r = new Reservation();
                    r.setId(rs.getInt("id"));
                    r.setCheckIn(rs.getDate("check_in").toLocalDate());
                    r.setCheckOut(rs.getDate("check_out").toLocalDate());
                    r.setGuestsCount(rs.getInt("guests_count"));
                    r.setStatus(rs.getString("status"));

                    r.setGuestName(rs.getString("guest_name"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setRoomTypeName(rs.getString("room_type"));

                    list.add(r);
                }
            }
        }
        return list;
    }

    public void deleteById(int reservationId) throws SQLException {
        String sql = "DELETE FROM reservations WHERE id = ?";
        Connection conn = DBConnection.getInstance().getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reservationId);
            ps.executeUpdate();
        }
    }


    public Reservation findByIdWithDetails(int reservationId) throws SQLException {
        String sql = """
        SELECT res.id, res.guest_id, res.room_id, res.check_in, res.check_out, res.guests_count, res.status,
               g.full_name, g.nic_passport, g.phone, g.email,
               rm.room_number, rt.id AS type_id, rt.type_name, rt.rate_per_night
        FROM reservations res
        JOIN guests g ON res.guest_id = g.id
        JOIN rooms rm ON res.room_id = rm.id
        JOIN room_types rt ON rm.type_id = rt.id
        WHERE res.id = ?
    """;

        Connection conn = DBConnection.getInstance().getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reservationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setGuestId(rs.getInt("guest_id"));
                r.setRoomId(rs.getInt("room_id"));
                r.setCheckIn(rs.getDate("check_in").toLocalDate());
                r.setCheckOut(rs.getDate("check_out").toLocalDate());
                r.setGuestsCount(rs.getInt("guests_count"));
                r.setStatus(rs.getString("status"));

                // joined display fields
                r.setGuestName(rs.getString("full_name"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setRoomTypeName(rs.getString("type_name"));
                r.setRoomTypeId(rs.getInt("type_id"));

                r.setRatePerNight(
                        rs.getBigDecimal("rate_per_night"));

                // extra edit fields via request attributes later:
                // nic/phone/email/typeId etc stored as request attributes in servlet
                return r;
            }
        }
    }

    public void updateReservation(int reservationId, int roomId, LocalDate checkIn, LocalDate checkOut, int guestsCount) throws SQLException {
        String sql = """
        UPDATE reservations
        SET room_id = ?, check_in = ?, check_out = ?, guests_count = ?
        WHERE id = ?
    """;

        Connection conn = DBConnection.getInstance().getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setDate(2, Date.valueOf(checkIn));
            ps.setDate(3, Date.valueOf(checkOut));
            ps.setInt(4, guestsCount);
            ps.setInt(5, reservationId);
            ps.executeUpdate();
        }
    }
}