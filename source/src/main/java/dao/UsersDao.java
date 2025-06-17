package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

			// SQL文を準備する
			String sql = "SELECT * FROM users WHERE user_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getUserId());

			// SQL文を実行し、結果表を取得する
			// ResultSetはJDBC特有のなにか
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				UsersDto users = new UsersDto(rs.getInt("user_id"), rs.getString("name"), rs.getInt("birth_date"),
						rs.getString("pref"), rs.getString("city"), rs.getString("email"), rs.getDate("created_at"));
				userList.add(users);
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
	public boolean insert(UsersDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
					INSERT users(name , birth_date , pref , city , email)
							VALEUS(       ?,                ?,       ?,     ?,         ? )
					""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, dto.getName());
			pStmt.setInt(2, dto.getBirthDate());
			pStmt.setString(3, dto.getPref());
			pStmt.setString(4, dto.getCity());
			pStmt.setString(5, dto.getEmail());

			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				ResultSet res = pStmt.getGeneratedKeys();
				res.next();
				dto.setUserId(res.getInt(1));
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
	public boolean update(UsersDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = """
										UPDATE users
										SET
					  name = ?
					,  birth_date =?
					, pref =?
					,  city =?
					,  email =?
										WHERE user_id = ?
										""";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, dto.getName());
			pStmt.setInt(2, dto.getBirthDate());
			pStmt.setString(3, dto.getPref());
			pStmt.setString(4, dto.getCity());
			pStmt.setString(5, dto.getEmail());
			pStmt.setInt(6, dto.getUserId());

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
	public boolean delete(UsersDto dto) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			// データベースに接続する
			conn = conn();

			// SQL文を準備する
			String sql = "DELETE FROM users WHERE user_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, dto.getUserId());

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
