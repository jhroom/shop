package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.OrdersDao;

public class OrdersService {
	private OrdersDao ordersDao;
	
	//관리자용 고객한명의 주문리스트 개수 카운트
	public int selectCountOrderListByCustomer(String customerId) {
		int count = 0;
		Connection conn = null;
		
		try {
			conn = new DbUtil().getConnection();
			this.ordersDao = new OrdersDao();
			count = ordersDao.selectCountOrderListByCustomer(customerId, conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		return count;
	}
	//관리자용 고객한명의 주문리스트
	public List<Map<String,Object>> getCustomerOrderList(String customerId, int currentPage, int rowPerPage){
		List<Map<String,Object>> list = new ArrayList<>();
		Connection conn = null;
		int beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DbUtil().getConnection();
			this.ordersDao = new OrdersDao();
			list = ordersDao.selectOrdersListByCustomer(customerId, beginRow, rowPerPage, conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return list;
	}

}
