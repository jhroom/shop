package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CounterDao;

public class CounterService {
   private CounterDao counterDao;
   
   public void count() {
      counterDao = new CounterDao();
      Connection conn = null;
      int temp = 0;
      
      try {
    	  conn = new DbUtil().getConnection();
    	  conn.setAutoCommit(false);
    	  
	      if(counterDao.selectCounterToday(conn) == null) { // 오늘날짜 접속자가 있었는지
	    	  System.out.println("counter insert 하기");
	    	  int insert = counterDao.insertCounter(conn); System.out.println("insert rlt : "+insert);
	      }
	      else { 											// 오늘날짜의 카운터가 있으면 +1 업데이터
	    	  System.out.println("counter +1 하기");
	        temp = counterDao.updateCounter(conn);		System.out.println("update rlt : "+temp);
		        if(temp != 1) {
		        	throw new Exception();
		        }
	      }
	      conn.commit();
	      
      } catch (Exception e) {
    	  e.printStackTrace();
    	  try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
      } finally {
    	  try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
      }
      
   }
   
   public int getTotalCount() {
		counterDao = new CounterDao();
		Connection conn = null;
		int totalCount = 0;
		
		try {
			conn = new DbUtil().getConnection();
			totalCount = counterDao.selectTotalCount(conn);
			System.out.println("totalCount : " + totalCount);
			
		} catch (Exception e) {
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		return totalCount;
	}
   
   public int getTodayCount() {
		counterDao = new CounterDao();
		Connection conn = null;
		int todayCount = 0;
		
		try {
			conn = new DbUtil().getConnection();
			todayCount = counterDao.selectTodayCount(conn);
			System.out.println("todayCount : " + todayCount);
			
		} catch (Exception e) {
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		return todayCount;
	}
   
   
   // 2개 추가
}