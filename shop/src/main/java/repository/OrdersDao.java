package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Orders;

public class OrdersDao {
	//주문 상세 보기
	public Map<String,Object> selectOrdersOne(int ordersNo, Connection conn) throws SQLException {
		Map<String, Object> map = null;
		String sql = "SELECT c.customer_id customerId ,c.customer_name customerName ,c.customer_address customerAdress\r\n"
				+ ",c.customer_telephone customerTel, g.goods_no goodsNo ,g.goods_name goodsName ,g.goods_price goodsPrice\r\n"
				+ ",g.sold_out soldOut, o.order_no orderNo ,o.order_quantity orderQuantity ,o.order_price orderPrice\r\n"
				+ ",o.order_state orderState ,o.order_adress orderAddress ,o.update_date orderUpdateDate, o.create_date orderCreateDate\r\n"
				+ "FROM ORDERs o INNER JOIN goods g\r\n"
				+ "USING(goods_no)\r\n"
				+ "INNER JOIN customer c\r\n"
				+ "USING(customer_id)\r\n"
				+ "WHERE goods_no = 1";
		PreparedStatement stmt = null;
		ResultSet rest = null;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		rest = stmt.executeQuery();
		if(rest.next()) {
			map = new HashMap<String, Object>();
			map.put("customerId", rest.getString("customerId"));
			map.put("customerName", rest.getString("customerName"));
			map.put("customerAdress", rest.getString("customerAdress"));
			map.put("customerTel", rest.getString("customerTel"));
			map.put("goodsNo", rest.getString("goodsNo"));
			map.put("goodsName", rest.getString("goodsName"));
			map.put("goodsPrice", rest.getString("goodsPrice"));
			map.put("soldOut", rest.getString("soldOut"));
			map.put("orderNo", rest.getString("orderNo"));
			map.put("orderQuantity", rest.getString("orderQuantity"));
			map.put("orderPrice", rest.getString("orderPrice"));
			map.put("orderState", rest.getString("orderState"));
			map.put("orderAddress", rest.getString("orderAddress"));
			map.put("orderUpdateDate", rest.getString("orderUpdateDate"));
			map.put("orderCreateDate", rest.getString("orderCreateDate"));
			
		}
		return map;
	}
	
	//전체 주문 목록(관리자) 5-1
	public List<Orders> selectOrdersList(int beginRow, int rowPerPage, Connection conn) {
		List<Orders> list = new ArrayList<>();
		/*
			SELECT
				o.order_no orderNo ,o.customer_id customerId ,g.goods_name goodsName
				, o.order_price orderPrice ,o.order_address orderAddress ,o.create_date createDate
			FROM orders o INNER JOIN goods g
			USING(goods_no)
			ORDER BY o.create_date DESC
			LIMIT ?,?
		*/
		
		return list;
	}
	//고객 한명의 주문 목록(관리자,고객) 2-1
	public List<Map<String,Object>> selectOrdersListByCustomer(String customerId, int beginRow, int rowPerPage, Connection conn) throws SQLException {
		List<Map<String,Object>>  list = new ArrayList<>();
		String sql = "SELECT\r\n"
				+ "			o.order_no orderNo, o.goods_no goodsNo, o.customer_id customerId, o.order_quantity orderQuantity\r\n"
				+ "			, o.order_price orderPrice, o.order_addr orderAddr, o.order_state orderState\r\n"
				+ "			, o.update_date updateDate, o.create_date createDate\r\n"
				+ "			, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut\r\n"
				+ "		FROM orders o INNER JOIN goods g\r\n"
				+ "		USING(goods_no)\r\n"
				+ "		WHERE customer_id = ?\r\n"
				+ "		ORDER BY o.create_date DESC\r\n"
				+ "		LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rest = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			rest = stmt.executeQuery();
			while(rest.next()) {
				Map<String,Object> map = new HashMap<>();
				map.put("orderNo", rest.getInt("orderNo"));
				map.put("goodsNo", rest.getInt("goodsNo"));
				map.put("orderQuantity", rest.getInt("orderQuantity"));
				map.put("orderPrice", rest.getInt("orderPrice"));
				map.put("orderAddr", rest.getString("orderAddr"));
				map.put("orderState", rest.getString("orderState"));
				map.put("updateDate", rest.getString("updateDate"));
				map.put("createDate", rest.getString("createDate"));
				map.put("goodsName", rest.getString("goodsName"));
				map.put("goodsPrice", rest.getInt("goodsPrice"));
				map.put("soldOut", rest.getString("soldOut"));
				list.add(map);
			}
			System.out.println(list.toString());
		} finally {
			if(rest != null) { rest.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}
	//고객Id에 따른 주문 개수
	public int selectCountOrderListByCustomer(String customerId, Connection conn) throws SQLException {
		int count = 0;
		String sql = "SELECT COUNT(*) count FROM orders WHERE customer_id = ?";
		PreparedStatement stmt = null;
		ResultSet rest = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			rest = stmt.executeQuery();
			if(rest.next()) {
				count = rest.getInt("count");
			}
		} finally {
			if(rest != null) { rest.close(); }
			if(stmt != null) { stmt.close(); }
		}
		return count;
	}

}
