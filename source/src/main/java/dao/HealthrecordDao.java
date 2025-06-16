package dao;

import java.util.List;

import dto.HealthrecordDto;

public class HealthrecordDao extends CustomTemplateDao<HealthrecordDto> {

	@Override
	public List<HealthrecordDto> select(HealthrecordDto dto) {
//		Connection conn = null;
//		List<HealthrecordDto> userList = new ArrayList<HealthrecordDto>();
//
//		try {
//			conn = conn();
//			
//			// SQL文を準備する
//			String sql = "SELECT * FROM users WHERE user_id = ?";
//			PreparedStatement pStmt = conn.prepareStatement(sql);
//
//			// SQL文を完成させる
//			pStmt.setInt(1,  dto.getUserId() );
//			
//			
//			// SQL文を実行し、結果表を取得する
//			//ResultSetはJDBC特有のなにか
//			ResultSet rs = pStmt.executeQuery();
//
//			// 結果表をコレクションにコピーする
//			while (rs.next()) {
//				HealthrecordDto bc = new HealthrecordDto(
//						rs.getInt("recordId"), 
//						rs.getInt("userId"), 
//						rs.getDate("date"), 
//						rs.getBigDecimal("temperature"), 
//						rs.getBigDecimal("highBp"), 
//						rs.getString("pluseRate"), 
//						rs.getBigDecimal("pulseOx"), 
//						rs.getString("sleep"), 
//						rs.getString("memo")
//				);										
//				userList.add(bc);
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//			userList = null;
//		} finally {
//			// データベースを切断
//			close(conn);
//		}
//
		// 結果を返す
		return null;
	}

	@Override
	public boolean insert(HealthrecordDto dto) {
//		Connection conn = null;
//		boolean result = false;
//
//		try {
//			// JDBCドライバを読み込む
//			// データベースに接続する
//			conn = conn();
//
//			// SQL文を準備する
//			String sql = """
//					INSERT users(date , temperature, highBp , lowBp , pluseRate,pulseOx,sleep,memo)
//							VALEUS(       ?,                ?,       ?,     ?,         ? )
//					""";
//			PreparedStatement pStmt = conn.prepareStatement(sql);
//
//			// SQL文を完成させる
//			pStmt.setDate(1, dto.getDate());
//			pStmt.setBigDecimal(2, dto.getTemperature());
//			pStmt.setBigDecimal(3, dto.getHighBp());
//			pStmt.setBigDecimal(4, dto.getLowBp());
//			pStmt.setString(5, dto.getPluseRate());
//			pStmt.setBigDecimal(6, dto.getPulseOx());
//			pStmt.setString(7, dto.getSleep());
//			pStmt.setString(8, dto.getMemo());
//		
//
//			// SQL文を実行する
//			if (pStmt.executeUpdate() == 1) {
//				ResultSet res = pStmt.getGeneratedKeys();
//				res.next();
//				dto.setHealthrecordId(res.getInt(1));			
//				result = true;
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			// データベースを切断
//			close(conn);
//		}
//
//		// 結果を返す
		return false;
	}


	@Override
	public boolean update(HealthrecordDto dto) {
//		Connection conn = null;
//		boolean result = false;
//
//		try {
//			// JDBCドライバを読み込む
//			// データベースに接続する
//			conn = conn();
//
//			// SQL文を準備する
//			String sql = """
//					UPDATE users
//					SET
//  date = ?
//,  temperature=?
//, highBp =?
//,  lowBp =?
//,  pluseRate =?
//,  pulseOx =?
//,  sleep =?
//,  memo=?
//
//					WHERE Healthrecord_id = ?
//					""";
//			PreparedStatement pStmt = conn.prepareStatement(sql);
//
//			// SQL文を完成させる
//			pStmt.setDate(1, new java.sql.Date(dto.getHealthrecord().getTime()));
//			pStmt.setBigDecimal(2, dto.getTemperature());
//			pStmt.setBigDecimal(3, dto.getHighBp());
//			pStmt.setBigDecimal(4, dto.getLowBp());
//			pStmt.setString(5, dto.getPluseRate());
//			pStmt.setBigDecimal(6, dto.getPulseOx());
//			pStmt.setString(7, dto.getSleep());
//			pStmt.setString(8, dto.getMemo());
//
//			// SQL文を実行する
//			if (pStmt.executeUpdate() == 1) {
//				result = true;
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			// データベースを切断
//			close(conn);
//		}
//
//		// 結果を返す
		return false;
	}


	@Override
	public boolean delete(HealthrecordDto dto){
//		Connection conn = null;
//		boolean result = false;
//
//		try {
//			// JDBCドライバを読み込む
//			// データベースに接続する
//			conn = conn();
//
//			// SQL文を準備する
//			String sql = "DELETE FROM users WHERE user_id=?";
//			PreparedStatement pStmt = conn.prepareStatement(sql);
//
//			// SQL文を完成させる
//			pStmt.setInt(1, dto.getHealthrecordId());
//
//			// SQL文を実行する
//			if (pStmt.executeUpdate() == 1) {
//				result = true;
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			// データベースを切断
//			close(conn);
//		}
//
		// 結果を返す
		return false;
	}
}


