package service;

import java.sql.Connection;
import java.sql.SQLException;
import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	private EmployeeDao employeeDao;
	
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
