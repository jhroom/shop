package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Customer;

public class CustomerDao {
	
	// 탈퇴
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
			//이제는 예외처리를해야한다 위에곳으로 던지고 jsp까지 던지면 rollback을 할 수가 없기때문에
	public int deleteCustomer(Customer paramCustomer, Connection conn) throws SQLException {
		int row = 0;
		String sql ="Delete From customer Where customer_id = ? And customer_pass = password(?)";
		PreparedStatement stmt = null;
		
		try {
			System.out.print("try delete");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCustomer.getCustomerId());
		stmt.setString(2, paramCustomer.getCustomerPass());
		row = stmt.executeUpdate();
		
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		//insertOutId 와 동일한 conn을 써야해서 colse못한다
		return row;
	}
	
	
				//CustomerService가 호출
	public Customer selectCustomerByIdAndPW(String id, String pw ,Connection conn) throws SQLException, ClassNotFoundException {
					//selectCustomerByIdAndPW
		Customer customer = new Customer();
		String sql = "Select customer_id, customer_name  From customer Where customer_id = ? And customer_pass = password(?)";
		PreparedStatement stmt = null;
		ResultSet rest = null;
		
		try {
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		rest = stmt.executeQuery();
		
			if(rest.next()) {
				System.out.println("select 성공");
				customer.setCustomerId(rest.getString("customer_id"));
				customer.setCustomerName(rest.getString("customer_name"));
			}
		
		} finally {
			if(rest != null) { rest.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return customer;
	}

}
