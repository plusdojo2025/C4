package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.BrainTrainingResultsDto;

public class BrainTrainingResultsDao extends CustomTemplateDao<BrainTrainingResultsDto> {

	/**
	 * 指定ユーザーの脳トレ履歴を取得します（orderByScore: true=昇順, false=降順）
	 */
	public List<BrainTrainingResultsDto> selectByUserId(int userId, boolean orderByScoreAsc) {
		Connection conn = null;
		List<BrainTrainingResultsDto> list = new ArrayList<>();
		try {
			conn = conn();
			// ソート条件
			String order = orderByScoreAsc ? "ASC" : "DESC";
			String sql = "SELECT * FROM brain_training_results WHERE user_id = ? ORDER BY score " + order
					+ ", played_at DESC";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, userId);
			ResultSet rs = pStmt.executeQuery();
			while (rs.next()) {
				BrainTrainingResultsDto dto = new BrainTrainingResultsDto(rs.getInt("result_id"), rs.getInt("user_id"),
						rs.getInt("score"), rs.getString("game_type"), rs.getTimestamp("played_at") // Timestamp → Date
																									// は自動変換可
				);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			list = null;
		} finally {
			close(conn);
		}
		return list;
	}

	@Override
	public List<BrainTrainingResultsDto> select(BrainTrainingResultsDto dto) {
		// 非推奨：用途が明確な selectByUserId を推奨
		return selectByUserId(dto.getUser_id(), false); // デフォルトは降順
	}

	@Override
	public boolean insert(BrainTrainingResultsDto dto) {
		Connection conn = null;
		boolean result = false;
		try {
			conn = conn();
			String sql = """
					    INSERT INTO brain_training_results (user_id, score, game_type, played_at)
					    VALUES (?, ?, ?, ?)
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
			pStmt.setInt(1, dto.getUser_id());
			pStmt.setInt(2, dto.getScore());
			pStmt.setString(3, dto.getGame_type());
			pStmt.setTimestamp(4, new java.sql.Timestamp(dto.getPlayed_at().getTime()));
			if (pStmt.executeUpdate() == 1) {
				ResultSet res = pStmt.getGeneratedKeys();
				if (res.next()) {
					dto.setResult_id(res.getInt(1));
				}
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(conn);
		}
		return result;
	}

	@Override
	public boolean update(BrainTrainingResultsDto dto) {
		Connection conn = null;
		boolean result = false;
		try {
			conn = conn();
			String sql = """
					    UPDATE brain_training_results
					    SET user_id = ?, score = ?, game_type = ?, played_at = ?
					    WHERE result_id = ?
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, dto.getUser_id());
			pStmt.setInt(2, dto.getScore());
			pStmt.setString(3, dto.getGame_type());
			pStmt.setTimestamp(4, new java.sql.Timestamp(dto.getPlayed_at().getTime()));
			pStmt.setInt(5, dto.getResult_id());
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(conn);
		}
		return result;
	}

	@Override
	public boolean delete(BrainTrainingResultsDto dto) {
		Connection conn = null;
		boolean result = false;
		try {
			conn = conn();
			String sql = "DELETE FROM brain_training_results WHERE result_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, dto.getResult_id());
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(conn);
		}
		return result;
	}
}
