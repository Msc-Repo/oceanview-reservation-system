<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.icbt.oceanview.reservation.model.Reservation" %>
<%@ page import="lk.icbt.oceanview.reservation.model.RoomType" %>
<%@ page import="lk.icbt.oceanview.reservation.model.Room" %>

<h3>Edit Reservation</h3>

<%
  Reservation r = (Reservation) request.getAttribute("reservation");
  String formError = (String) request.getAttribute("formError");
  String pageError = (String) request.getAttribute("pageError");
  List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
  List<Room> availableRooms = (List<Room>) request.getAttribute("availableRooms");
%>

<% if (pageError != null) { %>
<div style="margin:10px 0; padding:10px 12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background: rgba(220,38,38,0.08); color:#991b1b;">
  <%= pageError %>
</div>
<% } %>

<% if (formError != null) { %>
<div style="margin:10px 0; padding:10px 12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background: rgba(220,38,38,0.08); color:#991b1b;">
  <%= formError %>
</div>
<% } %>

<% if (r != null) { %>

<form method="post" action="<%= request.getContextPath() %>/reservations/update"
      style="display:grid; gap:12px; max-width: 820px;">

  <input type="hidden" name="reservationId" value="<%= r.getId() %>"/>
  <input type="hidden" name="guestId" value="<%= r.getGuestId() %>"/>
  <input type="hidden" name="currentRoomId" value="<%= r.getRoomId() %>"/>

  <div style="display:grid; grid-template-columns: 1fr 1fr; gap:12px;">
    <div>
      <label>Guest Name</label>
      <input name="fullName" value="<%= r.getGuestName() %>" required
             style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
    </div>

    <div>
      <label>Guests Count</label>
      <input name="guestsCount" type="number" min="1" value="<%= r.getGuestsCount() %>" required
             style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
    </div>
  </div>

  <div style="display:grid; grid-template-columns: 1fr 1fr; gap:12px;">
    <div>
      <label>Phone</label>
      <input name="phone" required
             style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
      <div style="color:#64748b; font-size:12px; margin-top:4px;">
        (Phone value loads from guests table — ensure DashboardServlet sets it if needed)
      </div>
    </div>

    <div>
      <label>Email</label>
      <input name="email" type="email"
             style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
      <div style="color:#64748b; font-size:12px; margin-top:4px;">
        (Email value loads from guests table)
      </div>
    </div>
  </div>

  <div style="display:grid; grid-template-columns: 1fr 1fr; gap:12px;">
    <div>
      <label>Check-in</label>
      <input name="checkIn" type="date" value="<%= r.getCheckIn() %>" required
             style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
    </div>
    <div>
      <label>Check-out</label>
      <input name="checkOut" type="date" value="<%= r.getCheckOut() %>" required
             style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
    </div>
  </div>

  <div style="display:grid; grid-template-columns: 1fr 1fr; gap:12px;">
    <div>
      <label>Room Type</label>
      <select name="typeId" required
              style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);">
        <% if (roomTypes != null) {
          for (RoomType rt : roomTypes) { %>
        <option value="<%= rt.getId() %>" <%= (rt.getId() == r.getRoomTypeId() ? "selected" : "") %>>
          <%= rt.getTypeName() %>
        </option>
        <% } } %>
      </select>
    </div>

    <div>
      <label>Room</label>
      <select name="roomId" required
              style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);">
        <% if (availableRooms != null) {
          for (Room room : availableRooms) { %>
        <option value="<%= room.getId() %>" <%= (room.getId() == r.getRoomId() ? "selected" : "") %>>
          Room <%= room.getRoomNumber() %>
        </option>
        <% } } %>
      </select>
    </div>
  </div>

  <button type="submit"
          style="height:46px; border-radius:12px; border:0; cursor:pointer; font-weight:750; color:white; background: linear-gradient(135deg, #2563eb, #06b6d4);">
    Update Reservation
  </button>

  <a href="<%= request.getContextPath() %>/dashboard?page=reservationList"
     style="text-decoration:none; margin-top:6px; display:inline-block; color:#2563eb;">
    ← Back to Reservations
  </a>
</form>

<% } %>