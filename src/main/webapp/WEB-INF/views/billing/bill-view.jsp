<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="lk.icbt.oceanview.billing.model.Billing" %>

<%
    Billing bill = (Billing) request.getAttribute("bill");
    String pageError = (String) request.getAttribute("pageError");
    String reservationId = request.getParameter("reservationId");
%>

<div style="max-width: 900px; margin: 0 auto;">

    <h3 style="margin-bottom: 16px;">Billing & Invoice</h3>

    <% if (pageError != null) { %>
    <div style="margin:10px 0; padding:12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background:rgba(220,38,38,0.08); color:#991b1b;">
        <%= pageError %>
    </div>
    <% } %>

    <div style="background:white; border:1px solid rgba(2,6,23,0.10); border-radius:16px; padding:18px; margin-bottom:18px;">
        <form method="get" action="<%= request.getContextPath() %>/dashboard" style="display:flex; gap:12px; align-items:end; flex-wrap:wrap;">
            <input type="hidden" name="page" value="billing"/>

            <div style="display:flex; flex-direction:column; gap:6px;">
                <label for="reservationId" style="font-size:13px; color:#334155;">Reservation ID</label>
                <input id="reservationId" name="reservationId" type="number" min="1"
                       value="<%= reservationId != null ? reservationId : "" %>"
                       placeholder="Enter reservation ID"
                       style="width:220px; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" required />
            </div>

            <button type="submit"
                    style="height:44px; border-radius:12px; border:0; cursor:pointer; font-weight:700; color:white; padding:0 18px; background:linear-gradient(135deg,#2563eb,#06b6d4);">
                Generate Bill
            </button>

            <button type="button"
                    onclick="window.location.href='<%= request.getContextPath() %>/dashboard?page=billing';"
                    style="height:44px; border-radius:12px; border:1px solid rgba(2,6,23,0.12); cursor:pointer; font-weight:700; padding:0 18px; background:white;">
                Clear
            </button>
        </form>
    </div>

    <% if (bill != null) { %>
    <div id="printArea" style="background:white; border:1px solid rgba(2,6,23,0.10); border-radius:18px; padding:28px; box-shadow:0 10px 24px rgba(2,6,23,0.06);">
        <div style="display:flex; justify-content:space-between; align-items:flex-start; gap:20px; border-bottom:1px solid rgba(2,6,23,0.08); padding-bottom:16px; margin-bottom:18px;">
            <div>
                <h2 style="margin:0; font-size:24px; color:#0f172a;">Ocean View Resort</h2>
                <p style="margin:6px 0 0; color:#475569; font-size:14px;">
                    Hotel Invoice / Billing Summary
                </p>
            </div>
            <div style="text-align:right;">
                <div style="font-size:13px; color:#475569;">Reservation ID</div>
                <div style="font-size:20px; font-weight:800; color:#0f172a;"><%= bill.getReservationId() %></div>
            </div>
        </div>

        <table style="width:100%; border-collapse:collapse; margin-bottom:20px;">
            <thead>
            <tr style="text-align:left; background:#f8fafc;">
                <th style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.08);">Description</th>
                <th style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.08);">Value</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.06);">Room Charge</td>
                <td style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.06);">
                    LKR <%= bill.getRatePerNight().multiply(new java.math.BigDecimal(bill.getNights())) %>
                </td>
            </tr>
            <tr>
                <td style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.06);">Service Charge (10%)</td>
                <td style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.06);">LKR <%= bill.getServiceCharge() %></td>
            </tr>
            <tr>
                <td style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.06);">Tax (15%)</td>
                <td style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.06);">LKR <%= bill.getTaxAmount() %></td>
            </tr>
            <tr>
                <td style="padding:14px; font-size:16px; font-weight:800;">TOTAL</td>
                <td style="padding:14px; font-size:18px; font-weight:800; color:#2563eb;">LKR <%= bill.getTotalAmount() %></td>
            </tr>
            </tbody>
        </table>

        <form method="post" action="<%= request.getContextPath() %>/billing/pay" style="display:flex; gap:12px; align-items:end; flex-wrap:wrap;">
            <input type="hidden" name="reservationId" value="<%= bill.getReservationId() %>"/>

            <div style="display:flex; flex-direction:column; gap:6px;">
                <label style="font-size:13px; color:#334155;">Payment Method</label>
                <select name="paymentMethod" required
                        style="width:220px; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);">
                    <option value="">-- Select Payment Method --</option>
                    <option value="CASH">Cash</option>
                    <option value="CARD">Card</option>
                </select>
            </div>

            <button type="submit"
                    style="height:44px; border-radius:12px; border:0; cursor:pointer; font-weight:700; color:white; padding:0 18px; background:linear-gradient(135deg,#16a34a,#22c55e);">
                Pay Bill
            </button>

            <button type="button"
                    onclick="printBill()"
                    style="height:44px; border-radius:12px; border:1px solid rgba(2,6,23,0.12); cursor:pointer; font-weight:700; padding:0 18px; background:white;">
                Print Bill
            </button>

            <button type="button"
                    onclick="window.location.href='<%= request.getContextPath() %>/dashboard?page=billing';"
                    style="height:44px; border-radius:12px; border:1px solid rgba(2,6,23,0.12); cursor:pointer; font-weight:700; padding:0 18px; background:white;">
                Clear
            </button>
        </form>
    </div>
    <% } %>
</div>

<script>
    function printBill() {
        const printContents = document.getElementById("printArea").innerHTML;
        const originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
        window.location.reload();
    }
</script>