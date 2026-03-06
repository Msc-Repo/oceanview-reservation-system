package lk.icbt.oceanview.auth.dao;

import lk.icbt.oceanview.auth.model.User;
import lk.icbt.oceanview.common.db.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User findByUsernameAndPasswordHash(String username, String passwordHash) throws SQLException {
        String sql = "SELECT id, username, role FROM users WHERE username = ? AND password_hash = ?";

        Connection conn = DBConnection.getInstance().getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, passwordHash);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("role")
                    );
                }
                return null;
            }
        }
    }
}