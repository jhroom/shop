package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import vo.Employee;

public class EmployeeDao {
	
	public int deleteEmployee(Employee paramEmployee, Connection conn) throws SQLException {
		int row = 0;
		String sql ="Delete From employee Where employee_id = ? And employee_pass = password(?)";
		PreparedStatement stmt = null;
		
		try {
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramEmployee.getEmployeeId());
		stmt.setString(2, paramEmployee.getEmployeePass());
		row = stmt.executeUpdate();
		
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		//insertOutId 와 동일한 conn을 써야해서 colse못한다
		return row;
	}
	
	public Employee selectEmployeeByIdAndPw(String id ,String pw,Connection conn) throws SQLException, ClassNotFoundException {
		Employee emp = new Employee();
		String sql = "Select employee_id, employee_name From employee Where employee_id = ? And employee_pass = password(?) And active = 'Y'";
		
		PreparedStatement stmt = null;
		ResultSet rest = null;
		
		try {
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
		}
		
		return emp;
	}

}
