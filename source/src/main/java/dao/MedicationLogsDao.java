package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import dto.MedicationLogsDto;

public class MedicationLogsDao extends CustomTemplateDao<MedicationLogsDto> {

	@Override
	public List<MedicationLogsDto> select(MedicationLogsDto dto) {
		Connection conn = null;
		List<MedicationLogsDto> userList = new ArrayList<MedicationLogsDto>();

		try {
			conn = conn();
			
			// SQL文を準備する
			String sql = "SELECT * FROM users WHERE log_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1,  dto.getLogId() );
			
			
			// SQL文を実行し、結果表を取得する
			//ResultSetはJDBC特有のなにか
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				MedicationLogsDto bc = new MedicationLogsDto(
						rs.getInt("log_id"), 
						rs.getInt("medication_id"), 
						rs.getInt("user_id"),
						rs.getDate("taken_time"),
						rs.getString("memo")
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
	public boolean insert(MedicationLogsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
					INSERT medication_logs(taken_time , memo)
							VALEUS( ?,  ? )
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setTimestamp(1, new Timestamp(dto.getTakenTime().getTime()));
			pStmt.setString(2, dto.getMemo());
		

			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				ResultSet res = pStmt.getGeneratedKeys();
				res.next();
				dto.setMedicationId(res.getInt(1));			
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
	public boolean update(MedicationLogsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
					UPDATE users
					SET taken_time =?, memo =?
					WHERE log_id = ?
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setTimestamp(1, new Timestamp(dto.getTakenTime().getTime()));
			pStmt.setString(2, dto.getMemo());
			pStmt.setInt(3, dto.getLogId());

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
	public boolean delete(MedicationLogsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = "DELETE FROM users WHERE log_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getLogId());

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
