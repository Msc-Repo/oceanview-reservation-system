<%@ page contentType="text/html;charset=UTF-8" %>

<%
  Object totalReservations = request.getAttribute("totalReservations");
  Object paidReservations = request.getAttribute("paidReservations");
  Object availableRooms = request.getAttribute("availableRooms");
  Object totalRevenue = request.getAttribute("totalRevenue");
  String pageError = (String) request.getAttribute("pageError");
%>

<h3>System Overview</h3>

<% if (pageError != null) { %>
<div style="margin:10px 0; padding:12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background:rgba(220,38,38,0.08); color:#991b1b;">
  <%= pageError %>
</div>
<% } %>

<div style="display:grid; grid-template-columns: repeat(4,1fr); gap:16px; margin-top:16px;">

  <div style="background:white;border:1px solid rgba(2,6,23,0.10);border-radius:16px;padding:18px;">
    <div style="font-size:13px;color:#64748b;">Total Reservations</div>
    <div style="font-size:28px;font-weight:800;color:#2563eb;margin-top:8px;">
      <%= totalReservations != null ? totalReservations : 0 %>
    </div>
  </div>

  <div style="background:white;border:1px solid rgba(2,6,23,0.10);border-radius:16px;padding:18px;">
    <div style="font-size:13px;color:#64748b;">Paid Reservations</div>
    <div style="font-size:28px;font-weight:800;color:#16a34a;margin-top:8px;">
      <%= paidReservations != null ? paidReservations : 0 %>
    </div>
  </div>

  <div style="background:white;border:1px solid rgba(2,6,23,0.10);border-radius:16px;padding:18px;">
    <div style="font-size:13px;color:#64748b;">Total Revenue</div>
    <div style="font-size:28px;font-weight:800;color:#0f172a;margin-top:8px;">
      LKR <%= totalRevenue != null ? totalRevenue : 0 %>
    </div>
  </div>

  <div style="background:white;border:1px solid rgba(2,6,23,0.10);border-radius:16px;padding:18px;">
    <div style="font-size:13px;color:#64748b;">Available Rooms</div>
    <div style="font-size:28px;font-weight:800;color:#9333ea;margin-top:8px;">
      <%= availableRooms != null ? availableRooms : 0 %>
    </div>
  </div>

</div>

<h4 style="margin-top:32px;">Quick Actions</h4>

<div style="display:flex; gap:12px; margin-top:12px; flex-wrap:wrap;">

  <a href="<%= request.getContextPath() %>/dashboard?page=reservationForm"
     style="text-decoration:none;padding:10px 14px;border-radius:12px;background:#2563eb;color:white;">
    Create Reservation
  </a>

  <a href="<%= request.getContextPath() %>/dashboard?page=reservationList"
     style="text-decoration:none;padding:10px 14px;border-radius:12px;background:#16a34a;color:white;">
    View Reservations
  </a>

  <a href="<%= request.getContextPath() %>/dashboard?page=billing"
     style="text-decoration:none;padding:10px 14px;border-radius:12px;background:#f59e0b;color:white;">
    Billing
  </a>

  <a href="<%= request.getContextPath() %>/dashboard?page=reports"
     style="text-decoration:none;padding:10px 14px;border-radius:12px;background:#9333ea;color:white;">
    View Reports
  </a>

</div>

<div style="margin-top:28px; background:white; border:1px solid rgba(2,6,23,0.10); border-radius:16px; padding:18px;">
  <h4 style="margin-top:0;">Dashboard Summary</h4>
  <p style="margin:8px 0 0; color:#475569; line-height:1.6;">
    This dashboard provides a quick overview of current hotel operations. Staff can monitor reservations,
    room availability, revenue, and access operational modules using the quick action buttons above.
  </p>
</div>