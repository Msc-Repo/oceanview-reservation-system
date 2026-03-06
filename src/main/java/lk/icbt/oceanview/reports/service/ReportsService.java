package lk.icbt.oceanview.reports.service;

import lk.icbt.oceanview.reports.dao.ReportsDAO;
import lk.icbt.oceanview.reports.model.RevenueReport;
import lk.icbt.oceanview.reports.model.RoomTypeRevenue;
import lk.icbt.oceanview.reports.model.StatusSummary;

import java.util.List;

public class ReportsService {

    private final ReportsDAO reportsDAO = new ReportsDAO();

    public RevenueReport getRevenueReport() throws Exception {
        return reportsDAO.getRevenueReport();
    }

    public List<StatusSummary> getReservationStatusSummary() throws Exception {
        return reportsDAO.getReservationStatusSummary();
    }

    public List<RoomTypeRevenue> getRoomTypeRevenueSummary() throws Exception {
        return reportsDAO.getRoomTypeRevenueSummary();
    }
}