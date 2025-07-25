import ConnectionUtility.ConnectionClass;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/addintoexp")
public class addintoexp extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String gn = (String) session.getAttribute("group_name");

        // Fetch and validate form parameters
        String amountStr = request.getParameter("Amount");
        String description = request.getParameter("Description");
        String dateextract = request.getParameter("Date");

        if (gn == null || amountStr == null || description == null || dateextract == null
                || amountStr.isEmpty() || description.isEmpty() || dateextract.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters.");
            return;
        }

        int amount = Integer.parseInt(amountStr);
        LocalDate date = LocalDate.parse(dateextract);

        Connection con = null;
        Statement userStmt = null;
        Statement countStmt = null;
        Statement insertStmt = null;
        ResultSet rs = null;
        ResultSet countRs = null;

        try {
        	con = ConnectionClass.getConnection();
            List<String> userList = new ArrayList<>();
            userStmt = con.createStatement();
            rs = userStmt.executeQuery("SELECT user_name FROM group_member WHERE group_name='" + gn + "'");
            while (rs.next()) {
                userList.add(rs.getString("user_name"));
            }
            rs.close();
            
            int memberCount = 0;
            countStmt = con.createStatement();
            countRs = countStmt.executeQuery("SELECT COUNT(*) FROM group_member WHERE group_name='" + gn + "'");
            if (countRs.next()) {
                memberCount = countRs.getInt(1);
            }
            countRs.close();

            if (memberCount == 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No group members found.");
                return;
            }
            int shareAmount = amount / memberCount;

            // Step 3: Insert expense row for each user
            insertStmt = con.createStatement();
            for (String user : userList) {
                String insertQuery = "INSERT INTO expenses (group_name, user_name, amount, description, date) " +
                        "VALUES ('" + gn + "', '" + user + "', " + shareAmount + ", '" + description + "', '" + date + "')";
                insertStmt.executeUpdate(insertQuery);
            }

            // Optional: Success response
            response.setContentType("text/plain");
            response.getWriter().write("Expense added for all group members.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        } finally {
            // Clean up JDBC resources
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (countRs != null) countRs.close(); } catch (Exception e) {}
            try { if (userStmt != null) userStmt.close(); } catch (Exception e) {}
            try { if (countStmt != null) countStmt.close(); } catch (Exception e) {}
            try { if (insertStmt != null) insertStmt.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
