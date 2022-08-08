package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	private EmployeeDao employeeDao;
	
	public int lastPage() {
		int lastPage = 0;
		Connection conn = null;
		
		try {
			conn = new DbUtil().getConnection();
			this.employeeDao = new EmployeeDao();
			// employee테이블 총 수
			lastPage = employeeDao.selectTotalEmployee(conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return lastPage;
	}
	
	public boolean modifyEmployeeActive(String id, String active) {
		int row = 0;
		Connection conn = null;
		
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			this.employeeDao = new EmployeeDao();
			// employee 테이블 id로 active 권한 변경 메서드
			row = employeeDao.updateEmployeeActive(id, active, conn);
			
			if (row != 1) {
				throw new Exception();
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return true;
	}
	
	public ArrayList<Employee> getEmployeeList(int currentPage, int rowPerPage) {
		ArrayList<Employee> list = new ArrayList<>();
		Connection conn = null;
		int beginRow = 0;
		beginRow = ((currentPage-1) * rowPerPage);
		
		try {
			conn = new DbUtil().getConnection();
			this.employeeDao = new EmployeeDao();
			//beginRow 부터 rowPerPage 까지의 employee 정보를 리스트에 담는 메서드
			list  = employeeDao.selectEmployeeList(beginRow,rowPerPage,conn);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public boolean addEmployee(Employee employee) {
		boolean result = false;
		Connection conn = null;
		
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			this.employeeDao = new EmployeeDao();
			if(employeeDao.insertEmployee(employee, conn) == 1) {
				result = true;
				conn.commit();
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return result;
	}
	
	public Employee getEmployee(String id, String pw) {
		Employee temp = null;
		Connection conn = null;
		try {
		conn = new DbUtil().getConnection();
		conn.setAutoCommit(false);
		
		temp = new EmployeeDao().selectEmployeeByIdAndPw(id, pw, conn);
		
		} catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return temp;
	}
	
	public boolean signOutEmployee(Employee paramEmployee)  { //Customer paramCus
		boolean temp = false;
		Connection conn = null;
		
		try {
		conn = new DbUtil().getConnection();
		conn.setAutoCommit(false);
		
		EmployeeDao employeeDao = new EmployeeDao();
		int customerRow = employeeDao.deleteEmployee(paramEmployee, conn);
		
		OutIdDao outIdDao = new OutIdDao();
		int outRow = outIdDao.insertOutId(paramEmployee.getEmployeeId(), conn);
		
		if(customerRow + outRow ==2) {
			conn.commit();
			temp = true;
		} else {
			conn.rollback();
		}
		
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return temp;
		//서비스에서 디버깅을 다한샘이다 액션에서 또 확인 할 필요는 없다  void boolean
	}// end method

}
