package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.Employee;

public class EmployeeDao {
	
	public int selectTotalEmployee(Connection conn) throws SQLException {
		int total = 0;
		String sql = "Select count(*) count From employee";
		PreparedStatement stmt = null;
		ResultSet rest = null;
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println("stmt --- " + stmt);
			rest = stmt.executeQuery();
			if(rest.next()) {
				total = rest.getInt(1);
			}
		}finally {
			if(rest != null) { rest.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return total;
	}
	
	public int updateEmployeeActive(String id, String active, Connection conn) throws SQLException {
		int row = 0;
		String sql = "Update employee Set active=? WHERE employee_id = ?";
		PreparedStatement stmt = null;
		
		try {
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, active);
		stmt.setString(2, id);
		row = stmt.executeUpdate();
		} finally {
			stmt.close();
		}
		
		return row;
	}
	
	public ArrayList<Employee> selectEmployeeList(int beginRow, int rowPerPage, Connection conn) throws SQLException {
		ArrayList<Employee> list = new ArrayList<>();
		String sql = "Select * From employee Order By employee_id ASC Limit ?,?";
		PreparedStatement stmt = null;
		ResultSet rest = null;
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rest = stmt.executeQuery();
		while(rest.next()) {
			Employee emp = new Employee();
			emp.setEmployeeId(rest.getString("employee_id"));
			emp.setEmployeeName(rest.getString("employee_name"));
			emp.setCreateDate(rest.getString("create_date"));
			emp.setUpdateDate(rest.getString("update_date"));
			emp.setActive(rest.getString("active"));
			list.add(emp);
		}
		
		return list;
	}
	
	public int insertEmployee(Employee employee, Connection conn) throws SQLException {
		int row = 0;
		String sql = "Insert Into employee (employee_id, employee_pass, employee_name, update_date, create_date)"
				+ " Values (?, password(?), ?, now(), now() )";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			stmt.setString(3, employee.getEmployeeName());
			row = stmt.executeUpdate();
		
		} finally {
			stmt.close();
		}
		
		return row;
	}
	
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
