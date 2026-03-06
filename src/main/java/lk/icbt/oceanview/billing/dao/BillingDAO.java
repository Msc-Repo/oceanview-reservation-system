package lk.icbt.oceanview.billing.dao;

import lk.icbt.oceanview.billing.model.Billing;
import lk.icbt.oceanview.common.db.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BillingDAO {

    public void insert(Billing bill) throws Exception {

        String sql = """
            INSERT INTO bills
            (reservation_id,nights,rate_per_night,
             service_charge,tax_amount,total_amount,
             payment_method,payment_status)
            VALUES (?,?,?,?,?,?,?,?)
            """;

        Connection conn = DBConnection.getInstance().getConnection();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bill.getReservationId());
            ps.setInt(2, bill.getNights());
            ps.setBigDecimal(3, bill.getRatePerNight());
            ps.setBigDecimal(4, bill.getServiceCharge());
            ps.setBigDecimal(5, bill.getTaxAmount());
            ps.setBigDecimal(6, bill.getTotalAmount());
            ps.setString(7, bill.getPaymentMethod());
            ps.setString(8, bill.getPaymentStatus());

            ps.executeUpdate();
        }
    }

    public Billing findByReservationId(int reservationId) throws Exception {

        String sql = """
            SELECT bill_id, reservation_id, nights, rate_per_night,
                   service_charge, tax_amount, total_amount,
                   payment_method, payment_status, created_at
            FROM bills
            WHERE reservation_id = ?
            ORDER BY bill_id DESC
            LIMIT 1
            """;

        Connection conn = DBConnection.getInstance().getConnection();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reservationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Billing bill = new Billing();
                    bill.setBillId(rs.getInt("bill_id"));
                    bill.setReservationId(rs.getInt("reservation_id"));
                    bill.setNights(rs.getInt("nights"));
                    bill.setRatePerNight(rs.getBigDecimal("rate_per_night"));
                    bill.setServiceCharge(rs.getBigDecimal("service_charge"));
                    bill.setTaxAmount(rs.getBigDecimal("tax_amount"));
                    bill.setTotalAmount(rs.getBigDecimal("total_amount"));
                    bill.setPaymentMethod(rs.getString("payment_method"));
                    bill.setPaymentStatus(rs.getString("payment_status"));
                    return bill;
                }
            }
        }

        return null;
    }
}