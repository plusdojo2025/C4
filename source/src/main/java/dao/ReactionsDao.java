package dao;

import java.util.List;

import dto.ReactionsDto;

public class ReactionsDao extends CustomTemplateDao<ReactionsDto> {

	@Override
	public List<ReactionsDto> select(ReactionsDto dto) {
//		Connection conn = null;
//		List<ReactionsDto> userList = new ArrayList<ReactionsDto>();
//
//		try {
//			conn = conn();
//			
//			// SQL文を準備する
//			String sql = "SELECT * FROM users WHERE reaction_id = ?";
//			PreparedStatement pStmt = conn.prepareStatement(sql);
//
//			// SQL文を完成させる
//			pStmt.setInt(1,  dto.getReactionId() );
//			
//			
//			// SQL文を実行し、結果表を取得する
//			//ResultSetはJDBC特有のなにか
//			ResultSet rs = pStmt.executeQuery();
//
//			// 結果表をコレクションにコピーする
//			while (rs.next()) {
//				ReactionsDto bc = new ReactionsDto(
//						rs.getInt("reaction_id"), 
//						rs.getInt("postId"), 
//						rs.getInt("userId"), 
//						rs.getReactionType("type"), 
//						rs.getDate("created_at")
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
	public boolean insert(ReactionsDto dto) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}

	@Override
	public boolean update(ReactionsDto dto) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}

	@Override
	public boolean delete(ReactionsDto dto) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}

}
