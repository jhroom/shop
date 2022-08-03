package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Customer;

public class CustomerDao {
	
	public Customer login(String id, String pw) throws SQLException, ClassNotFoundException {
		Customer customer = new Customer();
		String sql = "Select * From customer Where customer_id = ? And customer_pass = password(?)";
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
				customer.setCustomerId(rest.getString("customer_id"));
				customer.setCustomerName(rest.getString("customer_name"));
			}
		
		} finally {
			stmt.close();
			conn.close();
		}
		
		return customer;
	}

}
