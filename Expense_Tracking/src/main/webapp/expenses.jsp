<%@ page import="ConnectionUtility.ConnectionClass" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Expenses</title>
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
    .expenses-card {
      background: #fff;
      border-radius: 28px;
      box-shadow: 0 8px 32px 0 rgba(52, 152, 219, 0.18), 0 1.5px 6px 0 rgba(0,0,0,0.07);
      padding: 36px 36px 24px 36px;
      min-width: 370px;
      max-width: 650px;
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      animation: fadeIn 1s cubic-bezier(.42,0,.58,1);
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(40px);}
      to { opacity: 1; transform: translateY(0);}
    }
    .logo {
      width: 60px;
      height: 60px;
      object-fit: contain;
      margin-bottom: 10px;
      animation: float 3s ease-in-out infinite;
    }
    @keyframes float {
      0% { transform: translateY(0);}
      50% { transform: translateY(-8px);}
      100% { transform: translateY(0);}
    }
    h2 {
      color: #3b82f6;
      margin-bottom: 10px;
      font-weight: 700;
      letter-spacing: 1px;
      text-align: center;
    }
    h4 {
      color: #2563eb;
      margin-bottom: 18px;
      font-weight: 400;
      text-align: center;
    }
    .expenses-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 18px;
      background: #f6fbff;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 1px 4px rgba(52, 152, 219, 0.05);
    }
    .expenses-table th, .expenses-table td {
      padding: 10px 12px;
      text-align: left;
    }
    .expenses-table th {
      background: #e0eafc;
      color: #2563eb;
      font-weight: 600;
      border-bottom: 2px solid #b6d0f7;
    }
    .expenses-table tr:nth-child(even) {
      background: #f0f6ff;
    }
    .expenses-table tr:hover {
      background: #e0eafc;
      transition: background 0.2s;
    }
    .pay-form {
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: stretch;
      gap: 10px;
      margin-top: 12px;
    }
    .pay-form label {
      font-weight: 600;
      color: #3b82f6;
      margin-bottom: 2px;
      letter-spacing: 0.3px;
    }
    .pay-form input[type="text"] {
      padding: 12px 14px;
      border-radius: 8px;
      border: 1.5px solid #b6d0f7;
      background: #f6fbff;
      font-size: 1rem;
      color: #2563eb;
      transition: border 0.25s, box-shadow 0.25s;
      width: 100%;
      box-sizing: border-box;
    }
    .pay-form input[type="text"]:focus {
      border: 1.5px solid #3b82f6;
      box-shadow: 0 0 8px #b6d0f7;
      outline: none;
      background: #e0eafc;
    }
    .pay-form input[type="submit"] {
      background: linear-gradient(90deg, #3b82f6 0%, #60a5fa 100%);
      color: white;
      padding: 12px 0;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      font-size: 1.08rem;
      font-weight: 700;
      letter-spacing: 0.8px;
      box-shadow: 0 2px 10px 0 rgba(52, 152, 219, 0.10);
      margin-top: 4px;
      transition: background 0.3s, transform 0.2s;
    }
    .pay-form input[type="submit"]:hover {
      background: linear-gradient(90deg, #60a5fa 0%, #3b82f6 100%);
      transform: translateY(-2px) scale(1.03);
    }
    .error-message {
      color: #d72660;
      margin-top: 10px;
      text-align: center;
    }
    @media (max-width: 650px) {
      .expenses-card {
        min-width: 0;
        max-width: 98vw;
        padding: 20px 4vw 12px 4vw;
      }
      .logo {
        width: 40px;
        height: 40px;
      }
      .expenses-table th, .expenses-table td {
        padding: 7px 4px;
        font-size: 0.95rem;
      }
    }
</style>
</head>
<body>
  <div class="expenses-card">
    <img src="./logo.png" alt="Expense App Logo" class="logo">
    <h2>User Expenses</h2>
    <%
        String username = (String) session.getAttribute("username");
        String search =request.getParameter("search");
        out.println("<h4>Here are the expenses for user: " + username + "</h4>");
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        String errorMsg = "";
        try {
            
            con = ConnectionClass.getConnection();
            stmt = con.createStatement();
            String sql = "SELECT expenses_id, amount, description, date, paid FROM expenses WHERE group_name = '" + search
                    + "' AND user_name = '" + username + "'";

            rs = stmt.executeQuery(sql);

            out.println("<table class='expenses-table'>");
            out.println("<tr><th>Expense ID</th><th>Amount</th><th>Description</th><th>Date</th><th>Paid</th></tr>");

            boolean hasRows = false;
            while (rs.next()) {
                hasRows = true;
                out.println("<tr>");
                out.println("<td>" + rs.getInt("expenses_id") + "</td>");
                out.println("<td>" + rs.getInt("amount") + "</td>");
                out.println("<td>" + rs.getString("description") + "</td>");
                out.println("<td>" + rs.getDate("date") + "</td>");
                out.println("<td>" + (rs.getBoolean("paid") ? "Yes" : "No") + "</td>");
                out.println("</tr>");
            }
            if (!hasRows) {
                out.println("<tr><td colspan='5' style='text-align:center;color:#999;'>No expenses found for this group.</td></tr>");
            }
            out.println("</table>");
        } catch (Exception e) {
            errorMsg = "Error: " + e.getMessage();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        if (!errorMsg.isEmpty()) {
            out.println("<div class='error-message'>" + errorMsg + "</div>");
        }
    %>
    <form class="pay-form" action="payment.jsp" method="post">
      <label for="pay">Pay</label>
      <input type="text" name="Pay" placeholder="Enter Expense ID" required>
      <input type="submit" value="Pay">
    </form>
  </div>
</body>
</html>
