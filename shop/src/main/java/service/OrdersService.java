package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import repository.CartDao;
import repository.OrdersDao;
import vo.Orders;

public class OrdersService {
	private OrdersDao ordersDao;
	
	//관리자용 고객 전체 오더 리스트
	
	public List<Map<String, Object>> getOrdersList(int currentPage, int rowPerPage){
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		int beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DbUtil().getConnection();
			this.ordersDao = new OrdersDao();
			list = ordersDao.selectOrdersList(beginRow , rowPerPage, conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		return list;
	}
	//관리자용  고객 전체 오더리스트 개수 구하기
	public int lastPage() {
		int lastPage = 0;
		Connection conn = null;
		this.ordersDao = new OrdersDao();
		
		try {
			conn = new DbUtil().getConnection();
			lastPage = ordersDao.selectCountOrders(conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return lastPage;
	}
	
	//cart에서 주문하는 order메서드
	public boolean addOrder(Orders order) {		//오더 성공하면 카트에 담긴거 삭제 트랜잭션 구현해야함
		boolean result = false;
		Connection conn = null;
		int temp = 0;
		
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			this.ordersDao = new OrdersDao();
			temp = ordersDao.insertOrders(order, conn);
			
			if(temp == 1) {
				System.out.println("orders 주문성공");
				CartDao cartDao = new CartDao();
				temp = cartDao.deleteCartByOrders(order, conn);
					if( temp != 1) {
						System.out.println("cart 삭제실패");
						throw new Exception();
					}
				System.out.println("cart 삭제성공");
				conn.commit();
				result = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return result;
	}
	
	//관리자용 고객한명의 주문리스트 개수 카운트
	public int getCountOrderListByCustomer(String customerId) {
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
