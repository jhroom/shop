package repository;

import java.sql.*;

public class CounterDao {
	
	//오늘 접속자가 있는지 보는 메서드
   public String selectCounterToday(Connection conn) throws SQLException {
      String result = null;
      String sql = "SELECT counter_date date FROM counter WHERE counter_date = CURDATE()";
      PreparedStatement stmt = null;
      ResultSet rest = null;
      try {
    	  stmt = conn.prepareStatement(sql);
    	  rest = stmt.executeQuery();
    	  if(rest.next()) {
    		  result = rest.getString("date");
    	  }
      } finally {
    	  if(rest != null) {rest.close();}
		  if(stmt != null) {stmt.close();}
      }
      return result;   
   }
   
   //오늘 날자 접속자가 없다면 실행하는 메서드
   public int insertCounter(Connection conn) throws SQLException {
	   
	   int result = 0;
	   String sql ="INSERT INTO counter(counter_date,counter_num) VALUES(CURDATE(),1)";
	   PreparedStatement stmt = null;
	   try {
	    	  stmt = conn.prepareStatement(sql);
	    	  result = stmt.executeUpdate();
	      } finally {
			  if(stmt != null) {stmt.close();}
	      }
	   return result;
   }
   
   //오늘 날자 접속자가 있었다면 실행하는 메서드
   public int updateCounter(Connection conn) throws SQLException {
	   int result = 0;
	   String sql ="UPDATE counter SET counter_num = counter_num+1 WHERE counter_date = CURDATE()";
	   PreparedStatement stmt = null;
	   try {
	    	  stmt = conn.prepareStatement(sql);
	    	  result = stmt.executeUpdate();
	   	  } finally {
			  if(stmt != null) {stmt.close();}
	      }
	   return result;
   }
   
   // IndexController에서 호출
   // 전체접속자 수
   public int selectTotalCount(Connection conn) throws SQLException {
	   int result = 0;
	   String sql ="SELECT SUM(counter_num) sum FROM counter";
	   PreparedStatement stmt = null;
	   ResultSet rest = null;
	   try {
	    	  stmt = conn.prepareStatement(sql);
	    	  rest = stmt.executeQuery();
	    	  if(rest.next()) {
	    		  result = rest.getInt("sum");
	    	  }
	    	  
	   	  } finally {
			  if(stmt != null) {stmt.close();}
	      }
	   return result;
	}
   
   // 오늘 접속자 수
   public int selectTodayCount(Connection conn) throws SQLException {
	   int result = 0;
	      String sql = "SELECT counter_num num FROM counter WHERE counter_date = CURDATE()";
	      PreparedStatement stmt = null;
	      ResultSet rest = null;
	      try {
	    	  stmt = conn.prepareStatement(sql);
	    	  rest = stmt.executeQuery();
	    	  if(rest.next()) {
	    		  result = rest.getInt("num");
	    	  }
	      } finally {
	    	  if(rest != null) {rest.close();}
			  if(stmt != null) {stmt.close();}
	      }
	      return result; 
	}
}