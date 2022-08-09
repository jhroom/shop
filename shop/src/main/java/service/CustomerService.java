package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import repository.CustomerDao;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {		//loginAciton.jsp가 호출 
	private CustomerDao customerDao;
	
	public boolean modifyCustomerPass(Customer customer) {
		boolean result = false;
		int row = 0;
		Connection conn = null;
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			this.customerDao = new CustomerDao();
			row = customerDao.updateCustomerPass(customer, conn);
			
			if( row == 0) {
				throw new Exception();
			}
			conn.commit();
			result= true;
			
		} catch (Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		return result;
	}
	
	public List<Customer> getCustomerList(int currentPage, int rowPerPage){
		List<Customer> list = new ArrayList<>();
		Connection conn = null;
		int beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DbUtil().getConnection();
			this.customerDao = new CustomerDao();
			list = customerDao.selectCustomerListByPage(beginRow, rowPerPage, conn);
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
		return list;
	}
	
	public boolean addCustomer(Customer customer) {
		boolean result = false; 
		Connection conn = null;
		
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			this.customerDao = new CustomerDao();
			
			if(customerDao.insertCustomer(customer, conn) == 1) {
				result = true;
				conn.commit();
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return result;
	}
		
	public Customer getCustomer(Customer customer) {
		Connection conn = null;
		Customer temp = null;
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			
			this.customerDao = new CustomerDao();
			temp = customerDao.selectCustomerByIdAndPW(customer.getCustomerId(), customer.getCustomerPass(), conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return temp;
	}
	
	public boolean signOutCustomer(Customer paramCustomer)  {
		boolean temp = false;
		Connection conn = null;
		
		try {
		conn = new DbUtil().getConnection();
		conn.setAutoCommit(false);
		
		this.customerDao = new CustomerDao();
		int customerRow = customerDao.deleteCustomer(paramCustomer, conn);
		
		OutIdDao outIdDao = new OutIdDao();
		int outRow = outIdDao.insertOutId(paramCustomer.getCustomerId(), conn);
		
		if(customerRow + outRow ==2) {
			conn.commit();
			temp = true;
		} else {
			conn.rollback();
			//throw new Exception();
		}
		
		} catch (Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		return temp;
		//서비스에서 디버깅을 다한샘이다 액션에서 또 확인 할 필요는 없다  void boolean
	}
	
	//액션에서 확인받은 customerId로 계정삭제 및 outId에 추가
	public boolean removeCustomerOut(String customerId) {
		boolean result = false;
		Connection conn = null;
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			
			this.customerDao = new CustomerDao();
			int customerRow = customerDao.deleteCustomerOut(customerId, conn);
			
			OutIdDao outIdDao = new OutIdDao();
			int outRow = outIdDao.insertOutId(customerId, conn);
			
			if(customerRow + outRow != 2) {
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
	

}
