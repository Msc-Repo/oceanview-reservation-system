package lk.icbt.oceanview.reservation.dao;

import lk.icbt.oceanview.common.db.DBConnection;
import lk.icbt.oceanview.reservation.model.RoomType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO {

    public List<RoomType> findAll() throws SQLException {
        String sql = "SELECT id, type_name, rate_per_night FROM room_types ORDER BY id";
        List<RoomType> list = new ArrayList<>();

        Connection conn = DBConnection.getInstance().getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new RoomType(
                        rs.getInt("id"),
                        rs.getString("type_name"),
                        rs.getDouble("rate_per_night")
                ));
            }
        }
        return list;
    }
}