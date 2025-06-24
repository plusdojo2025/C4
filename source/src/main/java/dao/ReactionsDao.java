package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// DB接続ユーティリティ
import utility.DBUtil;

public class ReactionsDao {

	// 1. 投稿に「いいね」追加
	public void addReaction(int postId, int userId) {
		String sql = "INSERT INTO reactions (post_id, user_id, type) VALUES (?, ?, 'いいね')";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, postId);
			ps.setInt(2, userId);
			ps.executeUpdate();
		} catch (SQLException e) {
			// 重複INSERT等を無視したい場合（例: UNIQUE(post_id, user_id)ならOK）
			if (e.getErrorCode() != 1062) { // 1062 = Duplicate entry
				e.printStackTrace();
			}
		}
	}

	// 2. 投稿の「いいね」を解除
	public void removeReaction(int postId, int userId) {
		String sql = "DELETE FROM reactions WHERE post_id=? AND user_id=?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, postId);
			ps.setInt(2, userId);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 3. 指定投稿の「いいね」数を取得
	public int getLikeCountByPostId(int postId) {
		String sql = "SELECT COUNT(*) FROM reactions WHERE post_id=? AND type='いいね'";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, postId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	// 4. 指定投稿を「いいね」しているユーザー名一覧（ニックネーム/氏名）
	public List<String> getLikedUserNames(int postId) {
		List<String> names = new ArrayList<>();
		String sql = "SELECT u.name FROM reactions r JOIN users u ON r.user_id=u.user_id WHERE r.post_id=? AND r.type='いいね'";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, postId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					names.add(rs.getString("name"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return names;
	}

	// 5. 指定投稿を指定ユーザーが「いいね」済みか（booleanで返す）
	public boolean isUserLiked(int postId, int userId) {
		String sql = "SELECT COUNT(*) FROM reactions WHERE post_id=? AND user_id=? AND type='いいね'";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, postId);
			ps.setInt(2, userId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1) > 0;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}
