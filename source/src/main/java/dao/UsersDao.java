package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement; // ←★追加
import java.util.ArrayList;
import java.util.List;

import dto.UsersDto;

public class UsersDao extends CustomTemplateDao<UsersDto> {

	@Override
	public List<UsersDto> select(UsersDto dto) {
		Connection conn = null;
		List<UsersDto> userList = new ArrayList<UsersDto>();

		try {
			conn = conn();

			String sql = "SELECT * FROM users WHERE user_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, dto.getUserId());

			ResultSet rs = pStmt.executeQuery();
			while (rs.next()) {
				UsersDto users = new UsersDto(rs.getInt("user_id"), rs.getString("name"), rs.getInt("birth_date"),
						rs.getString("pref"), rs.getString("city"), rs.getString("email"), rs.getDate("created_at"));
				userList.add(users);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			userList = null;
		} finally {
			close(conn);
		}
		return userList;
	}

	@Override
	public boolean insert(UsersDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			conn = conn();

			String sql = """
					    INSERT INTO users(name, birth_date, pref, city, email)
					    VALUES (?, ?, ?, ?, ?)
					""";
			// ここで Statement.RETURN_GENERATED_KEYS を追加！
			PreparedStatement pStmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

			pStmt.setString(1, dto.getName());
			pStmt.setInt(2, dto.getBirthDate());
			pStmt.setString(3, dto.getPref());
			pStmt.setString(4, dto.getCity());
			pStmt.setString(5, dto.getEmail());

			if (pStmt.executeUpdate() == 1) {
				ResultSet res = pStmt.getGeneratedKeys();
				if (res.next()) {
					dto.setUserId(res.getInt(1));
				}
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(conn);
		}
		return result;
	}

	@Override
	public boolean update(UsersDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			conn = conn();

			String sql = """
					    UPDATE users SET
					        name = ?,
					        birth_date = ?,
					        pref = ?,
					        city = ?,
					        email = ?
					    WHERE user_id = ?
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			pStmt.setString(1, dto.getName());
			pStmt.setInt(2, dto.getBirthDate());
			pStmt.setString(3, dto.getPref());
			pStmt.setString(4, dto.getCity());
			pStmt.setString(5, dto.getEmail());
			pStmt.setInt(6, dto.getUserId());

			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(conn);
		}
		return result;
	}

	@Override
	public boolean delete(UsersDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			conn = conn();

			String sql = "DELETE FROM users WHERE user_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, dto.getUserId());

			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(conn);
		}
		return result;
	}

	public UsersDto findById(int userId) {
		Connection conn = null;
		UsersDto user = null;
		try {
			conn = conn();
			String sql = "SELECT * FROM users WHERE user_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, userId);
			ResultSet rs = pStmt.executeQuery();
			if (rs.next()) {
				user = new UsersDto(rs.getInt("user_id"), rs.getString("name"), rs.getInt("birth_date"),
						rs.getString("pref"), rs.getString("city"), rs.getString("email"), rs.getDate("created_at"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(conn);
		}
		return user;
	}

}
