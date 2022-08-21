package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.OrdersDao;
import vo.Orders;

public class OrdersService {
	private OrdersDao ordersDao;
	
	public boolean addOrder(Orders order) {		//오더 성공하면 카트에 담긴거 삭제 트랜잭션 구현해야함
		boolean result = false;
		Connection conn = null;
		int temp = 0;
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			this.ordersDao = new OrdersDao();
			temp = ordersDao.insertOrders(order, conn);
			if(temp != 1) {
				throw new Exception();
			}
			conn.commit();
			result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return result;
	}
	
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
