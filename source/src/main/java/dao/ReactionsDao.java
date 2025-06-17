package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.ReactionsDto;
import utility.ReactionType;

public class ReactionsDao extends CustomTemplateDao<ReactionsDto> {


	@Override
	public List<ReactionsDto> select(ReactionsDto dto) {
		Connection conn = null;
		List<ReactionsDto> userList = new ArrayList<ReactionsDto>();

		try {
			conn = conn();
			
			// SQL文を準備する
			String sql = "SELECT * FROM users WHERE reaction_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1,  dto.getReactionId() );
			
			
			// SQL文を実行し、結果表を取得する
			//ResultSetはJDBC特有のなにか
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
			    ReactionsDto bc = new ReactionsDto(
			        rs.getInt("reaction_id"),
			        rs.getInt("post_id"),
			        rs.getInt("user_id"),
			        ReactionType.valueOf(rs.getString("reaction_type")), 
			        rs.getTimestamp("reacted_at")
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
	public boolean insert(ReactionsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
					INSERT reactions(reaction_type)
							VALEUS ( ?)
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, ((Enum<ReactionType>) dto.getType()).name());


			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				ResultSet res = pStmt.getGeneratedKeys();
				res.next();
				//dto.setMedicationId(res.getInt(1));			
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
	public boolean update(ReactionsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
					UPDATE reactions
					SET reaction_type = ?
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, ((Enum<ReactionType>) dto.getType()).name());

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
	public boolean delete(ReactionsDto dto) {
		Connection conn = null;
		boolean result = false;
		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = "DELETE FROM reactions WHERE reaction_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, ((Enum<ReactionType>) dto.getType()).name());

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
