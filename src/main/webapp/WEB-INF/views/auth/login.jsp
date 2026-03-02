<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ocean View Resort | Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <style>
        :root{
            --bg:#f6f8ff;
            --text:#0f172a;
            --muted:#475569;
            --border:rgba(2,6,23,0.12);
            --card:#ffffff;
            --shadow: 0 22px 60px rgba(2,6,23,0.10);

            --brand1:#3b82f6;
            --brand2:#4f46e5;
            --brand3:#06b6d4;

            --success:#16a34a;
            --danger:#dc2626;
        }

        *{box-sizing:border-box}
        body{
            margin:0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial;
            color: var(--text);
            background: radial-gradient(900px 550px at 20% 10%, rgba(59,130,246,0.18), transparent 60%),
            radial-gradient(900px 550px at 85% 90%, rgba(6,182,212,0.14), transparent 55%),
            var(--bg);
            min-height: 100vh;
        }

        .page{
            min-height: 100vh;
            display:grid;
            grid-template-columns: 1.15fr 0.85fr;
        }

        /* LEFT HERO */
        .hero{
            position:relative;
            padding: clamp(28px, 4vw, 56px);
            display:flex;
            flex-direction:column;
            justify-content:center;
            color: #fff;
            overflow:hidden;

            background: radial-gradient(900px 600px at 25% 10%, rgba(255,255,255,0.22), transparent 60%),
            linear-gradient(135deg, var(--brand1), var(--brand2));
        }

        .hero::before{
            content:"";
            position:absolute;
            inset:-120px -120px auto auto;
            width: 380px;
            height: 380px;
            border-radius: 999px;
            background: radial-gradient(circle at 30% 30%, rgba(6,182,212,0.9), rgba(6,182,212,0));
            opacity: 0.55;
            transform: rotate(10deg);
        }

        .hero::after{
            content:"";
            position:absolute;
            inset:auto -180px -180px auto;
            width: 520px;
            height: 520px;
            border-radius: 999px;
            background: radial-gradient(circle at 40% 40%, rgba(255,255,255,0.22), rgba(255,255,255,0));
            opacity: 0.55;
        }

        .brand{
            position:relative;
            display:flex;
            align-items:center;
            gap: 12px;
            margin-bottom: 18px;
        }

        .logo{
            width: 52px;
            height: 52px;
            border-radius: 16px;
            background: rgba(255,255,255,0.18);
            border: 1px solid rgba(255,255,255,0.24);
            display:flex;
            align-items:center;
            justify-content:center;
            backdrop-filter: blur(6px);
        }

        .brand h1{
            margin:0;
            font-size: 18px;
            letter-spacing: 0;
        }
        .brand p{
            margin: 2px 0 0;
            opacity: 0.85;
            font-size: 13px;
        }

        .heroTitle{
            position:relative;
            margin: 10px 0 8px;
            font-size: clamp(34px, 3.8vw, 52px);
            line-height: 1.05;
            letter-spacing: -0.5px;
        }

        .heroDesc{
            position:relative;
            margin: 0;
            opacity: 0.90;
            font-size: 16px;
            line-height: 1.65;
            max-width: 560px;
        }

        .heroBullets{
            position:relative;
            margin: 18px 0 0;
            padding:0;
            list-style:none;
            display:grid;
            gap: 10px;
            max-width: 560px;
        }

        .heroBullets li{
            display:flex;
            gap: 10px;
            align-items:flex-start;
            font-size: 14px;
            opacity: 0.95;
        }

        .tick{
            width: 20px;
            height: 20px;
            border-radius: 8px;
            background: rgba(255,255,255,0.18);
            border: 1px solid rgba(255,255,255,0.20);
            display:flex;
            align-items:center;
            justify-content:center;
            flex: 0 0 auto;
            margin-top: 2px;
        }

        .copyright{
            position:relative;
            margin-top: 26px;
            font-size: 12px;
            opacity: 0.75;
        }

        /* RIGHT FORM */
        .formSide{
            display:flex;
            align-items:center;
            justify-content:center;
            padding: clamp(18px, 3vw, 46px);
            background: rgba(255,255,255,0.55);
            backdrop-filter: blur(8px);
            border-left: 1px solid var(--border);
        }

        .card{
            width: min(430px, 100%);
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 24px 22px;
            box-shadow: var(--shadow);
        }

        .cardTitle{
            margin: 0 0 6px;
            font-size: 18px;
        }
        .cardSub{
            margin: 0 0 14px;
            color: var(--muted);
            font-size: 13px;
            line-height: 1.55;
        }

        .alert{
            border-radius: 12px;
            padding: 10px 12px;
            margin: 0 0 12px;
            border: 1px solid var(--border);
            font-size: 13px;
        }
        .alert.error{
            background: rgba(220,38,38,0.08);
            border-color: rgba(220,38,38,0.22);
            color: #991b1b;
        }
        .alert.success{
            background: rgba(22,163,74,0.10);
            border-color: rgba(22,163,74,0.22);
            color: #166534;
        }

        form{ display:grid; gap: 12px; }

        label{
            font-size: 13px;
            color: #334155;
            display:block;
            margin-bottom: 6px;
        }

        input{
            width: 100%;
            height: 46px;
            border-radius: 12px;
            border: 1px solid rgba(2,6,23,0.14);
            padding: 10px 12px;
            background: #fff;
            outline:none;
        }
        input:focus{
            border-color: rgba(59,130,246,0.50);
            box-shadow: 0 0 0 4px rgba(59,130,246,0.14);
        }

        .passwordWrap{ position:relative; }
        .toggleBtn{
            position:absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            width: 36px;
            height: 36px;
            border-radius: 11px;
            border: 1px solid rgba(2,6,23,0.12);
            background: #fff;
            cursor:pointer;
            display:flex;
            align-items:center;
            justify-content:center;
        }
        .toggleBtn:hover{ background: rgba(59,130,246,0.06); }
        .toggleBtn svg{ width:18px; height:18px; fill: rgba(15,23,42,0.72); }

        .btn{
            width: 100%;
            height: 46px;
            border-radius: 12px;
            border: 0;
            cursor:pointer;
            font-weight: 750;
            color: white;
            background: linear-gradient(135deg, var(--brand1), var(--brand3));
            box-shadow: 0 12px 26px rgba(59,130,246,0.22);
        }
        .btn:active{ transform: translateY(1px); }

        .tip{
            margin-top: 12px;
            font-size: 13px;
            color: var(--muted);
            line-height: 1.5;
        }

        @media (max-width: 980px){
            .page{ grid-template-columns: 1fr; }
            .formSide{ border-left:none; border-top: 1px solid var(--border); }
        }
    </style>
</head>

<body>
<div class="page">
    <section class="hero">
        <div class="brand">
            <div class="logo" aria-hidden="true">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
                    <path d="M3 16c3 0 3-2 6-2s3 2 6 2 3-2 6-2" stroke="rgba(255,255,255,0.95)" stroke-width="2" stroke-linecap="round"></path>
                    <path d="M3 11c3 0 3-2 6-2s3 2 6 2 3-2 6-2" stroke="rgba(255,255,255,0.70)" stroke-width="2" stroke-linecap="round"></path>
                </svg>
            </div>
            <div>
                <h1>Ocean View Resort</h1>
                <p>Online Room Reservation System</p>
            </div>
        </div>

        <h2 class="heroTitle">Hello, welcome back! 👋</h2>
        <p class="heroDesc">
            Manage reservations, view booking details, and generate customer bills in a clean and professional workflow.
        </p>

        <ul class="heroBullets">
            <li><span class="tick">✓</span><span>Session-based secure login and protected dashboard routes</span></li>
            <li><span class="tick">✓</span><span>Layered architecture: Controller → Service → DAO</span></li>
            <li><span class="tick">✓</span><span>Ready for reservations, billing, and reporting modules</span></li>
        </ul>

        <div class="copyright">© Ocean View Resort. All rights reserved.</div>
    </section>

    <section class="formSide">
        <div class="card">
            <h3 class="cardTitle">Sign in</h3>
            <p class="cardSub">Enter your credentials to continue.</p>

            <%
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
                String redirectUrl = (String) request.getAttribute("redirectUrl");
            %>

            <% if (error != null) { %>
            <div class="alert error"><%= error %></div>
            <% } %>

            <% if (success != null) { %>
            <div class="alert success"><%= success %></div>
            <% } %>

            <form method="post" action="<%= request.getContextPath() %>/login" autocomplete="off">
                <div>
                    <label for="username">Username</label>
                    <input id="username" type="text" name="username" placeholder="e.g., admin" required />
                </div>

                <div>
                    <label for="password">Password</label>
                    <div class="passwordWrap">
                        <input id="password" type="password" name="password" placeholder="••••••••" required style="padding-right:56px;"/>
                        <button class="toggleBtn" type="button" id="togglePwd" aria-label="Show/Hide password">
                            <svg viewBox="0 0 24 24">
                                <path d="M12 5c5.5 0 9.8 4.5 10.9 6.1.2.3.2.6 0 .9C21.8 13.5 17.5 18 12 18S2.2 13.5 1.1 12c-.2-.3-.2-.6 0-.9C2.2 9.5 6.5 5 12 5zm0 2C7.8 7 4.3 10.4 3.2 11.5 4.3 12.6 7.8 16 12 16s7.7-3.4 8.8-4.5C19.7 10.4 16.2 7 12 7zm0 2.2A2.8 2.8 0 1 1 12 15a2.8 2.8 0 0 1 0-5.6z"></path>
                            </svg>
                        </button>
                    </div>
                </div>

                <button class="btn" type="submit">Login</button>
            </form>

            <div class="tip">
                Tip: Use your assigned staff credentials. If you have access issues, contact the system administrator.
            </div>
        </div>
    </section>
</div>

<script>
    // show/hide password
    const pwd = document.getElementById("password");
    document.getElementById("togglePwd").addEventListener("click", () => {
        pwd.type = (pwd.type === "password") ? "text" : "password";
    });

    // redirect after showing success message
    const redirectUrl = "<%= (redirectUrl != null ? redirectUrl : "") %>";
    const hasSuccess = <%= (success != null ? "true" : "false") %>;
    if (hasSuccess && redirectUrl) {
        setTimeout(() => { window.location.href = redirectUrl; }, 1600);
    }
</script>
</body>
</html>