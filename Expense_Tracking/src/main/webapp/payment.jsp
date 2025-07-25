<%@ page import="ConnectionUtility.ConnectionClass" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String msg = "";
    boolean success = false;
    String eidStr = request.getParameter("Pay");
    if (eidStr != null) {
        int eid = Integer.parseInt(eidStr);
        Connection con = null;
        Statement stmt = null;
        try {
        	con=ConnectionClass.getConnection();
            stmt = con.createStatement();
            String sql = "UPDATE expenses SET paid=1 WHERE expenses_id=" + eid;
            int rows = stmt.executeUpdate(sql);
            if (rows > 0) {
                msg = "Payment Successful!";
                success = true;
            } else {
                msg = "No such expense found.";
            }
        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    } else {
        msg = "Invalid request.";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Status</title>
    <style>
        body {
          margin: 0;
          min-height: 100vh;
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
          background: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
          display: flex;
          align-items: center;
          justify-content: center;
          background-size: 200% 200%;
          animation: bgMove 14s ease-in-out infinite;
        }
        @keyframes bgMove {
          0% { background-position: 0% 50%; }
          50% { background-position: 100% 50%; }
          100% { background-position: 0% 50%; }
        }
        .card {
          background: #fff;
          border-radius: 28px;
          box-shadow: 0 8px 32px 0 rgba(52, 152, 219, 0.18), 0 1.5px 6px 0 rgba(0,0,0,0.07);
          padding: 36px 36px 24px 36px;
          min-width: 320px;
          display: flex;
          flex-direction: column;
          align-items: center;
          animation: fadeIn 1s cubic-bezier(.42,0,.58,1);
        }
        @keyframes fadeIn {
          from { opacity: 0; transform: translateY(40px); }
          to { opacity: 1; transform: translateY(0); }
        }
        .logo {
          width: 60px;
          height: 60px;
          object-fit: contain;
          margin-bottom: 10px;
          animation: float 3s ease-in-out infinite;
        }
        @keyframes float {
          0% { transform: translateY(0); }
          50% { transform: translateY(-8px); }
          100% { transform: translateY(0); }
        }
        h2 {
          color: <%= success ? "#3b82f6" : "#d72660" %>;
          margin-bottom: 10px;
          font-weight: 700;
          letter-spacing: 1px;
          text-align: center;
        }
        p {
          color: #2563eb;
          font-size: 1.1rem;
          margin-bottom: 18px;
          text-align: center;
        }
        .back-btn {
          background: linear-gradient(90deg, #3b82f6 0%, #60a5fa 100%);
          color: white;
          padding: 12px 36px;
          border: none;
          border-radius: 10px;
          cursor: pointer;
          font-size: 1.08rem;
          font-weight: 700;
          letter-spacing: 0.8px;
          box-shadow: 0 2px 10px 0 rgba(52, 152, 219, 0.10);
          margin-top: 12px;
          transition: background 0.3s, transform 0.2s;
        }
        .back-btn:hover {
          background: linear-gradient(90deg, #60a5fa 0%, #3b82f6 100%);
          transform: translateY(-2px) scale(1.03);
        }
        @media (max-width: 540px) {
          .card { min-width: 0; width: 94vw; padding: 20px 4vw 12px 4vw; }
          .logo { width: 40px; height: 40px; }
        }
    </style>
</head>
<body>
    <div class="card">
        <img src="./logo.png" alt="Expense App Logo" class="logo">
        <h2><%= msg %></h2>
        <% if (success) { %>
            <p>Your payment has been processed successfully.</p>
        <% } else { %>
            <p style="color:#d72660;"><%= msg %></p>
        <% } %>
        <form action="home.jsp">
            <button class="back-btn" type="submit">Back to Home</button>
        </form>
    </div>
</body>
</html>
