<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ConnectionUtility.ConnectionClass" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add Expense</title>
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
      animation: fadeIn 1s cubic-bezier(.42,0,.58,1);
      margin-top: 40px;
    }

    @keyframes fadeIn {
      from {opacity: 0; transform: translateY(40px);}
      to {opacity: 1; transform: translateY(0);}
    }

    h1 {
      color: #3b82f6;
      font-size: 2rem;
      font-weight: 700;
      margin-bottom: 10px;
      text-align: center;
    }

    h3 {
      color: #2563eb;
      margin: 0 0 20px 0;
      font-weight: 400;
      text-align: center;
    }

    .search-form {
      display: flex;
      flex-direction: column;
      gap: 14px;
      width: 100%;
    }

    .search-form label {
      font-weight: 600;
      color: #3b82f6;
      margin-bottom: 2px;
    }

    .search-form input[type="text"],
    .search-form input[type="date"] {
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

    .search-form input:focus {
      border: 1.5px solid #3b82f6;
      box-shadow: 0 0 8px #b6d0f7;
      outline: none;
      background: #e0eafc;
    }

    .search-form input[type="submit"] {
      background: linear-gradient(90deg, #3b82f6 0%, #60a5fa 100%);
      color: white;
      padding: 12px;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      font-size: 1.08rem;
      font-weight: 700;
      letter-spacing: 0.8px;
      box-shadow: 0 2px 10px 0 rgba(52, 152, 219, 0.10);
      transition: background 0.3s, transform 0.2s;
    }

    .search-form input[type="submit"]:hover {
      background: linear-gradient(90deg, #60a5fa 0%, #3b82f6 100%);
      transform: translateY(-2px) scale(1.03);
    }

    @media (max-width: 540px) {
      .dashboard-card {
        min-width: 0;
        max-width: 98vw;
        padding: 20px 4vw 12px 4vw;
      }
    }
  </style>
</head>

<body>
  <div class="dashboard-card">
    <h1>Add Expense</h1>
    <h3>For Group: <%= session.getAttribute("group_name") %></h3>

    <form class="search-form" action="addintoexp" method="post">
      <label for="Amount">Amount</label>
      <input type="text" name="Amount" id="Amount" placeholder="Enter Amount" required>

      <label for="Description">Description</label>
      <input type="text" name="Description" id="Description" placeholder="Enter Description" required>

      <label for="Date">Date</label>
      <input type="date" name="Date" id="Date" required>

      <input type="submit" value="Submit">
    </form>
  </div>
</body>
</html>
