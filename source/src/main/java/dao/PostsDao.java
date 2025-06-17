package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.PostsDto;

public class PostsDao {

    private Connection conn;

    public PostsDao(Connection conn) {
        this.conn = conn;
    }

    public List<PostsDto> select(String prefecture, String city) throws SQLException {
        List<PostsDto> postsList = new ArrayList<>();
        String sql = "SELECT * FROM posts WHERE prefecture LIKE ? AND city LIKE ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, prefecture == null ? "%" : prefecture + "%");
            stmt.setString(2, city == null ? "%" : city + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                postsList.add(new PostsDto(
                   
                    rs.getInt("userId"),
                    rs.getString("tag"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getDate("createdAT")
                ));
            }
        }
        return postsList;
    }

    public boolean insert(PostsDto post) throws SQLException {
        String sql = "INSERT INTO posts (userId, tag, title, content, createdAT) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, post.getUserId());
            stmt.setString(2, post.getTag());
            stmt.setString(3, post.getTitle());
            stmt.setString(4, post.getContent());
            stmt.setDate(5, new java.sql.Date(post.getCreatedAT().getTime()));
            if (stmt.executeUpdate() == 1) {
                ResultSet keys = stmt.getGeneratedKeys();
                if (keys.next()) {
                    post.setPostId(keys.getInt(1));
                }
                return true;
            }
        }
        return false;
    }
}
