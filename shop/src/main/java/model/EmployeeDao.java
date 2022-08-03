package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Employee;

public class EmployeeDao {
	
	public Employee login(String id ,String pw) throws SQLException, ClassNotFoundException {
		Employee emp = new Employee();
		String sql = "Select * From employee Where employee_id = ? And employee_pass = password(?) And active = 'Y'";
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rest = null;
		
		try {
		DbUtil db = new DbUtil();
		conn = db.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		rest = stmt.executeQuery();
		
			if(rest.next()) {
				emp.setEmployeeId(rest.getString("employee_id"));
				emp.setEmployeeName(rest.getString("employee_name"));
			}
		
		} finally {
			if(rest != null) { rest.close(); }
			if(stmt != null) { stmt.close(); }
			if(conn != null) { conn.close(); }
		}
		
		return emp;
	}

}
