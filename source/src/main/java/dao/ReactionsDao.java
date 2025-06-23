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
		List<ReactionsDto> reactionList = new ArrayList<ReactionsDto>();

		try {
			conn = conn();
			
			// SQL文を準備する
			String sql = "SELECT * FROM reactions INNER JOIN users ON "
					+ "reactions.user_id = users.user_id WHERE post_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1,  dto.getPostId() );
			
			
			// SQL文を実行し、結果表を取得する
			//ResultSetはJDBC特有のなにか
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
			    ReactionsDto bc = new ReactionsDto(
			        rs.getInt("reaction_id"),
			        rs.getInt("post_id"),
			        rs.getInt("user_id"),
			        rs.getString("name"),
			        ReactionType.valueOf(rs.getString("type")), 
			        rs.getDate("reacted_at")
				);										
			    reactionList.add(bc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			reactionList = null;
		} finally {
			// データベースを切断
			close(conn);
		}

		// 結果を返す
		return reactionList;
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
					INSERT INTO reactions(type)
							VALUES  ( ?)
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
					SET type = ?
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
			pStmt.setInt(1, dto.getReactionId());

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

	//リアクションをして人を出すメソッド
	public List<ReactionsDto> findUsersByPostId(int postId) throws SQLException {
		Connection conn = null;
		
		List<ReactionsDto> userList = new ArrayList<>();
		try {
			// データベースに接続する
		conn = conn();
		
		// SQL文を準備する
	    
	    String sql = "SELECT users.user_id, users.name FROM reactions INNER JOIN users "
	    		+ "ON reactions.user_id = users.user_id WHERE reactions.postId = ?";
	    
	    // SQL文を完成させる
	    PreparedStatement pStmt = conn.prepareStatement(sql);
	    
	        pStmt.setInt(1, postId);
	        ResultSet rs = pStmt.executeQuery();
	        while (rs.next()) {
	        	ReactionsDto user = new ReactionsDto();
	            user.setUserId(rs.getInt("user_id"));
	            user.setName(rs.getString("name"));
	            userList.add(user);
	        }
		}
	    catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	       close(conn);
	    }
	    return userList;
	}

	//いいね数を出す
	public int getLikeCountByPostId(int postId) throws SQLException {
		Connection conn = null;
		
	    int count = 0;
	    String sql = "SELECT COUNT(*) FROM reactions WHERE post_id = ? AND type = 'いいね'";
	    
	    try {
	    	conn = conn();
	         PreparedStatement stmt = conn.prepareStatement(sql); 
	        
	        stmt.setInt(1, postId);
	        ResultSet rs = stmt.executeQuery();
	        
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
	    }finally {
		       close(conn);
		    }
	    return count;
	}
	
	//いいねの登録
	public void addReaction(int postId, int userId, String type) {
		Connection conn = null;
		
		PreparedStatement stmt;
		try {
			// データベースに接続する
			conn = conn();
			
			// SQL文を準備する
	        String sql = "INSERT INTO reactions (post_id, user_id, type, created_at) VALUES (?, ?, ?, NOW())";
	        
	        // SQL文を完成させる
	        stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, postId);
	        stmt.setInt(2, userId);
	        stmt.setString(3, type);
	        stmt.executeUpdate();
	
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	    	close(conn);
	    }
	}
}
