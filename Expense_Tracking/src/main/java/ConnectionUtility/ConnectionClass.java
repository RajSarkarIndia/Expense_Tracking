package ConnectionUtility;
import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionClass {
	public static Connection getConnection(){
		Connection con=null;
	try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/expensesapp", "root", "Raj@1234");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }catch(Exception e) {
	System.out.println("Database Connection Error"+e.getMessage());
	}
	return con;
}
}