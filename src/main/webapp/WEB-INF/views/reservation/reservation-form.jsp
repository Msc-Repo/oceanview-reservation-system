<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.icbt.oceanview.reservation.model.RoomType" %>
<%@ page import="lk.icbt.oceanview.reservation.model.Room" %>
<%@ page import="java.time.LocalDate" %>


<%
    String flashSuccess = (String) request.getAttribute("flashSuccess");
    String flashError = (String) request.getAttribute("flashError");
    String formError = (String) request.getAttribute("formError");
%>

<div id="flash-area" style="display:grid; gap:10px;">
    <% if (flashSuccess != null) { %>
    <div class="flash-msg flash-success"
         style="padding:10px 12px; border-radius:12px; border:1px solid rgba(22,163,74,0.22); background: rgba(22,163,74,0.10); color:#166534;">
        <%= flashSuccess %>
    </div>
    <% } %>

    <% if (flashError != null) { %>
    <div class="flash-msg flash-error"
         style="padding:10px 12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background: rgba(220,38,38,0.08); color:#991b1b;">
        <%= flashError %>
    </div>
    <% } %>

    <% if (formError != null) { %>
    <div class="flash-msg flash-error"
         style="padding:10px 12px; border-radius:12px; border:1px solid rgba(220,38,38,0.22); background: rgba(220,38,38,0.08); color:#991b1b;">
        <%= formError %>
    </div>
    <% } %>
</div>


<script>
    (function () {
        const flashArea = document.getElementById("flash-area");
        if (!flashArea) return;

        const msgs = flashArea.querySelectorAll(".flash-msg");
        if (!msgs.length) return;

        // Show for 3.5 seconds, then fade and remove
        setTimeout(() => {
            msgs.forEach(m => {
                m.style.transition = "opacity 500ms ease, transform 500ms ease";
                m.style.opacity = "0";
                m.style.transform = "translateY(-6px)";
            });

            setTimeout(() => {
                msgs.forEach(m => m.remove());
            }, 550);
        }, 3500);
    })();
</script>

<h3>Make Reservation</h3>

<div style="display:flex; gap:10px; margin: 10px 0 16px;">
    <a href="<%= request.getContextPath() %>/dashboard?page=reservationList"
       style="text-decoration:none; padding:10px 12px; border-radius:12px; border:1px solid rgba(2,6,23,0.12); background:white;">
        View Reservations →
    </a>
</div>


<%
    List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
    List<Room> availableRooms = (List<Room>) request.getAttribute("availableRooms");

    String checkIn = (String) request.getAttribute("checkIn");
    String checkOut = (String) request.getAttribute("checkOut");

    if (checkIn == null || checkIn.isBlank() || "null".equalsIgnoreCase(checkIn)) {
        checkIn = LocalDate.now().toString(); // yyyy-MM-dd
    }
    if (checkOut == null || checkOut.isBlank() || "null".equalsIgnoreCase(checkOut)) {
        checkOut = LocalDate.now().plusDays(1).toString(); // yyyy-MM-dd
    }
    Integer selectedTypeId = (Integer) request.getAttribute("selectedTypeId");
    if (selectedTypeId == null) selectedTypeId = 0;
%>

<!-- Step 1: Choose type + dates (reloads available rooms by hitting /reservations/form) -->
<form method="get" action="<%= request.getContextPath() %>/dashboard"
      style="display:grid; gap:12px; max-width: 820px;">

    <input type="hidden" name="page" value="reservationForm"/>

    <div style="display:grid; grid-template-columns: 1fr 1fr; gap:12px;">
        <div>
            <label>Check-in</label>
            <label>
                <input name="checkIn" type="date" value="<%= checkIn %>" required
                       style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
            </label>
        </div>
        <div>
            <label>Check-out</label>
            <label>
                <input name="checkOut" type="date" value="<%= checkOut %>" required
                       style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
            </label>
        </div>
    </div>

    <div>
        <label>Room Type</label>
        <label>
            <select name="typeId" required
                    style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);">
                <option value="">-- Select room type --</option>
                <% if (roomTypes != null) {
                    for (RoomType rt : roomTypes) { %>
                <option value="<%= rt.getId() %>" <%= (rt.getId() == selectedTypeId ? "selected" : "") %>>
                    <%= rt.getTypeName() %> (LKR <%= (int) rt.getRatePerNight() %>/night)
                </option>
                <%  } } %>
            </select>
        </label>
    </div>

    <button type="submit"
            style="height:46px; border-radius:12px; border:0; cursor:pointer; font-weight:750; color:white; background: linear-gradient(135deg, #2563eb, #06b6d4);">
        Load Available Rooms
    </button>
</form>

<hr style="margin:18px 0; border:none; border-top:1px solid rgba(2,6,23,0.10);" />

<!-- Step 2: Full reservation form -->
<form method="post" action="<%= request.getContextPath() %>/reservations/create"
      style="display:grid; gap:12px; max-width: 820px;">

    <input type="hidden" name="checkIn" value="<%= checkIn %>"/>
    <input type="hidden" name="checkOut" value="<%= checkOut %>"/>
    <input type="hidden" name="typeId" value="<%= selectedTypeId %>"/>

    <div style="display:grid; grid-template-columns: 1fr 1fr; gap:12px;">
        <div>
            <label>Guest Full Name</label>
            <label>
                <input name="fullName" required
                       style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
            </label>
        </div>
        <div>
            <label>NIC / Passport</label>
            <label>
                <input name="nic" required
                       style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
            </label>
        </div>
    </div>

    <div style="display:grid; grid-template-columns: 1fr 1fr; gap:12px;">
        <div>
            <label>Phone</label>
            <label>
                <input name="phone" required
                       style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
            </label>
        </div>
        <div>
            <label>Email (optional)</label>
            <label>
                <input name="email" type="email"
                       style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
            </label>
        </div>
    </div>

    <div style="display:grid; grid-template-columns: 1fr 1fr; gap:12px;">
        <div>
            <label>Guests Count</label>
            <label>
                <input name="guestsCount" type="number" min="1" value="1" required
                       style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);" />
            </label>
        </div>

        <div>
            <label>Available Room</label>
            <label>
                <select name="roomId" required
                        style="width:100%; height:44px; border-radius:12px; padding:10px; border:1px solid rgba(2,6,23,0.14);">
                    <option value="">-- Select room --</option>
                    <% if (availableRooms != null) {
                        for (Room room : availableRooms) { %>
                    <option value="<%= room.getId() %>">Room <%= room.getRoomNumber() %></option>
                    <%  } } %>
                </select>
            </label>
            <div style="margin-top:6px; color:#475569; font-size:13px;">
                Load available rooms first (choose dates + type).
            </div>
        </div>
    </div>

    <button type="submit"
            style="height:46px; border-radius:12px; border:0; cursor:pointer; font-weight:750; color:white; background: linear-gradient(135deg, #2563eb, #06b6d4);">
        Save Reservation
    </button>
</form>