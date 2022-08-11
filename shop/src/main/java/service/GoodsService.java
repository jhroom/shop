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
	
	//고객용 상품리스트
	public List<Map<String,Object>> getCustomerGoodsList(int currentPage, int rowPerPage){
		List<Map<String,Object>> list = null;
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		int beginRow = (currentPage-1)*rowPerPage;
		
		try {
			conn = new DbUtil().getConnection();
			list = goodsDao.customerGoodsListByPage(beginRow, rowPerPage, conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		
		return list;
	}
	
	public boolean addGoods(Goods goods, GoodsImg goodsImg) {
		boolean result = false;
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
			result = true;
			
		} catch(Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
			
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
		return result;
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
	
	public boolean modifyGoods(Goods goods, GoodsImg goodsImg) {
		boolean result = false;
		int row = 0;
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		this.goodsImgDao = new GoodsImgDao();
		
		try {
			conn = new DbUtil().getConnection();
			conn.setAutoCommit(false);
			goodsImg.setGoodsImgNo(goods.getGoodsNo()); //action에서 굿즈에저장한 No를 이미지에도셋팅
			
			//굿즈 와 굿즈이미지 업데이트 둘다 성공한다면
			row = goodsDao.updateGoods(goods, conn) + goodsImgDao.updateGoodsImg(goodsImg, conn);
			if( row == 2) {
				conn.commit();
				result = true;
			} else {
				throw new Exception();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			try { conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
		} finally {
			try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
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
