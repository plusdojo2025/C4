package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.PostsDto;

public class PostsDao extends CustomTemplateDao<PostsDto> {

	@Override
	public List<PostsDto> select(PostsDto dto) {
		Connection conn = null;
		List<PostsDto> userList = new ArrayList<PostsDto>();

		try {
			conn = conn();
			
			// SQL文を準備する
						String sql = "SELECT * FROM posts WHERE post_id = ?";
						PreparedStatement pStmt = conn.prepareStatement(sql);

						// SQL文を完成させる
						pStmt.setInt(1,  dto.getPostId() );
						
						
						// SQL文を実行し、結果表を取得する
						//ResultSetはJDBC特有のなにか
						ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				PostsDto bc = new PostsDto(
						rs.getInt("postId"), 
						rs.getInt("userId"), 
						rs.getString("tag"), 
						rs.getString("title"), 
						rs.getString("content"), 
						rs.getDate("createdAT") 
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
	public boolean insert(PostsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
					INSERT posts(tag , title , content,createdAT)
							VALEUS(       ?,                ?,       ?,     ?,         ? )
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, dto.getTag());
			pStmt.setString(2, dto.getTitle());
			pStmt.setString(3, dto.getContent());
			pStmt.setDate(4, new java.sql.Date(dto.getCreatedAT().getTime()));
			
		

			// SQL文を実行する
						if (pStmt.executeUpdate() == 1) {
							ResultSet res = pStmt.getGeneratedKeys();
							res.next();
							dto.setPostId(res.getInt(1));			
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
	public boolean update(PostsDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
					UPDATE posts
					SET
  tag = ?
,  title =?
,  content=?
,  createdAT =?

					WHERE post_id = ?
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, dto.getTag());
			pStmt.setString(2, dto.getTitle());
			pStmt.setString(3, dto.getContent());
			pStmt.setDate(4, new java.sql.Date(dto.getCreatedAT().getTime()));
			
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
	public boolean delete(PostsDto dto){
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = "DELETE FROM users WHERE post_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getPostId());

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


	