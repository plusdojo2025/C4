package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import dto.CustomeTemplateDto;

public abstract class CustomTemplateDao<DTO extends CustomeTemplateDto> {
	public Connection conn() {
		try {
			// JDBCドライバを読み込む
			Class.forName("com.mysql.cj.jdbc.Driver");

			// データベースに接続する
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");
			return conn;
		} catch (Exception ex) {
			throw new RuntimeException(ex);
		}
	}

	public void close(Connection conn) {
		// データベースを切断
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public abstract List<DTO> select(DTO dto);

	public abstract boolean insert(DTO dto);

	public abstract boolean update(DTO dto);

	public abstract boolean delete(DTO dto);
}
