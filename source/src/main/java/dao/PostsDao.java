package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import dto.PostsDto;
import utility.DBUtil;

public class PostsDao {

    // ユーザーIDで自分の投稿だけ取得
    public List<PostsDto> selectByUserId(int userId) {
        List<PostsDto> list = new ArrayList<>();
        String sql = "SELECT p.*, u.name AS user_name "
                + "FROM posts p "
                + "JOIN users u ON p.user_id = u.user_id "
                + "WHERE p.user_id = ? "
                + "ORDER BY p.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(convertRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 投稿をpost_id + user_idで削除
    public boolean deleteById(int postId, int userId) {
        String sql = "DELETE FROM posts WHERE post_id = ? AND user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 新規投稿（insert）
    public boolean insert(PostsDto dto) {
        String sql = "INSERT INTO posts (user_id, tag, title, content, created_at, pref, city) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, dto.getUserId());
            ps.setString(2, dto.getTag());
            ps.setString(3, dto.getTitle());
            ps.setString(4, dto.getContent());
            ps.setTimestamp(5, new Timestamp(dto.getCreatedAt().getTime()));
            ps.setString(6, dto.getPref());
            ps.setString(7, dto.getCity());
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 検索条件で取得（タグ・都道府県・市区町村などを使って）
    public List<PostsDto> select(PostsDto condition) {
        List<PostsDto> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.*, u.name AS user_name " +
                "FROM posts p " +
                "JOIN users u ON p.user_id = u.user_id " +
                "WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (condition.getTag() != null && !condition.getTag().isEmpty()) {
            sql.append(" AND tag LIKE ?");
            params.add("%" + condition.getTag() + "%");
        }
        if (condition.getPref() != null && !condition.getPref().isEmpty()) {
            sql.append(" AND pref = ?");
            params.add(condition.getPref());
        }
        if (condition.getCity() != null && !condition.getCity().isEmpty()) {
            sql.append(" AND city = ?");
            params.add(condition.getCity());
        }
        if (condition.getTitle() != null && !condition.getTitle().isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + condition.getTitle() + "%");
        }
        if (condition.getContent() != null && !condition.getContent().isEmpty()) {
            sql.append(" AND content LIKE ?");
            params.add("%" + condition.getContent() + "%");
        }

        sql.append(" ORDER BY created_at DESC");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(convertRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 1行のResultSetからDtoを作る（共通処理）
    private PostsDto convertRow(ResultSet rs) throws SQLException {
        PostsDto dto = new PostsDto();
        dto.setPostId(rs.getInt("post_id")); // ←ここを「id」→「post_id」に修正
        dto.setUserId(rs.getInt("user_id"));
        dto.setUserName(rs.getString("user_name"));
        dto.setTag(rs.getString("tag"));
        dto.setTitle(rs.getString("title"));
        dto.setContent(rs.getString("content"));
        dto.setCreatedAt(rs.getTimestamp("created_at"));
        dto.setPref(rs.getString("pref"));
        dto.setCity(rs.getString("city"));
        
        return dto;
    }
}
