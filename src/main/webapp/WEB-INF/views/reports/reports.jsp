<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.icbt.oceanview.reports.model.RevenueReport" %>
<%@ page import="lk.icbt.oceanview.reports.model.StatusSummary" %>
<%@ page import="lk.icbt.oceanview.reports.model.RoomTypeRevenue" %>

<%
    RevenueReport revenueReport = (RevenueReport) request.getAttribute("revenueReport");
    List<StatusSummary> statusSummaryList = (List<StatusSummary>) request.getAttribute("statusSummaryList");
    List<RoomTypeRevenue> roomTypeRevenueList = (List<RoomTypeRevenue>) request.getAttribute("roomTypeRevenueList");
    String pageError = (String) request.getAttribute("pageError");
%>

<h3>Management Reports</h3>

<% if (pageError != null) { %>
<div style="margin:10px 0; padding:12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background:rgba(220,38,38,0.08); color:#991b1b;">
    <%= pageError %>
</div>
<% } %>

<!-- KPI cards -->
<div style="display:grid; grid-template-columns:1fr 1fr; gap:16px; margin:16px 0;">
    <div style="background:white; border:1px solid rgba(2,6,23,0.10); border-radius:16px; padding:18px;">
        <div style="font-size:13px; color:#64748b;">Total Revenue</div>
        <div style="font-size:28px; font-weight:800; color:#2563eb; margin-top:8px;">
            LKR <%= revenueReport != null ? revenueReport.getTotalRevenue() : 0 %>
        </div>
    </div>

    <div style="background:white; border:1px solid rgba(2,6,23,0.10); border-radius:16px; padding:18px;">
        <div style="font-size:13px; color:#64748b;">Total Paid Bills</div>
        <div style="font-size:28px; font-weight:800; color:#16a34a; margin-top:8px;">
            <%= revenueReport != null ? revenueReport.getTotalPaidBills() : 0 %>
        </div>
    </div>
</div>

<!-- Reservation status summary -->
<div style="background:white; border:1px solid rgba(2,6,23,0.10); border-radius:16px; padding:18px; margin-bottom:16px;">
    <h4 style="margin-top:0;">Reservation Status Summary</h4>
    <table style="width:100%; border-collapse:collapse;">
        <thead>
        <tr style="text-align:left; background:#f8fafc;">
            <th style="padding:12px;">Status</th>
            <th style="padding:12px;">Count</th>
        </tr>
        </thead>
        <tbody>
        <% if (statusSummaryList != null && !statusSummaryList.isEmpty()) {
            for (StatusSummary s : statusSummaryList) { %>
        <tr>
            <td style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.06);"><%= s.getStatus() %></td>
            <td style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.06);"><%= s.getCount() %></td>
        </tr>
        <%  } } else { %>
        <tr>
            <td colspan="2" style="padding:12px;">No data available.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- Room type revenue summary -->
<div style="background:white; border:1px solid rgba(2,6,23,0.10); border-radius:16px; padding:18px;">
    <h4 style="margin-top:0;">Revenue by Room Type</h4>
    <table style="width:100%; border-collapse:collapse;">
        <thead>
        <tr style="text-align:left; background:#f8fafc;">
            <th style="padding:12px;">Room Type</th>
            <th style="padding:12px;">Revenue</th>
        </tr>
        </thead>
        <tbody>
        <% if (roomTypeRevenueList != null && !roomTypeRevenueList.isEmpty()) {
            for (RoomTypeRevenue r : roomTypeRevenueList) { %>
        <tr>
            <td style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.06);"><%= r.getRoomType() %></td>
            <td style="padding:12px; border-bottom:1px solid rgba(2,6,23,0.06);">LKR <%= r.getTotalRevenue() %></td>
        </tr>
        <%  } } else { %>
        <tr>
            <td colspan="2" style="padding:12px;">No revenue data available.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>