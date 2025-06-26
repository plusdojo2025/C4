package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import dto.MedicationLogsDto;

public class MedicationLogsDao extends CustomTemplateDao<MedicationLogsDto> {

	@Override
	public List<MedicationLogsDto> select(MedicationLogsDto dto) {
		Connection conn = null;
		List<MedicationLogsDto> mlogList = new ArrayList<MedicationLogsDto>();

		try {
			conn = conn();
			
			// SQL文を準備する

			String sql = "SELECT M.nickname , M.formal_name , M.dosage , L.log_id , L.medication_id, L.user_id , L.taken_time , L.taken_med , L.memo "
					+ "FROM medication_logs AS L INNER JOIN medications AS M "
					+ "ON L.medication_id = M.medication_id  WHERE L.user_id = ? ORDER BY L.taken_time DESC";

			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1,  dto.getUserId() );
			
			
			// SQL文を実行し、結果表を取得する
			//ResultSetはJDBC特有のなにか
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				MedicationLogsDto mlog = new MedicationLogsDto(
						rs.getInt("log_id"), 
						rs.getInt("medication_id"), 
						rs.getInt("user_id"),
						rs.getDate("taken_time"),
						rs.getString("taken_med"),
						rs.getString("memo"),
						rs.getString("nickname"),
						rs.getString("formal_name"),
						rs.getString("dosage")
				);										
				mlogList.add(mlog);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			mlogList = null;
		} finally {
			// データベースを切断
			close(conn);
		}

		// 結果を返す
		return mlogList;
	}

	
	
	//その日一日のみのユーザーの薬一覧を取得する。服薬登録で使う。
	public List<MedicationLogsDto> selectByDate(MedicationLogsDto dto) {
		Connection conn = null;
	    List<MedicationLogsDto> list = new ArrayList<MedicationLogsDto>();
	    
	    	try {	
		    // JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();
			
			// SQL文を準備する
				String sql = "SELECT * FROM medication_logs WHERE user_id = ? AND DATE(taken_time) = ? "
	               + "ORDER BY taken_time DESC";

	        PreparedStatement pStmt = conn.prepareStatement(sql);
	        
	     // SQL文を完成させる
	     // DTOのDate型 takenTime → SQL用 Date型に変換
	        java.util.Date takenDate = dto.getTakenTime();
	        java.sql.Date sqlDate = new java.sql.Date(takenDate.getTime());

	        pStmt.setInt(1, dto.getUserId());
	        pStmt.setDate(2, sqlDate);

	        
			// SQL文を実行し、結果表を取得する
			//ResultSetはJDBC特有のなにか
			ResultSet rs = pStmt.executeQuery();
			
			
	        while (rs.next()) {
	            MedicationLogsDto log = new MedicationLogsDto();
	            dto.setLogId(rs.getInt("log_id"));
	            dto.setUserId(rs.getInt("user_id"));
	            dto.setMedicationId(rs.getInt("medication_id"));
	            dto.setTakenTime(rs.getTimestamp("taken_time"));
	            dto.setTakenMed(rs.getString("taken_med"));
	            dto.setMemo(rs.getString("memo"));

	            list.add(dto);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	
	//服薬登録一覧で月ごとの表示の時に使う
	public List<MedicationLogsDto> selectByMonth(int userId, int year, int month) {
	    Connection conn = null;
	    List<MedicationLogsDto> list = new ArrayList<>();
	    try {
	        conn = conn();
	        String sql = """ 
	        		      SELECT L.*, M.nickname, M.formal_name, M.dosage FROM medication_logs AS L JOIN medications M 
                           ON L.medication_id = M.medication_id
	                     WHERE L.user_id = ? AND YEAR(L.taken_time) = ? AND MONTH(L.taken_time) = ? 
	                     ORDER BY L.taken_time DESC
	                     """;
	        PreparedStatement pStmt = conn.prepareStatement(sql);
	        pStmt.setInt(1, userId);
	        pStmt.setInt(2, year);
	        pStmt.setInt(3, month);
	        ResultSet rs = pStmt.executeQuery();

	        while (rs.next()) {
	            MedicationLogsDto dto = new MedicationLogsDto(
	                rs.getInt("log_id"),
	                rs.getInt("medication_id"),
	                rs.getInt("user_id"),
	                rs.getTimestamp("taken_time"),
	                rs.getString("taken_med"),
	                rs.getString("memo"),
	                rs.getString("nickname"),
	                rs.getString("formal_name"),
	                rs.getString("dosage")
	            );
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        list = null;
	    } finally {
	        close(conn);
	    }
	    return list;
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
					INSERT INTO medication_logs(user_id , medication_id , taken_time , taken_med , memo)
						VALUES( ?,  ? , ?,  ?,  ? )
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getUserId());
			pStmt.setInt(2, dto.getMedicationId());
			pStmt.setTimestamp(3, new Timestamp(dto.getTakenTime().getTime()));
			//setTimestamp(3, dto.getTakenTime());
			pStmt.setString(4, dto.getTakenMed());
			pStmt.setString(5, dto.getMemo());
		

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
					UPDATE medication_logs
					SET taken_time =?, taken_med = ? ,memo =?
					WHERE log_id = ? AND user_id = ?
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setTimestamp(1, new Timestamp(dto.getTakenTime().getTime()));
			pStmt.setString(2, dto.getTakenMed());
			pStmt.setString(3, dto.getMemo());
			pStmt.setInt(4, dto.getLogId());
			pStmt.setInt(5, dto.getUserId());
			
			
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
			String sql = "DELETE FROM medication_logs WHERE log_id=?";
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

	 /* 指定ユーザー・薬ID・日付・時間帯（intake_time）で服薬記録が既に存在するか判定*/
	public boolean existsLogByMedicationAndTime(int userId, int medicationId, java.sql.Date date, java.sql.Time intakeTime) {
	    Connection conn = null;
	    boolean exists = false;
	    try {
	        conn = conn();
	        String sql = """
	            SELECT COUNT(*) 
	            FROM medication_logs L
	            INNER JOIN medications M ON L.medication_id = M.medication_id
	            WHERE L.user_id = ? AND L.medication_id = ? 
	              AND DATE(L.taken_time) = ? 
	              AND M.intake_time = ?
	        """;
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, userId);
	        ps.setInt(2, medicationId);
	        ps.setDate(3, date);
	        ps.setTime(4, intakeTime);

	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) exists = rs.getInt(1) > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close(conn);
	    }
	    return exists;
	}
}
