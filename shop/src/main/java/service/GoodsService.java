package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.GoodsDao;
import repository.GoodsImgDao;
import vo.Goods;
import vo.GoodsImg;

public class GoodsService {
	private GoodsDao goodsDao;	//IGoodsDao dao를 인터페이스를 구현했다면 직접연결하지않고 인터페이스를 멤버로 둬 더 유연한 관계로 유지보수가 쉬울거다
	private GoodsImgDao goodsImgDao;
	// 트랜잭션 + action이나 dao가 해서는 안되는 일
	
	
	public void addGoods(Goods goods, GoodsImg goodsImg) {
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		this.goodsImgDao = new GoodsImgDao();
		
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			//굿즈에서 받아온 primary key 값
			int goodsNo = goodsDao.insertGoods(goods, conn);
			
			if(goodsNo != 0	) {
				goodsImg.setGoodsImgNo(goodsNo);
				if(goodsImgDao.insertGoodsImg(goodsImg,conn)==0) {
					throw new Exception();
				}
			}
			conn.commit();
			
		} catch(Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
	}
	
	public Map<String, Object> getGoodsAndImg(int goodsNo){
		Map<String, Object> goodsAndImg = null;
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		
		try {
			conn = new DbUtil().getConnection();
			goodsAndImg = goodsDao.selectGoodsAndImgOne(goodsNo, conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return goodsAndImg;
	}
	
	public int lastPage() {
		int lastPage = 0;
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		
		try {
			conn = new DbUtil().getConnection();
			lastPage = goodsDao.selectCountGoods(conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return lastPage;
	}
	
	public boolean modifyGoods(Goods goods) {
		boolean result = false;
		int row = 0;
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			row = goodsDao.updateGoods(goods, conn);
			if( row != 1) {
				throw new Exception();
			}
			conn.commit();
			result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
		}
		return result;
	}
	
	public boolean addGoods(Goods goods) {
		boolean result = false;
		int row = 0;
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			row = goodsDao.insertGoods(goods, conn);
			
			if(row !=1) {
				throw new Exception();
			}
			conn.commit(); result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		return result;
	}
	
	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) {
		
		List<Goods> list = new ArrayList<>();
		this.goodsDao = new GoodsDao();
		Connection conn = null;
		int beginRow = 0;
		beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DbUtil().getConnection();
			list = goodsDao.selectGoodsListByPage(beginRow, rowPerPage, conn);
		
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return list; 
	}
	
}