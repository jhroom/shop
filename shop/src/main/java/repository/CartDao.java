package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Cart;
import vo.Orders;

public class CartDao {
	
	//insert Orders 하면 주문한 cart Delete
	public int deleteCartByOrders(Orders orders, Connection conn) throws SQLException {
		int result = 0;
		String sql = "DELETE FROM cart WHERE customer_id = ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, orders.getCustomerId());
			result = stmt.executeUpdate();
		} finally {
			if(stmt != null) {stmt.close();}
		}
		
		return result;
	}
	// 고객아이디에 의한 장바구니 리스트 조회하기
	public List<Map<String,Object>> selectCartById(String customerId, Connection conn) throws SQLException {
		List<Map<String,Object>> list = new ArrayList<>();
		Map<String,Object> map = null;
		String sql = "SELECT g.goods_no, g.goods_name, g.goods_price, c.cart_quantity, g.sold_out, gi.filename, cu.customer_address"
				+ " FROM cart c INNER JOIN goods g "
				+ " ON g.goods_no = c.goods_no INNER JOIN goods_img gi ON c.goods_no = gi.goods_no "
				+ " INNER JOIN customer cu ON c.customer_id = cu.customer_id"
				+ " WHERE c.customer_id = ?";
		PreparedStatement stmt = null;
		ResultSet rest = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			rest = stmt.executeQuery();
			//System.out.println(rest.getBoolean(0));
			while(rest.next()) {
				map = new HashMap<String,Object>();
				map.put("goodsNo", rest.getInt("goods_no"));
				map.put("goodsName", rest.getString("goods_name"));
				map.put("goodsPrice", rest.getInt("goods_price"));
				map.put("cartQuantity", rest.getInt("cart_quantity"));
				map.put("soldOut", rest.getString("sold_out"));
				map.put("fileName", rest.getString("filename"));
				map.put("address", rest.getString("customer_address"));
				list.add(map);
			}
		 /*
			 * else { map = new HashMap<String,Object>(); map.put("goodsNo", "");
			 * map.put("goodsName", ""); map.put("goodsPrice", 0); map.put("cartQuantity",
			 * 0); map.put("soldOut", ""); map.put("fileName", ""); map.put("address", "");
			 * list.add(map); }
			 */
		} finally {
			if(rest != null) {rest.close();}
			if(stmt != null) {stmt.close();}
		}
		return list;
	}
	
	public int insertCart(Cart cart, Connection conn) throws SQLException {
		int result = 0;
		String sql = "INSERT INTO cart (goods_no,customer_id,cart_quantity,update_date,create_date)"
				+ " VALUES (?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			stmt.setInt(3, cart.getCartQuantity());
			result = stmt.executeUpdate();
			
		} finally {
			if(stmt != null) {stmt.close();}
		}
		return result;
	}

}
