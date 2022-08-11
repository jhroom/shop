package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.SignDao;

public class SignService {
	
	private SignDao signDao; 

	/*
	 * public boolean idCheckService(String id) { boolean result = false;
	 * this.signDao = new SignDao(); //의존객체 밥먹을 때의 손? 메서드안에 지역 변수로 있을 지 동등한 메서드의
	 * 위치(멤버변수)에 있는게 좋을지 고민 Connection conn = null;
	 * 
	 * try { conn = new DbUtil().getConnection();
	 * 
	 * if(signDao.idCheck(id, conn) == null) { result = true; conn.commit(); }
	 * 
	 * } catch (Exception e) {
	 * 
	 * e.printStackTrace(); try { conn.rollback(); } catch (SQLException e1) {
	 * e1.printStackTrace(); }
	 * 
	 * } finally {
	 * 
	 * if(conn != null) { try { conn.close(); } catch (SQLException e) {
	 * e.printStackTrace(); } } }
	 * 
	 * return result; }// end method
	 */	
	public String  idCkService(String idCk) {
		
		String id = null;
		this.signDao = new SignDao(); //의존객체 밥먹을 때의 손?  메서드안에 지역 변수로 있을 지 동등한 메서드의 위치(멤버변수)에 있는게 좋을지 고민
		Connection conn = null;
		
		try {
			conn = new DbUtil().getConnection();
			
			id = signDao.idCheck(idCk, conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			
			if(conn != null) {
				try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
			}
		}
		
		return id;
	}// end method

}
