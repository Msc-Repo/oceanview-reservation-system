package lk.icbt.oceanview.reports.model;

import java.math.BigDecimal;

public class RevenueReport {

    private BigDecimal totalRevenue;
    private int totalPaidBills;

    public RevenueReport() {}

    public RevenueReport(BigDecimal totalRevenue, int totalPaidBills) {
        this.totalRevenue = totalRevenue;
        this.totalPaidBills = totalPaidBills;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public int getTotalPaidBills() {
        return totalPaidBills;
    }

    public void setTotalPaidBills(int totalPaidBills) {
        this.totalPaidBills = totalPaidBills;
    }
}