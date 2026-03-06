<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.icbt.oceanview.reservation.model.Reservation" %>
<%@ page import="lk.icbt.oceanview.reservation.model.RoomType" %>
<%@ page import="lk.icbt.oceanview.reservation.model.Room" %>

<h3>Edit Reservation</h3>

<%
  Reservation r = (Reservation) request.getAttribute("reservation");

  String pageError = (String) request.getAttribute("pageError");
  String formError = (String) request.getAttribute("formError");
  String flashSuccess = (String) request.getAttribute("flashSuccess");
  String flashError = (String) request.getAttribute("flashError");

  List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
  List<Room> availableRooms = (List<Room>) request.getAttribute("availableRooms");

  Integer selectedTypeIdObj = (Integer) request.getAttribute("selectedTypeId");
  int selectedTypeId = (selectedTypeIdObj == null && r != null) ? r.getRoomTypeId() :
          (selectedTypeIdObj == null ? 0 : selectedTypeIdObj);

  String checkInVal = (String) request.getAttribute("checkIn");
  String checkOutVal = (String) request.getAttribute("checkOut");

  if ((checkInVal == null || checkInVal.isBlank()) && r != null) checkInVal = r.getCheckIn().toString();
  if ((checkOutVal == null || checkOutVal.isBlank()) && r != null) checkOutVal = r.getCheckOut().toString();
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

<!-- ========== (A) Reload Rooms Form (GET) ==========
This form keeps the dashboard layout.
It reloads availableRooms when Type/Dates change.
-->
<form id="reloadRoomsForm" method="get" action="<%= request.getContextPath() %>/dashboard"
      style="display:grid; gap:12px; max-width: 820px; margin-bottom: 16px;">

  <input type="hidden" name="page" value="reservationEdit"/>
  <input type="hidden" name="id" value="<%= r.getId() %>"/>

  <div style="display:grid; grid-template-columns: 1fr 1fr; gap:12px;">
    <div>
      <label>Check-in</label>
      <input id="reloadCheckIn" name="checkIn" type="date" value="<%= checkInVal %>" required
             style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
    </div>
    <div>
      <label>Check-out</label>
      <input id="reloadCheckOut" name="checkOut" type="date" value="<%= checkOutVal %>" required
             style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
    </div>
  </div>

  <div>
    <label>Room Type</label>
    <select id="reloadTypeId" name="typeId" required
            style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);">
      <% if (roomTypes != null) {
        for (RoomType rt : roomTypes) { %>
      <option value="<%= rt.getId() %>" <%= (rt.getId() == selectedTypeId ? "selected" : "") %>>
        <%= rt.getTypeName() %>
      </option>
      <% } } %>
    </select>
    <div style="margin-top:6px; color:#475569; font-size:12.5px;">
      Changing dates or room type reloads available rooms automatically.
    </div>
  </div>

  <button type="submit" style="display:none;">Reload</button>
</form>

<script>
  (function () {
    const form = document.getElementById('reloadRoomsForm');
    const typeSel = document.getElementById('reloadTypeId');
    const inDate = document.getElementById('reloadCheckIn');
    const outDate = document.getElementById('reloadCheckOut');

    function safeSubmit() {
      if (typeSel.value && inDate.value && outDate.value) {
        form.submit();
      }
    }

    typeSel.addEventListener('change', safeSubmit);
    inDate.addEventListener('change', safeSubmit);
    outDate.addEventListener('change', safeSubmit);
  })();
</script>

<hr style="margin: 16px 0; border:none; border-top:1px solid rgba(2,6,23,0.10);" />

<!-- ========== (B) Update Reservation Form (POST) ==========
Uses the selectedTypeId + checkInVal + checkOutVal and the reloaded availableRooms.
-->
<form method="post" action="<%= request.getContextPath() %>/reservations/update"
      style="display:grid; gap:12px; max-width: 820px;">

  <input type="hidden" name="reservationId" value="<%= r.getId() %>"/>
  <input type="hidden" name="guestId" value="<%= r.getGuestId() %>"/>
  <input type="hidden" name="currentRoomId" value="<%= r.getRoomId() %>"/>

  <!-- keep selected filter values in POST -->
  <input type="hidden" name="typeId" value="<%= selectedTypeId %>"/>
  <input type="hidden" name="checkIn" value="<%= checkInVal %>"/>
  <input type="hidden" name="checkOut" value="<%= checkOutVal %>"/>

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
      <div style="margin-top:6px; color:#64748b; font-size:12px;">
        Enter updated phone (Guest table is updated during reservation update).
      </div>
    </div>
    <div>
      <label>Email</label>
      <input name="email" type="email"
             style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
      <div style="margin-top:6px; color:#64748b; font-size:12px;">
        Email is optional.
      </div>
    </div>
  </div>

  <div>
    <label>Room (Available)</label>
    <select name="roomId" required
            style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);">
      <% if (availableRooms != null && !availableRooms.isEmpty()) {
        for (Room room : availableRooms) { %>
      <option value="<%= room.getId() %>" <%= (room.getId() == r.getRoomId() ? "selected" : "") %>>
        Room <%= room.getRoomNumber() %>
      </option>
      <%  } } else { %>
      <option value="">No rooms available for selected dates/type</option>
      <% } %>
    </select>

    <div style="margin-top:6px; color:#475569; font-size:12.5px;">
      If you change dates/type above, rooms reload automatically.
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

<script>
  // Auto-hide flash messages (optional polish)
  (function () {
    const s = document.getElementById('flashMsgSuccess');
    const e = document.getElementById('flashMsgError');
    const hideAfterMs = 3000;
    if (s) setTimeout(() => { s.style.display = 'none'; }, hideAfterMs);
    if (e) setTimeout(() => { e.style.display = 'none'; }, hideAfterMs);
  })();
</script>

<% } %>