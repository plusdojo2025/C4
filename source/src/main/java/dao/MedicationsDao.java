package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.MedicationsDto;

public class MedicationsDao extends CustomTemplateDao<MedicationsDto> {

	@Override
	public List<MedicationsDto> select(MedicationsDto dto) {
		Connection conn = null;
		List<MedicationsDto> medicationList = new ArrayList<MedicationsDto>();

		try {
			conn = conn();

			// SQL文を準備する
			String sql = "SELECT * FROM Medications WHERE Medication_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getMedicationId());

			// SQL文を実行し、結果表を取得する
			// ResultSetはJDBC特有のなにか
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				MedicationsDto Medications = new MedicationsDto(
						rs.getInt("medication_id"), 
						rs.getInt("user_id"),
						rs.getString("nickname"), 
						rs.getString("formal_name"), 
						rs.getString("dosage"),
						rs.getDate("created_at"), 
						rs.getString("memo"),
						rs.getDate("intake_time")
						);
				medicationList.add(Medications);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			medicationList = null;
		} finally {
			// データベースを切断
			close(conn);
		}

		// 結果を返す
		return medicationList;
	}

	@Override
	public boolean insert(MedicationsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
					INSERT Medications(userId , nickName , formalName , dosage , createdAt , memo , intakeTime)
										VALEUS(       ?,                ?,                   ?,            ?,             ? ,          ?,                ?)
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			pStmt.setInt(1, dto.getUserId());
			pStmt.setString(2, dto.getNickName());
			pStmt.setString(3, dto.getFormalName());
			pStmt.setString(4, dto.getDosage());
			pStmt.setDate(5, new java.sql.Date(dto.getCreatedAt().getTime()));
			pStmt.setString(6, dto.getMemo());
			pStmt.setDate(7, new java.sql.Date(dto.getIntakeTime().getTime()));
			pStmt.setInt(8, dto.getMedicationId());

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
	public boolean update(MedicationsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
										UPDATE Medications
										SET
					  user_id = ?
					,  nickname =?
					, formal_name =?
					,  dosage =?
					,  created_at =?
					,  memo =?
					,  created_at =?
					,  intake_time =?
										WHERE medication_id = ?
										""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getUserId());
			pStmt.setString(2, dto.getNickName());
			pStmt.setString(3, dto.getFormalName());
			pStmt.setString(4, dto.getDosage());
			pStmt.setDate(5, new java.sql.Date(dto.getCreatedAt().getTime()));
			pStmt.setString(6, dto.getMemo());
			pStmt.setDate(7, new java.sql.Date(dto.getIntakeTime().getTime()));
			pStmt.setInt(8, dto.getMedicationId());

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
	public boolean delete(MedicationsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = "DELETE FROM users WHERE medication_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getMedicationId());

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
