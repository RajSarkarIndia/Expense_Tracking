import ConnectionUtility.ConnectionClass;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/groupdata")
public class groupdata extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String gn = request.getParameter("groupName");
        HttpSession session=request.getSession();
        session.setAttribute("group_name",gn);
        try {
        	Connection con = ConnectionClass.getConnection();
            Statement so = con.createStatement();
            String sql = "INSERT INTO `groups` (group_name) VALUES ('" + gn + "')";
            so.executeUpdate(sql);
            con.close();

            RequestDispatcher rd = request.getRequestDispatcher("NoOfPeople.html");
            rd.forward(request, response);

        } catch(Exception e) {
            e.printStackTrace(); 
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

