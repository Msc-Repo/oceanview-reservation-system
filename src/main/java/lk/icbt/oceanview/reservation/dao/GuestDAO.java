package lk.icbt.oceanview.reservation.dao;

import lk.icbt.oceanview.common.db.DBConnection;
import lk.icbt.oceanview.reservation.model.Guest;

import java.sql.*;

public class GuestDAO {

    public Guest findByNic(String nic) throws SQLException {
        String sql = "SELECT id, full_name, nic_passport, phone, email FROM guests WHERE nic_passport = ?";
        Connection conn = DBConnection.getInstance().getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nic);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Guest(
                            rs.getInt("id"),
                            rs.getString("full_name"),
                            rs.getString("nic_passport"),
                            rs.getString("phone"),
                            rs.getString("email")
                    );
                }
            }
        }
        return null;
    }

    public int insert(Guest g) throws SQLException {
        String sql = "INSERT INTO guests(full_name, nic_passport, phone, email) VALUES (?, ?, ?, ?)";
        Connection conn = DBConnection.getInstance().getConnection();

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, g.getFullName());
            ps.setString(2, g.getNicPassport());
            ps.setString(3, g.getPhone());
            ps.setString(4, g.getEmail());
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return 0;
    }

    public void update(Guest g) throws SQLException {
        String sql = "UPDATE guests SET full_name = ?, phone = ?, email = ? WHERE id = ?";
        Connection conn = DBConnection.getInstance().getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, g.getFullName());
            ps.setString(2, g.getPhone());
            ps.setString(3, g.getEmail());
            ps.setInt(4, g.getId());
            ps.executeUpdate();
        }
    }
}