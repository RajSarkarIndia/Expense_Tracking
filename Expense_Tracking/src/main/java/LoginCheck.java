import ConnectionUtility.ConnectionClass;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;
import java.io.*;
@WebServlet("/logincheck")
public class LoginCheck extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException {
        String username = request.getParameter("UserName");
        String password = request.getParameter("Password");
        try {
           
        	Connection con = ConnectionClass.getConnection();

            Statement so = con.createStatement();
          
            ResultSet rs = so.executeQuery("select * from user where user_name='" + username + "'");
            while (rs.next()) {
                if (password.equals(rs.getString(4))) { 
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    response.sendRedirect("home.jsp");
                    return; 
                } else {
                    PrintWriter out = response.getWriter();
                    out.print("Wrong username or password");
                    out.close();
                    return;
                }
            }
            
            rs.close();
            so.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
