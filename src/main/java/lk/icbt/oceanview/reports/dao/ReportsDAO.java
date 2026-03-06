package lk.icbt.oceanview.reports.dao;

import lk.icbt.oceanview.common.db.DBConnection;
import lk.icbt.oceanview.reports.model.RevenueReport;
import lk.icbt.oceanview.reports.model.RoomTypeRevenue;
import lk.icbt.oceanview.reports.model.StatusSummary;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReportsDAO {

    public RevenueReport getRevenueReport() throws Exception {
        String sql = """
                SELECT COALESCE(SUM(total_amount), 0) AS total_revenue,
                       COUNT(*) AS total_paid_bills
                FROM bills
                WHERE payment_status = 'PAID'
                """;

        Connection conn = DBConnection.getInstance().getConnection();

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return new RevenueReport(
                        rs.getBigDecimal("total_revenue"),
                        rs.getInt("total_paid_bills")
                );
            }
        }

        return new RevenueReport(BigDecimal.ZERO, 0);
    }

    public List<StatusSummary> getReservationStatusSummary() throws Exception {
        String sql = """
                SELECT status, COUNT(*) AS total_count
                FROM reservations
                GROUP BY status
                ORDER BY status
                """;

        List<StatusSummary> list = new ArrayList<>();
        Connection conn = DBConnection.getInstance().getConnection();

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new StatusSummary(
                        rs.getString("status"),
                        rs.getInt("total_count")
                ));
            }
        }

        return list;
    }

    public List<RoomTypeRevenue> getRoomTypeRevenueSummary() throws Exception {
        String sql = """
                SELECT rt.type_name AS room_type,
                       COALESCE(SUM(b.total_amount), 0) AS total_revenue
                FROM bills b
                JOIN reservations r ON b.reservation_id = r.id
                JOIN rooms rm ON r.room_id = rm.id
                JOIN room_types rt ON rm.type_id = rt.id
                WHERE b.payment_status = 'PAID'
                GROUP BY rt.type_name
                ORDER BY total_revenue DESC
                """;

        List<RoomTypeRevenue> list = new ArrayList<>();
        Connection conn = DBConnection.getInstance().getConnection();

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new RoomTypeRevenue(
                        rs.getString("room_type"),
                        rs.getBigDecimal("total_revenue")
                ));
            }
        }

        return list;
    }
}