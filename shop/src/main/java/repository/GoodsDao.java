package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Goods;

public class GoodsDao {
	
	
	
	public Map<String,Object> selectGoodsAndImgOne(int goodsNO, Connection conn) throws SQLException {
		Map<String,Object> map = null;
		String sql ="SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice,"
				+ " g.update_date updateDate, g.create_date createDate, g.sold_out soldOut,"
				+ " gi.filename fileName, gi.origin_filename originFileName, gi.content_type contentType, gi.create_date imgCreateDate"
				+ " FROM goods g INNER JOIN goods_img gi "
				+ " USING(goods_no) WHERE goods_no = ? ";
		PreparedStatement stmt = null;
		ResultSet rest = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNO);
			System.out.print("stmt : " + stmt);
			rest = stmt.executeQuery();
			if(rest.next()) {
				map = new HashMap<>();
				map.put("goodsNo", rest.getString("goodsNo"));
				map.put("goodsName", rest.getString("goodsName"));
				map.put("goodsPrice", rest.getString("goodsPrice"));
				map.put("updateDate", rest.getString("updateDate"));
				map.put("createDate", rest.getString("createDate"));
				map.put("soldOut", rest.getString("soldOut"));
				map.put("fileName", rest.getString("fileName"));
				map.put("originFileName", rest.getString("originFileName"));
				map.put("contentType", rest.getString("contentType"));
				map.put("imgCreateDate", rest.getString("imgCreateDate"));
			}
		} finally {
			if(rest != null) { rest.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return map;
	}
	
	public int selectCountGoods(Connection conn) throws SQLException {
		int lastPage = 0;
		String sql = "SELECT count(*) count FROM goods";
		PreparedStatement stmt = null;
		ResultSet rest = null;
		try {
			stmt = conn.prepareStatement(sql);
			rest = stmt.executeQuery();
			if(rest.next()) {
				lastPage = rest.getInt("count");
				System.out.println("lastP : " + lastPage);
			}
		} finally {
			if(rest != null) { rest.close(); }
			if(stmt != null) { stmt.close(); }
		}
		return lastPage;
	}
	
	public int updateGoods(Goods goods, Connection conn) throws SQLException {
		int row = 0;
		String sql = "UPDATE goods SET goods_name=?, goods_price=?, update_date=NOW(), sold_out=? WHERE goods_no=?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goods.getGoodsName());
			stmt.setInt(2, goods.getGoodsPrice());
			stmt.setString(3, goods.getSoldOut());
			stmt.setInt(4, goods.getGoodsNo());
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		return row;
	}
	
	public int insertGoods(Goods goods,Connection conn) throws SQLException {
		int keyId = 0;
		String sql = "INSERT INTO goods (goods_name,goods_price,update_date,create_date,sold_out)"
				+ " Values ( ? , ? ,now(), now(), ? )";
		PreparedStatement stmt = null;
		ResultSet rest = null;
		
		try {
			stmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, goods.getGoodsName());
			stmt.setInt(2, goods.getGoodsPrice());
			stmt.setString(3, goods.getSoldOut());
			stmt.executeUpdate();
			rest = stmt.getGeneratedKeys();
			
			if(rest.next()) {
				keyId = rest.getInt(1);
			}
				
		} finally {
			if(rest != null) {rest.close(); }
			if(stmt != null) { stmt.close(); }
		}
		return keyId;
	}
	
	public List<Goods> selectGoodsListByPage(int beginRow, final int rowPerPage, Connection conn) throws SQLException{
		 List<Goods> list = new ArrayList<>();
		String sql = "SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, "
				+ "update_date updateDate, create_date createDate, sold_out soldOut "
				+ "FROM goods ORDER BY goodsNo ASC LIMIT ?,?";
		
		PreparedStatement stmt = null;
		ResultSet rest = null;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rest = stmt.executeQuery();
		while(rest.next()) {
			Goods goods = new Goods();
			goods.setGoodsNo(rest.getInt("goodsNo"));
			goods.setGoodsName(rest.getString("goodsName"));
			goods.setGoodsPrice(rest.getInt("goodsPrice"));
			goods.setUpdateDate(rest.getString("updateDate"));
			goods.setCreateDate(rest.getString("createDate"));
			goods.setSoldOut(rest.getString("soldOut"));
			list.add(goods);
		}
			
		return list;
	}

}
