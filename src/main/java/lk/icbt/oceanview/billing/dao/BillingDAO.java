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

    public java.util.List<lk.icbt.oceanview.billing.model.Billing> findLatestPaidBills(int limit) throws Exception {

        String sql = """
            SELECT bill_id, reservation_id, nights, rate_per_night,
                   service_charge, tax_amount, total_amount,
                   payment_method, payment_status
            FROM bills
            ORDER BY bill_id DESC
            LIMIT ?
            """;

        java.util.List<lk.icbt.oceanview.billing.model.Billing> list = new java.util.ArrayList<>();

        java.sql.Connection conn = lk.icbt.oceanview.common.db.DBConnection.getInstance().getConnection();

        try (java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);

            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lk.icbt.oceanview.billing.model.Billing b = new lk.icbt.oceanview.billing.model.Billing();
                    b.setBillId(rs.getInt("bill_id"));
                    b.setReservationId(rs.getInt("reservation_id"));
                    b.setNights(rs.getInt("nights"));
                    b.setRatePerNight(rs.getBigDecimal("rate_per_night"));
                    b.setServiceCharge(rs.getBigDecimal("service_charge"));
                    b.setTaxAmount(rs.getBigDecimal("tax_amount"));
                    b.setTotalAmount(rs.getBigDecimal("total_amount"));
                    b.setPaymentMethod(rs.getString("payment_method"));
                    b.setPaymentStatus(rs.getString("payment_status"));
                    list.add(b);
                }
            }
        }

        return list;
    }
}