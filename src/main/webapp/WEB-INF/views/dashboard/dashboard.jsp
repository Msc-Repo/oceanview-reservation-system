<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ocean View Resort | Dashboard</title>
</head>
<body>
<h2>Dashboard</h2>

<% String success = (String) request.getAttribute("flashSuccess"); %>
<% if (success != null) { %>
<p style="color:green;"><%= success %></p>
<% } %>

<div style="display:flex;">
    <div style="width:200px; border-right:1px solid #ccc; padding:10px;">
        <p><b>Menu</b></p>
        <ul>
            <li><a href="#">Make Reservation</a></li>
            <li><a href="#">View Reservations</a></li>
            <li><a href="#">Generate Bill</a></li>
            <li><a href="#">Help</a></li>
            <li><a href="<%= request.getContextPath() %>/logout">Logout</a></li>
        </ul>
    </div>

    <div style="flex:1; padding:10px;">
        <p>Welcome to Ocean View Resort Reservation System.</p>
        <p>Main content area will be loaded here.</p>
    </div>
</div>

</body>
</html>