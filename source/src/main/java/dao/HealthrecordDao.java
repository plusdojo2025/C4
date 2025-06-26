package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import dto.HealthrecordDto;

public class HealthrecordDao extends CustomTemplateDao<HealthrecordDto> {

	public boolean existsSameRecord(int userId, Date date) {
		Connection conn = null;
		boolean exists = false;
		try {
			conn = conn();
			String sql = "SELECT COUNT(*) FROM health_records WHERE user_id = ? AND date = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, userId);
			pStmt.setDate(2, date);

			ResultSet rs = pStmt.executeQuery();
			if (rs.next()) {
				exists = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(conn);
		}
		return exists;
	}

	/**
	 * 健康記録を検索する dto.getUserId()がセットされていれば、そのユーザーの記録のみ取得
	 */
	@Override
	public List<HealthrecordDto> select(HealthrecordDto dto) {
		Connection conn = null;
		List<HealthrecordDto> recordList = new ArrayList<>();

		try {
			conn = conn();

			// SQLの組み立て（ユーザーIDで絞り込み可）
			StringBuilder sql = new StringBuilder("SELECT * FROM health_records WHERE 1=1");
			if (dto.getUserId() != 0) {
				sql.append(" AND user_id = ?");
			}
			sql.append(" ORDER BY date DESC"); // 日付の降順

			PreparedStatement pStmt = conn.prepareStatement(sql.toString());
			int paramIndex = 1;
			if (dto.getUserId() != 0) {
				pStmt.setInt(paramIndex++, dto.getUserId());
			}

			ResultSet rs = pStmt.executeQuery();

			// 取得結果をリストに格納
			while (rs.next()) {
				HealthrecordDto rec = new HealthrecordDto(rs.getInt("record_id"), rs.getInt("user_id"),
						rs.getDate("date"), rs.getDouble("temperature"),
						rs.getObject("high_bp") != null ? rs.getDouble("high_bp") : null,
						rs.getObject("low_bp") != null ? rs.getDouble("low_bp") : null,
						rs.getObject("pulseRate") != null ? rs.getInt("pulseRate") : null,
						rs.getObject("pulseOx") != null ? rs.getDouble("pulseOx") : null, rs.getInt("sleep"),
						rs.getString("memo"));
				recordList.add(rec);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			recordList = null; // エラー時はnull返却
		} finally {
			// コネクションをクローズ
			close(conn);
		}

		return recordList;
	}

	/**
	 * 健康記録をDBに新規登録する
	 */
	@Override
	public boolean insert(HealthrecordDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			conn = conn();

			// health_recordsテーブルへINSERT
			String sql = """
					    INSERT INTO health_records
					    (user_id, date, temperature, high_bp, low_bp, pulseRate, pulseOx, sleep, memo)
					    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
					""";

			// 自動採番されたID取得のためRETURN_GENERATED_KEYSを指定
			PreparedStatement pStmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

			pStmt.setInt(1, dto.getUserId());
			pStmt.setDate(2, dto.getDate());
			pStmt.setDouble(3, dto.getTemperature());
			// null許容カラムはnullの場合setNullを使う
			if (dto.getHighBp() != null)
				pStmt.setDouble(4, dto.getHighBp());
			else
				pStmt.setNull(4, Types.DECIMAL);
			if (dto.getLowBp() != null)
				pStmt.setDouble(5, dto.getLowBp());
			else
				pStmt.setNull(5, Types.DECIMAL);
			if (dto.getPulseRate() != null)
				pStmt.setInt(6, dto.getPulseRate());
			else
				pStmt.setNull(6, Types.SMALLINT);
			if (dto.getPulseOx() != null)
				pStmt.setDouble(7, dto.getPulseOx());
			else
				pStmt.setNull(7, Types.DECIMAL);
			pStmt.setInt(8, dto.getSleep());
			pStmt.setString(9, dto.getMemo());

			// INSERTの実行
			if (pStmt.executeUpdate() == 1) {
				// 登録されたIDを取得しdtoへセット
				ResultSet res = pStmt.getGeneratedKeys();
				if (res.next()) {
					dto.setRecordId(res.getInt(1));
				}
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// コネクションをクローズ
			close(conn);
		}

		return result;
	}

	/**
	 * 健康記録を更新する
	 */
	@Override
	public boolean update(HealthrecordDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			conn = conn();

			// UPDATE文（record_idで1件特定）
			String sql = """
					    UPDATE health_records SET
					      user_id = ?
					    , date = ?
					    , temperature = ?
					    , high_bp = ?
					    , low_bp = ?
					    , pulseRate = ?
					    , pulseOx = ?
					    , sleep = ?
					    , memo = ?
					    WHERE record_id = ?
					""";

			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, dto.getUserId());
			pStmt.setDate(2, dto.getDate());
			pStmt.setDouble(3, dto.getTemperature());
			if (dto.getHighBp() != null)
				pStmt.setDouble(4, dto.getHighBp());
			else
				pStmt.setNull(4, Types.DECIMAL);
			if (dto.getLowBp() != null)
				pStmt.setDouble(5, dto.getLowBp());
			else
				pStmt.setNull(5, Types.DECIMAL);
			if (dto.getPulseRate() != null)
				pStmt.setInt(6, dto.getPulseRate());
			else
				pStmt.setNull(6, Types.SMALLINT);
			if (dto.getPulseOx() != null)
				pStmt.setDouble(7, dto.getPulseOx());
			else
				pStmt.setNull(7, Types.DECIMAL);
			pStmt.setInt(8, dto.getSleep());
			pStmt.setString(9, dto.getMemo());
			pStmt.setInt(10, dto.getRecordId());

			// 更新実行
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// コネクションをクローズ
			close(conn);
		}

		return result;
	}

	/**
	 * 健康記録を削除する
	 */
	@Override
	public boolean delete(HealthrecordDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			conn = conn();

			// 指定record_idのレコード削除
			String sql = "DELETE FROM health_records WHERE record_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, dto.getRecordId());

			// 削除実行
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// コネクションをクローズ
			close(conn);
		}

		return result;
	}
}
