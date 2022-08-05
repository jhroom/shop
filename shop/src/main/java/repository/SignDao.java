package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignDao {
	
	public String idCheck(String id, Connection conn) throws SQLException {
		String ckeckId = null;
		String sql ="Select t.id FROM"
				+ "(Select customer_id id From customer"
				+ " UNION"
				+ " Select employee_id id From employee"
				+ " UNION"
				+ " Select out_id id From outid) t "
				+ " Where t.id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rest = stmt.executeQuery();
		
		if(rest.next()) {
			ckeckId = rest.getString("id");
		}
		
		return ckeckId;
	}

}
