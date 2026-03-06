<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="lk.icbt.oceanview.billing.model.Billing" %>

<%
    Billing bill = (Billing) request.getAttribute("bill");
    String pageError = (String) request.getAttribute("pageError");
    String reservationId = request.getParameter("reservationId");
    String flashError = (String) request.getAttribute("flashError");

    boolean isPaid = bill != null && "PAID".equalsIgnoreCase(bill.getPaymentStatus());
%>

<style>
    .bill-page-wrap {
        max-width: 980px;
        margin: 0 auto;
    }

    .bill-search-box, .bill-card {
        background: white;
        border: 1px solid rgba(2,6,23,0.10);
        border-radius: 18px;
        padding: 22px;
        box-shadow: 0 10px 24px rgba(2,6,23,0.06);
    }

    .bill-search-box { margin-bottom: 18px; }

    .invoice-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 20px;
        border-bottom: 1px solid rgba(2,6,23,0.08);
        padding-bottom: 16px;
        margin-bottom: 18px;
    }

    .invoice-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 18px;
        margin-bottom: 20px;
    }

    .info-box {
        background: #f8fafc;
        border: 1px solid rgba(2,6,23,0.06);
        border-radius: 14px;
        padding: 14px;
    }

    .bill-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    .bill-table th, .bill-table td {
        padding: 12px;
        border-bottom: 1px solid rgba(2,6,23,0.06);
        text-align: left;
    }

    .bill-table thead tr {
        background: #f8fafc;
    }

    .bill-actions {
        display: flex;
        gap: 12px;
        align-items: end;
        flex-wrap: wrap;
    }

    .btn-main, .btn-light, .btn-pay {
        height: 44px;
        border-radius: 12px;
        cursor: pointer;
        font-weight: 700;
        padding: 0 18px;
    }

    .btn-main {
        border: 0;
        color: white;
        background: linear-gradient(135deg,#2563eb,#06b6d4);
    }

    .btn-pay {
        border: 0;
        color: white;
        background: linear-gradient(135deg,#16a34a,#22c55e);
    }

    .btn-light {
        border: 1px solid rgba(2,6,23,0.12);
        background: white;
    }

</style>

<div class="bill-page-wrap">

    <h3 style="margin-bottom:16px;">Billing & Invoice</h3>

    <% if (pageError != null) { %>
    <div style="margin:10px 0; padding:12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background:rgba(220,38,38,0.08); color:#991b1b;">
        <%= pageError %>
    </div>
    <% } %>

    <% if (flashError != null) { %>
    <div style="margin:10px 0; padding:12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background:rgba(220,38,38,0.08); color:#991b1b;">
        <%= flashError %>
    </div>
    <% } %>

    <div class="bill-search-box no-print">
        <form method="get" action="<%= request.getContextPath() %>/dashboard" style="display:flex; gap:12px; align-items:end; flex-wrap:wrap;">
            <input type="hidden" name="page" value="billing"/>

            <div style="display:flex; flex-direction:column; gap:6px;">
                <label for="reservationId" style="font-size:13px; color:#334155;">Reservation ID</label>
                <input id="reservationId" name="reservationId" type="number" min="1"
                       value="<%= reservationId != null ? reservationId : "" %>"
                       placeholder="Enter reservation ID"
                       style="width:220px; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" required />
            </div>

            <button type="submit" class="btn-main">Generate Bill</button>

            <button type="button"
                    class="btn-light"
                    onclick="window.location.href='<%= request.getContextPath() %>/dashboard?page=billing';">
                Clear
            </button>
        </form>
    </div>

    <% if (bill != null) { %>
    <div id="printArea" class="bill-card">
        <div class="invoice-header">
            <div>
                <h2 style="margin:0; font-size:24px; color:#0f172a;">Ocean View Resort</h2>
                <p style="margin:6px 0 0; color:#475569; font-size:14px;">
                    Guest Billing Invoice
                </p>
            </div>
            <div style="text-align:right;">
                <div style="font-size:13px; color:#475569;">Reservation ID</div>
                <div style="font-size:20px; font-weight:800; color:#0f172a;"><%= bill.getReservationId() %></div>
            </div>
        </div>

        <div class="invoice-grid">
            <div class="info-box">
                <div style="font-size:13px; color:#64748b; margin-bottom:8px;">Guest & Stay Information</div>
                <div style="display:grid; gap:8px; font-size:14px;">
                    <div><strong>Guest Name:</strong> <%= bill.getGuestName() %></div>
                    <div><strong>Room Number:</strong> <%= bill.getRoomNumber() %></div>
                    <div><strong>Room Type:</strong> <%= bill.getRoomTypeName() %></div>
                    <div><strong>Room Rate / Night:</strong> LKR <%= bill.getRatePerNight() %></div>
                    <div><strong>Check-in:</strong> <%= bill.getCheckIn() %></div>
                    <div><strong>Check-out:</strong> <%= bill.getCheckOut() %></div>
                    <div><strong>Nights Stayed:</strong> <%= bill.getNights() %></div>
                </div>
            </div>

            <div class="info-box">
                <div style="font-size:13px; color:#64748b; margin-bottom:8px;">Invoice Summary</div>
                <div style="display:grid; gap:8px; font-size:14px;">
                    <div><strong>Status:</strong> <%= bill.getPaymentStatus() %></div>
                    <div><strong>Payment Method:</strong>
                        <%= (bill.getPaymentMethod() != null && !bill.getPaymentMethod().isBlank()) ? bill.getPaymentMethod() : "Select below" %>
                    </div>
                    <div><strong>Generated On:</strong> <%= java.time.LocalDate.now() %></div>
                </div>
            </div>
        </div>

        <table class="bill-table">
            <thead>
            <tr>
                <th>Description</th>
                <th>Value</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Room Charge</td>
                <td>LKR <%= bill.getSubtotal() %></td>
            </tr>
            <tr>
                <td>Service Charge (10%)</td>
                <td>LKR <%= bill.getServiceCharge() %></td>
            </tr>
            <tr>
                <td>Tax (15%)</td>
                <td>LKR <%= bill.getTaxAmount() %></td>
            </tr>
            <tr>
                <td style="font-size:16px; font-weight:800;">TOTAL</td>
                <td style="font-size:18px; font-weight:800; color:#2563eb;">LKR <%= bill.getTotalAmount() %></td>
            </tr>
            </tbody>
        </table>

        <div class="bill-actions no-print">
            <% if (!isPaid) { %>
            <form method="post" action="<%= request.getContextPath() %>/billing/pay" style="display:flex; gap:12px; align-items:end; flex-wrap:wrap;">
                <input type="hidden" name="reservationId" value="<%= bill.getReservationId() %>"/>

                <div style="display:flex; flex-direction:column; gap:6px;">
                    <label style="font-size:13px; color:#334155;">Payment Method</label>
                    <label>
                        <select name="paymentMethod" required
                                style="width:220px; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);">
                            <option value="">-- Select Payment Method --</option>
                            <option value="CASH">Cash</option>
                            <option value="CARD">Card</option>
                        </select>
                    </label>
                </div>

                <button type="submit" class="btn-pay">Pay Bill</button>
            </form>
            <% } %>

            <button type="button" class="btn-light" onclick="printBillOnly();">Print Bill</button>

            <button type="button"
                    class="btn-light"
                    onclick="window.location.href='<%= request.getContextPath() %>/dashboard?page=billing';">
                Clear
            </button>
        </div>
    </div>
    <% } %>
</div>

<script>
    function printBillOnly() {
        const printContents = document.getElementById("printArea");

        if (!printContents) {
            alert("Nothing to print.");
            return;
        }

        const printWindow = window.open("", "_blank", "width=900,height=700");

        let html = "";
        html += "<html lang=";">";
        html += "<head>";
        html += "<title>Ocean View Resort - Bill</title>";
        html += "<style>";
        html += "body{font-family:Arial,sans-serif;margin:0;padding:24px;color:#0f172a;background:#ffffff;}";
        html += ".bill-card{width:100%;max-width:900px;margin:0 auto;border:1px solid #dbe2ea;border-radius:14px;padding:24px;box-sizing:border-box;}";
        html += ".invoice-header{display:flex;justify-content:space-between;align-items:flex-start;gap:20px;border-bottom:1px solid #e5e7eb;padding-bottom:16px;margin-bottom:18px;}";
        html += ".invoice-grid{display:grid;grid-template-columns:1fr 1fr;gap:18px;margin-bottom:20px;}";
        html += ".info-box{background:#f8fafc;border:1px solid #e5e7eb;border-radius:12px;padding:14px;}";
        html += ".bill-table{width:100%;border-collapse:collapse;margin-bottom:20px;}";
        html += ".bill-table th,.bill-table td{padding:12px;border-bottom:1px solid #e5e7eb;text-align:left;}";
        html += ".bill-table thead tr{background:#f8fafc;}";
        html += ".no-print{display:none !important;}";
        html += "@media print{";
        html += "html,body{margin:0;padding:0;background:white;}";
        html += ".bill-card{border:none;box-shadow:none;margin:0;padding:0;max-width:100%;}";
        html += "@page{size:A4;margin:12mm;}";
        html += "}";
        html += "</style>";
        html += "</head>";
        html += "<body>";
        html += printContents.outerHTML;
        html += "</body>";
        html += "</html>";

        printWindow.document.open();
        printWindow.document.write(html);
        printWindow.document.close();

        printWindow.focus();

        setTimeout(function () {
            printWindow.print();
            printWindow.close();
        }, 500);
    }
</script>