<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.icbt.oceanview.reservation.model.Reservation" %>

<h3>View Reservations</h3>

<div style="display:flex; gap:10px; margin: 10px 0 16px; flex-wrap: wrap;">
    <a href="<%= request.getContextPath() %>/dashboard?page=reservationForm"
       style="text-decoration:none; padding:10px 12px; border-radius:12px; border:1px solid rgba(2,6,23,0.12); background:white;">
        + Add Reservation
    </a>

    <form method="get" action="<%= request.getContextPath() %>/dashboard" style="display:flex; gap:10px; align-items:center;">
        <input type="hidden" name="page" value="reservationList"/>

        <input type="number" name="searchReservationId"
               value="<%= request.getAttribute("searchReservationId") != null ? request.getAttribute("searchReservationId") : "" %>"
               placeholder="Search by Reservation ID"
               style="height:40px; border-radius:12px; padding:0 12px; border:1px solid rgba(2,6,23,0.14);" />

        <button type="submit"
                style="height:40px; border-radius:12px; border:0; cursor:pointer; font-weight:700; color:white; padding:0 16px; background:linear-gradient(135deg,#2563eb,#06b6d4);">
            Search
        </button>

        <button type="button"
                onclick="window.location.href='<%= request.getContextPath() %>/dashboard?page=reservationList';"
                style="height:40px; border-radius:12px; border:1px solid rgba(2,6,23,0.12); background:white; cursor:pointer; padding:0 16px;">
            Clear
        </button>
    </form>
</div>

<%
    String flashSuccess = (String) request.getAttribute("flashSuccess");
    String flashError = (String) request.getAttribute("flashError");
%>

<% if (flashSuccess != null) { %>
<div id="flashMsgSuccess"
     style="margin:10px 0; padding:10px 12px; border-radius:12px; border:1px solid rgba(22,163,74,0.22); background: rgba(22,163,74,0.10); color:#166534;">
    <%= flashSuccess %>
</div>
<% } %>

<% if (flashError != null) { %>
<div id="flashMsgError"
     style="margin:10px 0; padding:10px 12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background: rgba(220,38,38,0.08); color:#991b1b;">
    <%= flashError %>
</div>
<% } %>

<%
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
    String pageError = (String) request.getAttribute("pageError");
%>

<% if (pageError != null) { %>
<div style="margin:10px 0; padding:10px 12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background: rgba(220,38,38,0.08); color:#991b1b;">
    <%= pageError %>
</div>
<% } %>

<table style="width:100%; border-collapse: collapse; margin-top: 10px;">
    <thead>
    <tr style="text-align:left;">
        <th style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.12);">ID</th>
        <th style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.12);">Guest</th>
        <th style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.12);">Room</th>
        <th style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.12);">Type</th>
        <th style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.12);">Check-in</th>
        <th style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.12);">Check-out</th>
        <th style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.12);">Guests</th>
        <th style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.12);">Status</th>
        <th style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.12);">Actions</th>
    </tr>
    </thead>
    <tbody>
    <% if (reservations != null && !reservations.isEmpty()) {
        for (Reservation r : reservations) { %>
    <tr>
        <td style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.08);"><%= r.getId() %></td>
        <td style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.08);"><%= r.getGuestName() %></td>
        <td style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.08);"><%= r.getRoomNumber() %></td>
        <td style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.08);"><%= r.getRoomTypeName() %></td>
        <td style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.08);"><%= r.getCheckIn() %></td>
        <td style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.08);"><%= r.getCheckOut() %></td>
        <td style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.08);"><%= r.getGuestsCount() %></td>
        <td style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.08); font-weight:700; color:<%= "PAID".equalsIgnoreCase(r.getStatus()) ? "#16a34a" : "#2563eb" %>;">
            <%= r.getStatus() %>
        </td>
        <td style="padding:10px; border-bottom: 1px solid rgba(2,6,23,0.08);">
            <a href="<%= request.getContextPath() %>/dashboard?page=reservationEdit&id=<%= r.getId() %>"
               style="margin-right:8px; text-decoration:none;">Edit</a>

            <form method="post" action="<%= request.getContextPath() %>/reservations/delete"
                  style="display:inline;" onsubmit="return confirm('Delete reservation ID <%= r.getId() %>?');">
                <input type="hidden" name="id" value="<%= r.getId() %>"/>
                <button type="submit" style="border:none; background:none; color:#dc2626; cursor:pointer; padding:0; margin-right:8px;">
                    Delete
                </button>
            </form>

            <% if ("CONFIRMED".equalsIgnoreCase(r.getStatus())) { %>
            <a href="<%= request.getContextPath() %>/dashboard?page=billing&reservationId=<%= r.getId() %>"
               style="text-decoration:none;">Generate Bill</a>
            <% } else { %>
            <span style="color:#94a3b8; cursor:not-allowed;">Generate Bill</span>
            <% } %>
        </td>
    </tr>
    <% } } else { %>
    <tr>
        <td colspan="9" style="padding:12px; color:#475569;">No reservations found.</td>
    </tr>
    <% } %>
    </tbody>
</table>

<script>
    (function () {
        const successEl = document.getElementById('flashMsgSuccess');
        const errorEl = document.getElementById('flashMsgError');

        if (successEl) setTimeout(() => { successEl.style.display = 'none'; }, 3000);
        if (errorEl) setTimeout(() => { errorEl.style.display = 'none'; }, 3000);
    })();
</script>