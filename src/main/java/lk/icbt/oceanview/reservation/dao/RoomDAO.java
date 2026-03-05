package lk.icbt.oceanview.reservation.dao;

import lk.icbt.oceanview.common.db.DBConnection;
import lk.icbt.oceanview.reservation.model.Room;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    public List<Room> findAvailableRooms(int typeId, LocalDate checkIn, LocalDate checkOut) throws SQLException {
        String sql = """
            SELECT r.id, r.room_number, r.type_id, r.floor, r.is_active
            FROM rooms r
            WHERE r.type_id = ?
              AND r.is_active = 1
              AND r.id NOT IN (
                SELECT res.room_id
                FROM reservations res
                WHERE res.status <> 'CANCELLED'
                  AND NOT (? <= res.check_in OR ? >= res.check_out)
              )
            ORDER BY r.room_number
        """;

        List<Room> list = new ArrayList<>();
        Connection conn = DBConnection.getInstance().getConnection();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, typeId);
            ps.setDate(2, Date.valueOf(checkOut)); // NEW.check_out <= existing.check_in
            ps.setDate(3, Date.valueOf(checkIn));  // NEW.check_in >= existing.check_out

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Room(
                            rs.getInt("id"),
                            rs.getString("room_number"),
                            rs.getInt("type_id"),
                            (Integer) rs.getObject("floor"),
                            rs.getInt("is_active") == 1
                    ));
                }
            }
        }
        return list;
    }
}