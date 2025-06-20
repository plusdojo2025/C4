package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
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
				MedicationsDto Medications = new MedicationsDto(rs.getInt("medication_id"), rs.getInt("user_id"),
						rs.getString("nickname"), rs.getString("formal_name"), rs.getString("dosage"),
						rs.getDate("created_at"), rs.getString("memo"), rs.getDate("intake_time"));
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
	
	
	//薬情報をユーザーIDで取得するメソッド
		public List<MedicationsDto> selectByUser(int userId) {
		    Connection conn = null;
		    List<MedicationsDto> list = new ArrayList<>();

		    try {
		        conn = conn();

		        String sql = "SELECT * FROM medications WHERE user_id = ? ORDER BY intake_time";
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ps.setInt(1, userId);

		        ResultSet rs = ps.executeQuery();

		        while (rs.next()) {
		            MedicationsDto dto = new MedicationsDto();
		            dto.setMedicationId(rs.getInt("medication_id"));
		            dto.setUserId(rs.getInt("user_id"));
		            dto.setNickName(rs.getString("nickname"));
		            dto.setFormalName(rs.getString("formal_name"));
		            dto.setDosage(rs.getString("dosage"));
		            dto.setIntakeTime(rs.getTime("intake_time")); // intake_time が TIME型 の場合
		            list.add(dto);
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		        return new ArrayList<>(); 
		    } finally {
		        close(conn);
		    }

		    return list;
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
					INSERT Medications(userId , nickname , formalName , dosage , createdAt , memo , intakeTime)
										VALEUS(       ?,                ?,                   ?,            ?,             ? ,          ?,                ?)
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			pStmt.setInt(1, dto.getUserId());
			pStmt.setString(2, dto.getNickname());
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
			pStmt.setString(2, dto.getNickname());
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

	private MedicationsDto mapRowToMedicationsDto(ResultSet rs) throws SQLException {
		MedicationsDto dto = new MedicationsDto();
		dto.setMedicationId(rs.getInt("medication_id"));
		dto.setUserId(rs.getInt("user_id"));
		dto.setNickName(rs.getString("nickname"));
		dto.setFormalName(rs.getString("formal_name"));
		dto.setDosage(rs.getString("dosage"));
		dto.setCreatedAt(rs.getTimestamp("created_at"));
		dto.setMemo(rs.getString("memo"));
		dto.setIntakeTime(rs.getTimestamp("intake_time"));
		return dto;
	}

	// MedicationsDao.java内
	public List<MedicationsDto> findByIntakeTime(Date intakeTime) {
		List<MedicationsDto> result = new ArrayList<>();
		try (Connection conn = conn()) {
			// intake_timeが「±数分以内」も許可したい場合はBETWEENで幅をもたせる
			String sql = "SELECT * FROM medications WHERE intake_time = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setTimestamp(1, new java.sql.Timestamp(intakeTime.getTime()));
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				result.add(mapRowToMedicationsDto(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	// mapRowToMedicationsDtoは各カラム→Dto変換ロジック

}
