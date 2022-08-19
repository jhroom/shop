package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CartDao;

public class CartService {
	private CartDao cartDao;
	
	public List<Map<String,Object>> getCartById(String customerId){
		List<Map<String,Object>> list = new ArrayList<>();
		Connection conn = null;
		this.cartDao = new CartDao();
		
		try {
			conn = new DbUtil().getConnection();
			list = cartDao.selectCartById(customerId, conn);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return list;
	}

}
