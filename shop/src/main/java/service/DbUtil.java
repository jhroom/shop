package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbUtil {
	
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/shop";
		String  id= "root";
		String pw = "1234";
		Connection conn = DriverManager.getConnection(url,id,pw);
		
		return conn;
	}

}
