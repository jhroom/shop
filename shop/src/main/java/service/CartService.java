package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CartDao;
import vo.Cart;

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
	
	public boolean addCart(Cart cart) {
		boolean result = false;
		int temp = 0;
		Connection conn = null;
		this.cartDao = new CartDao();
		
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			
			//cart객체가 메서드 결과에 따라 1과0으로 반환
			temp = cartDao.insertCart(cart, conn);
			
			if(temp != 1) { //카트객체가 DB에 insert 하는게 실패한다면
				throw new Exception();
			}
			conn.commit();
			result = true;
			
		}catch (Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
		}
		
		return result;
	}

}
