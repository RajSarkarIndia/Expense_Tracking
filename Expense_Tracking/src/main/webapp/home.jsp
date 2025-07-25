<%@ page import="ConnectionUtility.ConnectionClass" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dashboard</title>
  <style>
    body {
      margin: 0;
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
      display: flex;
      flex-direction: column;
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
    .dashboard-card {
      background: #fff;
      border-radius: 28px;
      box-shadow: 0 8px 32px 0 rgba(52, 152, 219, 0.18), 0 1.5px 6px 0 rgba(0,0,0,0.07);
      padding: 36px 36px 24px 36px;
      min-width: 380px;
      max-width: 500px;
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      animation: fadeIn 1s cubic-bezier(.42,0,.58,1);
      position: relative;
      margin-top: 40px;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(40px);}
      to { opacity: 1; transform: translateY(0);}
    }
    .logo {
      width: 70px;
      height: 70px;
      object-fit: contain;
      margin-bottom: 10px;
      animation: float 3s ease-in-out infinite;
    }
    @keyframes float {
      0% { transform: translateY(0);}
      50% { transform: translateY(-8px);}
      100% { transform: translateY(0);}
    }
    h1 {
      color: #3b82f6;
      font-size: 2rem;
      margin: 0 0 10px 0;
      font-weight: 700;
      letter-spacing: 1px;
      text-align: center;
    }
    h3 {
      color: #2563eb;
      margin: 0 0 20px 0;
      font-weight: 400;
      text-align: center;
    }
    .search-form {
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: stretch;
      margin-bottom: 24px;
      gap: 10px;
    }
    .search-form label {
      font-weight: 600;
      color: #3b82f6;
      margin-bottom: 2px;
      letter-spacing: 0.3px;
    }
    .search-form input[type="text"] {
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
    .search-form input[type="text"]:focus {
      border: 1.5px solid #3b82f6;
      box-shadow: 0 0 8px #b6d0f7;
      outline: none;
      background: #e0eafc;
    }
    .search-form input[type="submit"] {
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
    .search-form input[type="submit"]:hover {
      background: linear-gradient(90deg, #60a5fa 0%, #3b82f6 100%);
      transform: translateY(-2px) scale(1.03);
    }
    .groups-title {
      margin: 18px 0 8px 0;
      color: #3b82f6;
      font-weight: 600;
      font-size: 1.05rem;
      text-align: left;
      width: 100%;
    }
    .groups-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 8px;
      background: #f6fbff;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 1px 4px rgba(52, 152, 219, 0.05);
    }
    .groups-table th, .groups-table td {
      padding: 10px 12px;
      text-align: left;
    }
    .groups-table th {
      background: #e0eafc;
      color: #2563eb;
      font-weight: 600;
      border-bottom: 2px solid #b6d0f7;
    }
    .groups-table tr:nth-child(even) {
      background: #f0f6ff;
    }
    .groups-table tr:hover {
      background: #e0eafc;
      transition: background 0.2s;
    }
    .action-buttons {
      margin: 32px 0 0 0;
      display: flex;
      gap: 18px;
      justify-content: center;
    }
    /* Button load animation */
    @keyframes btn-load {
      0% { opacity: 0; transform: scale(0.8);}
      100% { opacity: 1; transform: scale(1);}
    }
    .action-btn {
      background: linear-gradient(90deg, #3b82f6 0%, #60a5fa 100%);
      color: white;
      padding: 13px 28px;
      border: none;
      border-radius: 12px;
      cursor: pointer;
      font-size: 1.08rem;
      font-weight: 700;
      letter-spacing: 0.8px;
      box-shadow: 0 2px 10px 0 rgba(52, 152, 219, 0.10);
      transition: background 0.3s, transform 0.2s;
      outline: none;
      position: relative;
      z-index: 1;
      overflow: hidden;
      opacity: 0;
      transform: scale(0.8);
      animation: btn-load 0.6s ease forwards;
      /* Delay for each button will be set inline */
    }
    .action-btn:nth-child(1) {
      animation-delay: 0.2s;
    }
    .action-btn:nth-child(2) {
      animation-delay: 0.4s;
    }
    .action-btn::after {
      content: '';
      position: absolute;
      left: 0; top: 0; right: 0; bottom: 0;
      background: rgba(96,165,250,0.12);
      opacity: 0;
      transition: opacity 0.2s;
      z-index: -1;
      border-radius: 12px;
    }
    .action-btn:hover::after {
      opacity: 1;
      animation: btn-bounce 0.4s;
    }
    .action-btn:hover {
      background: linear-gradient(90deg, #60a5fa 0%, #3b82f6 100%);
      transform: scale(1.05);
    }
    @keyframes btn-bounce {
      0% { transform: scale(1);}
      30% { transform: scale(1.13);}
      60% { transform: scale(0.97);}
      100% { transform: scale(1);}
    }
    @media (max-width: 540px) {
      .dashboard-card {
        min-width: 0;
        max-width: 98vw;
        padding: 20px 4vw 12px 4vw;
      }
      .logo {
        width: 50px;
        height: 50px;
      }
      .groups-table th, .groups-table td {
        padding: 7px 4px;
        font-size: 0.95rem;
      }
      .action-btn {
        padding: 11px 10vw;
        font-size: 1rem;
      }
      .action-buttons {
        flex-direction: column;
        gap: 10px;
      }
    }
  </style>
</head>
<body>
  <div class="dashboard-card">
    <img src="./logo.png" alt="Expense App Logo" class="logo">
    <h1>Dashboard</h1>
    <h3>Welcome <%= session.getAttribute("username") %></h3>
    <form class="search-form" action="expenses.jsp">
      <label for="search">Show Expenses for:</label>
      <input type="text" name="search" placeholder="Enter Group Name" required>
      <input type="submit" value="Search">
    </form>
    <div class="groups-title">All Groups You are in</div>
    <table class="groups-table">
      <tr>
        <th>Group Name</th>
        <th>User Name</th>
      </tr>
      <%
        String errorMsg = "";
        try {
          Connection con=ConnectionClass.getConnection();
          Statement so = con.createStatement();
          String username = (String) session.getAttribute("username");
          session.setMaxInactiveInterval(60*30);
          ResultSet rs = so.executeQuery("SELECT * FROM group_member WHERE user_name='" + username + "'");
          while(rs.next()){
      %>
      <tr>
        <td><%= rs.getString(2) %></td>
        <td><%= rs.getString(3) %></td>
      </tr>
      <%
          }
          rs.close();
          so.close();
          con.close();
        } catch (SQLException e) {
          errorMsg = "SQL Error: " + e.getMessage();
        }
      %>
    </table>
    <% if (!errorMsg.isEmpty()) { %>
      <div style="color: #d72660; margin-top: 10px;"><%= errorMsg %></div>
    <% } %>
  </div>
  <!-- Action Buttons Outside Main Card -->
  <div class="action-buttons">
<button class="action-btn" onclick="window.location.href='group.jsp'">Create Group "Equal Division"</button>
  <!--   <button class="action-btn" onclick="addUser()">Create Group split</button> -->
  </div>
  
</body>
</html>
