
import jakarta.servlet.http.HttpServlet;
import ConnectionUtility.ConnectionClass;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;
import java.io.*;
@WebServlet("/register")
public class Register extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException {
        String username = request.getParameter("UserName");
        String password = request.getParameter("Password");
        String email = request.getParameter("email");
        try {
        	Connection con = ConnectionClass.getConnection();
            Statement so = con.createStatement();
            so.executeUpdate("INSERT INTO user(user_name, email, password) VALUES ('" + username + "', '" + email + "', '" + password + "')");
PrintWriter out=response.getWriter();
out.println("Registration SuccessFull");
out.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
