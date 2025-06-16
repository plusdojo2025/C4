package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.BrainTrainingResultsDto;

public class BrainTrainingResultsDao extends CustomTemplateDao<BrainTrainingResultsDto> {

	@Override
	public List< BrainTrainingResultsDto> select(BrainTrainingResultsDto dto) {
		Connection conn = null;
		List< BrainTrainingResultsDto> userList = new ArrayList< BrainTrainingResultsDto>();

		try {
			conn = conn();
			
			// SQL文を準備する
			String sql = "SELECT * FROM users WHERE result_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1,  dto.getResult_id() );
			
			
			// SQL文を実行し、結果表を取得する
			//ResultSetはJDBC特有のなにか
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				BrainTrainingResultsDto bc = new  BrainTrainingResultsDto(
						rs.getInt("result_id"), 
						rs.getInt("user_id;"), 
						rs.getInt("score"), 
						rs.getString("game_type"), 
						rs.getDate("played_at")
						);										
				userList.add(bc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			userList = null;
		} finally {
			// データベースを切断
			close(conn);
		}

		// 結果を返す
		return userList;
	}

	@Override
	public boolean insert(BrainTrainingResultsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
					INSERT users(result_id , user_id , score , geme_type , played_at)
							VALEUS(       ?,                ?,       ?,     ?,         ? )
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getResult_id());
			pStmt.setInt(2, dto.getUser_id());
			pStmt.setInt(3, dto.getScore());
			pStmt.setString(4, dto.getGame_type());
			pStmt.setDate(5,new java.sql.Date (dto.getPlayed_at().getTime()));
		

			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				ResultSet res = pStmt.getGeneratedKeys();
				res.next();
				dto.setUser_id(res.getInt(1));			
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// データベースを切断
			close(conn);
		}

		// 結果を返す
		return result;
	}

	@Override
	public boolean update(BrainTrainingResultsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
					UPDATE users
					SET
					result_id = ?,  					
					user_id =?,
					score =?,
					game_type =?,  
					played_at =?
					WHERE user_id = ?
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getResult_id());
			pStmt.setInt(2, dto.getUser_id());
			pStmt.setInt(3, dto.getScore());
			pStmt.setString(4, dto.getGame_type());
			pStmt.setDate(5, new java.sql.Date (dto.getPlayed_at().getTime()));
			

			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// データベースを切断
			close(conn);
		}

		// 結果を返す
		return result;
	}

	@Override
	public boolean delete(BrainTrainingResultsDto dto){
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = "DELETE FROM users WHERE result_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getResult_id());

			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// データベースを切断
			close(conn);
		}

		// 結果を返す
		return result;
	}

	
}
