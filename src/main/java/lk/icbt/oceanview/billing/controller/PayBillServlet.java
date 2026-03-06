package lk.icbt.oceanview.billing.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.icbt.oceanview.billing.service.BillingService;

import java.io.IOException;

@WebServlet("/billing/pay")
public class PayBillServlet extends HttpServlet {

    private final BillingService billingService = new BillingService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String reservationIdStr = req.getParameter("reservationId");

        try {
            int reservationId = Integer.parseInt(reservationIdStr);
            String paymentMethod = req.getParameter("paymentMethod");

            billingService.payBill(reservationId, paymentMethod);

            req.getSession().setAttribute("flashSuccess",
                    "Bill paid successfully. Receipt sent to client.");

            resp.sendRedirect(req.getContextPath() + "/dashboard?page=reservationList");

        } catch (Exception e) {
            req.getSession().setAttribute("flashError",
                    "Payment failed. Please try again.");

            resp.sendRedirect(req.getContextPath()
                    + "/dashboard?page=billing&reservationId=" + reservationIdStr);
        }
    }
}