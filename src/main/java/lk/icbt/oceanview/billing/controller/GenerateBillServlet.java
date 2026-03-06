package lk.icbt.oceanview.billing.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.icbt.oceanview.billing.service.BillingService;

import java.io.IOException;

@WebServlet("/billing/generate")
public class GenerateBillServlet extends HttpServlet {

    private final BillingService billingService =
            new BillingService();

    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            int reservationId =
                    Integer.parseInt(req.getParameter("reservationId"));

            var bill =
                    billingService.generateBill(reservationId);

            req.setAttribute("bill", bill);

            req.getRequestDispatcher(
                            "/WEB-INF/views/billing/bill-view.jsp")
                    .forward(req, resp);

        } catch (Exception e) {

            req.setAttribute("pageError",
                    "Unable to generate bill");

            req.getRequestDispatcher(
                            "/WEB-INF/views/billing/bill-view.jsp")
                    .forward(req, resp);
        }
    }
}
