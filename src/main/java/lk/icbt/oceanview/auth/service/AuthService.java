package lk.icbt.oceanview.auth.service;

import lk.icbt.oceanview.auth.dao.UserDAO;
import lk.icbt.oceanview.auth.model.User;
import lk.icbt.oceanview.common.util.PasswordUtil;

import java.sql.SQLException;

public class AuthService {

    private final UserDAO userDAO = new UserDAO();

    public User authenticate(String username, String plainPassword) throws SQLException {
        String hash = PasswordUtil.sha256(plainPassword);
        return userDAO.findByUsernameAndPasswordHash(username, hash);
    }
}