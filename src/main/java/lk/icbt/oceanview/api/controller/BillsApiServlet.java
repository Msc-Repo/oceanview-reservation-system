package lk.icbt.oceanview.api.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.icbt.oceanview.api.util.JsonUtil;
import lk.icbt.oceanview.billing.dao.BillingDAO;
import lk.icbt.oceanview.billing.model.Billing;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/bills")
public class BillsApiServlet extends HttpServlet {

    private final BillingDAO billingDAO = new BillingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json;charset=UTF-8");

        try {
            List<Billing> bills = billingDAO.findLatestPaidBills(30);

            StringBuilder json = new StringBuilder();
            json.append("[");

            for (int i = 0; i < bills.size(); i++) {
                Billing b = bills.get(i);

                json.append("{")
                        .append("\"billId\":").append(b.getBillId()).append(",")
                        .append("\"reservationId\":").append(b.getReservationId()).append(",")
                        .append("\"nights\":").append(b.getNights()).append(",")
                        .append("\"ratePerNight\":").append(b.getRatePerNight()).append(",")
                        .append("\"serviceCharge\":").append(b.getServiceCharge()).append(",")
                        .append("\"taxAmount\":").append(b.getTaxAmount()).append(",")
                        .append("\"totalAmount\":").append(b.getTotalAmount()).append(",")
                        .append("\"paymentMethod\":\"").append(JsonUtil.escape(b.getPaymentMethod())).append("\",")
                        .append("\"paymentStatus\":\"").append(JsonUtil.escape(b.getPaymentStatus())).append("\"")
                        .append("}");

                if (i < bills.size() - 1) {
                    json.append(",");
                }
            }

            json.append("]");
            resp.getWriter().write(json.toString());

        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"Unable to load bills\"}");
        }
    }
}