package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class OutIdDao {
	// 회원탈퇴의 아이디입력
	public int insertOutId(String customerId, Connection conn) throws SQLException {
		//deleteCustomer 와 동일한 conn을 써야해서 colse
		int row = 0;
		String sql = "Insert Into outid (out_id, out_date) Values (? , now() )";
		PreparedStatement stmt = null;
		
		try {
			System.out.print(" try insert");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerId);
		row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}

}
