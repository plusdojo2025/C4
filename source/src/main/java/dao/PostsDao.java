package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.PostsDto;

public class PostsDao extends CustomTemplateDao<PostsDto>{


	@Override
	public List<PostsDto> select(PostsDto dto) {
		Connection connection = null;
		List<PostsDto> postsList = new ArrayList<PostsDto>();

		try {
			connection = conn();

			// SQL文を準備する
			String sql = "SELECT * FROM posts INNER JOIN users ON posts.user_id = users.user_id WHERE prefecture LIKE ? AND city LIKE ?";
			PreparedStatement pStmt = connection.prepareStatement(sql);

			// SQL文を完成させる
			String prefecture = null; 
			String city = null;
			pStmt.setInt(1, dto.getPostId());
	        pStmt.setString(2, prefecture == null ? "%" : prefecture + "%");
	        pStmt.setString(3, city == null ? "%" : city + "%");


			// SQL文を実行し、結果表を取得する
			// ResultSetはJDBC特有のなにか
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				PostsDto posts = new PostsDto(
						rs.getInt("user_id"), 
						rs.getString("tag"), 
						rs.getString("title"), 
						rs.getString("content"), 
						rs.getDate("created_at"));
				postsList.add(posts);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			postsList = null;
		} finally {
			// データベースを切断
			close(connection);
		}

		// 結果を返す
		return postsList;
	}

	@Override
	public boolean update(PostsDto dto) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}

	@Override
	public boolean delete(PostsDto dto) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
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
					INSERT INTO posts (userId, tag, title, content, createdAT) VALUES (?, ?, ?, ?, ?)
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getUserId());
			pStmt.setString(2, dto.getTag());
			pStmt.setString(3, dto.getTitle());
			pStmt.setString(4, dto.getContent());
			pStmt.setDate(5, new java.sql.Date(dto.getCreatedAT().getTime()));
		

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
    
	
	//マイ投稿の検索
    public List<PostsDto> selectByUserId(int userId) throws SQLException {
		Connection connection = null;

        List<PostsDto> postsList = new ArrayList<>();
        
        try {
        
			// データベースに接続する
        	connection = conn();
			
			//SQL文を用意する
	        String sql = "SELECT * FROM posts WHERE userId = ? ORDER BY createdAT DESC";
			PreparedStatement stmt = connection.prepareStatement(sql);
			

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                postsList.add(new PostsDto(
                    rs.getInt("user_id"),
                    rs.getString("tag"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getDate("createdAT")
                ));
            }
        } finally {
			// データベースを切断
			close(connection);
		}

        return postsList;
    }

}