package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.GoodsImg;

public class GoodsImgDao {
	
	public int insertGoodsImg(GoodsImg goodsImg, Connection conn) throws SQLException {
		int row = 0;
		String sql ="Insert Into goods_img (filename, origin_filename, content_type, create_date, goods_no)"
				+ " Values (?, ?, ?, NOW(), ? )";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goodsImg.getFileName());
			stmt.setString(2, goodsImg.getOriginFileName());
			stmt.setString(3, goodsImg.getContentType());
			stmt.setInt(4, goodsImg.getGoodsImgNo());
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	public int updateGoodsImg(GoodsImg goodsImg, Connection conn) throws SQLException {
		int row = 0;
		String sql ="UPDATE goods_img SET filename=? ,origin_filename=? ,content_type=?"
				+ ",create_date=NOW() WHERE goods_no = ?";
		
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goodsImg.getFileName());
			stmt.setString(2, goodsImg.getOriginFileName());
			stmt.setString(3, goodsImg.getContentType());
			stmt.setInt(4, goodsImg.getGoodsImgNo());
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}

}
