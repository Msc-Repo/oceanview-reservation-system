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
}