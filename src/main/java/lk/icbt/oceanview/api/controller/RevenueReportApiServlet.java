package lk.icbt.oceanview.api.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.icbt.oceanview.reports.service.ReportsService;

import java.io.IOException;

@WebServlet("/api/reports/revenue")
public class RevenueReportApiServlet extends HttpServlet {

    private final ReportsService reportsService = new ReportsService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json;charset=UTF-8");

        try {
            var report = reportsService.getRevenueReport();

            String json = "{"
                    + "\"totalRevenue\":" + report.getTotalRevenue() + ","
                    + "\"totalPaidBills\":" + report.getTotalPaidBills()
                    + "}";

            resp.getWriter().write(json);

        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"Unable to load revenue report\"}");
        }
    }
}