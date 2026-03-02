<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="lk.icbt.oceanview.auth.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ocean View Resort | Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style>
        :root{
            --bg1:#eef2ff;
            --bg2:#ecfeff;
            --card:#ffffff;
            --text:#0f172a;
            --muted:#475569;
            --border:rgba(2,6,23,0.12);
            --primary:#2563eb;
            --primary2:#06b6d4;
            --danger:#dc2626;
        }
        *{box-sizing:border-box}
        body{
            margin:0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial;
            color: var(--text);
            background: radial-gradient(900px 500px at 20% 15%, rgba(37,99,235,0.16), transparent 60%),
            radial-gradient(700px 450px at 80% 85%, rgba(6,182,212,0.14), transparent 55%),
            linear-gradient(135deg, var(--bg1), var(--bg2));
            min-height:100vh;
        }
        .layout{ display:flex; min-height:100vh; }

        .sidebar{
            width: 270px;
            padding: 18px 14px;
            border-right: 1px solid var(--border);
            background: rgba(255,255,255,0.65);
            backdrop-filter: blur(10px);
        }
        .brand{
            display:flex; align-items:center; gap:10px;
            padding: 10px 10px 16px;
            border-bottom: 1px solid var(--border);
            margin-bottom: 14px;
        }
        .logo{
            width:40px; height:40px;
            border-radius: 12px;
            background: linear-gradient(135deg, rgba(37,99,235,0.18), rgba(6,182,212,0.14));
            border: 1px solid rgba(37,99,235,0.14);
            display:flex; align-items:center; justify-content:center;
        }
        .brand h1{ margin:0; font-size: 14px; letter-spacing:0; }
        .brand p{ margin:2px 0 0; font-size: 12px; color: var(--muted); }

        .nav{
            display:grid;
            gap: 10px;
            padding: 10px;
        }
        .nav a{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap: 10px;
            padding: 12px 12px;
            border-radius: 12px;
            text-decoration:none;
            color: var(--text);
            border: 1px solid rgba(2,6,23,0.10);
            background: white;
            box-shadow: 0 10px 22px rgba(2,6,23,0.06);
        }
        .nav a:hover{
            border-color: rgba(37,99,235,0.22);
            box-shadow: 0 0 0 4px rgba(37,99,235,0.10);
        }
        .nav .danger{
            color: white;
            border: none;
            background: linear-gradient(135deg, rgba(220,38,38,0.95), rgba(239,68,68,0.85));
        }
        .nav .danger:hover{
            box-shadow: 0 0 0 4px rgba(220,38,38,0.14);
        }

        .main{
            flex:1;
            padding: 22px;
            display:flex;
            flex-direction:column;
            gap: 16px;
        }

        .topbar{
            display:flex;
            align-items:flex-start;
            justify-content:space-between;
            gap: 14px;
            padding: 16px 18px;
            border: 1px solid var(--border);
            border-radius: 16px;
            background: rgba(255,255,255,0.70);
            backdrop-filter: blur(10px);
            box-shadow: 0 16px 40px rgba(2,6,23,0.08);
        }
        .topbar h2{ margin:0; font-size: 20px; }
        .topbar p{ margin:4px 0 0; color: var(--muted); font-size: 13px; }

        .card{
            border: 1px solid var(--border);
            border-radius: 16px;
            background: rgba(255,255,255,0.72);
            backdrop-filter: blur(10px);
            padding: 18px;
            box-shadow: 0 16px 40px rgba(2,6,23,0.08);
        }
        .grid{
            display:grid;
            gap: 12px;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            margin-top: 14px;
        }
        .kpi{
            padding: 14px;
            border-radius: 14px;
            border: 1px solid rgba(2,6,23,0.08);
            background: white;
            box-shadow: 0 10px 22px rgba(2,6,23,0.06);
        }
        .kpi .label{ font-size: 12px; color: var(--muted); }
        .kpi .value{ font-size: 20px; margin-top:6px; font-weight: 800; }

        @media (max-width: 980px){
            .sidebar{ width: 230px; }
            .grid{ grid-template-columns: 1fr; }
        }
        @media (max-width: 720px){
            .layout{ flex-direction: column; }
            .sidebar{ width: 100%; border-right: none; border-bottom: 1px solid var(--border); }
        }
    </style>
</head>
<body>
<%
    User user = (User) session.getAttribute("authUser");
    String username = (user != null ? user.getUsername() : "User");
%>

<div class="layout">
    <aside class="sidebar">
        <div class="brand">
            <div class="logo" aria-hidden="true">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                    <path d="M3 16c3 0 3-2 6-2s3 2 6 2 3-2 6-2" stroke="rgba(15,23,42,0.85)" stroke-width="2" stroke-linecap="round"></path>
                    <path d="M3 11c3 0 3-2 6-2s3 2 6 2 3-2 6-2" stroke="rgba(15,23,42,0.55)" stroke-width="2" stroke-linecap="round"></path>
                </svg>
            </div>
            <div>
                <h1>Ocean View Resort</h1>
                <p>Reservation Dashboard</p>
            </div>
        </div>

        <nav class="nav">
            <a href="<%= request.getContextPath() %>/dashboard?page=home">Home</a>
            <a href="<%= request.getContextPath() %>/dashboard?page=reservationForm">Make Reservation</a>
            <a href="<%= request.getContextPath() %>/dashboard?page=reservationList">View Reservations</a>
            <a href="<%= request.getContextPath() %>/dashboard?page=billing">Generate Bill</a>
            <a href="<%= request.getContextPath() %>/dashboard?page=help">Help</a>

            <a class="danger"
               href="<%= request.getContextPath() %>/logout"
               onclick="return confirm('Are you sure you want to log out?');">
                Logout
            </a>
        </nav>
    </aside>

    <main class="main">
        <div class="topbar">
            <div>
                <h2>Welcome, <%= username %> 👋</h2>
                <p>Select an option from the sidebar to manage reservations and billing.</p>
            </div>
        </div>


        <%
            String currentPage = (String) request.getAttribute("page");
            if (currentPage == null || currentPage.isBlank()) {
                currentPage = "home";
            }
        %>

        <div class="card">

            <% switch (currentPage) {
                case "home" -> { %>
            <h3>Home</h3>
            <p style="color: var(--muted);">
                Welcome to the Ocean View Resort Reservation System.
                Use the sidebar to manage reservations and billing.
            </p>

            <%
                } case "reservationForm" -> { %>
            <jsp:include page="/WEB-INF/views/reservation/reservation-form.jsp"/>

            <%
                } case "reservationList" -> { %>
            <jsp:include page="/WEB-INF/views/reservation/reservation-list.jsp"/>

            <%
                } case "billing" -> { %>
            <jsp:include page="/WEB-INF/views/billing/billing.jsp"/>

            <%
                } case "help" -> { %>
            <jsp:include page="/WEB-INF/views/help/help.jsp"/>

            <%
                } default -> { %>
            <h3>Page Not Found</h3>
            <%
                    }
                } %>

        </div>
    </main>
</div>

</body>
</html>