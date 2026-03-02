<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ocean View Resort | Login</title>
</head>
<body>
<h2>Login</h2>

<% String error = (String) request.getAttribute("error"); %>
<% if (error != null) { %>
<p style="color:red;"><%= error %></p>
<% } %>

<form method="post" action="<%= request.getContextPath() %>/login">
    <label>Username:</label>
    <label>
        <input type="text" name="username" required />
    </label>
    <br/><br/>

    <label>Password:</label>
    <label>
        <input type="password" name="password" required />
    </label>
    <br/><br/>

    <button type="submit">Login</button>
</form>
</body>
</html>