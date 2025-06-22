package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	public static Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // 明示的にロード
		} catch (ClassNotFoundException e) {
			throw new SQLException("MySQLドライバが見つかりません", e);
		}
		String url = "jdbc:mysql://localhost:3306/c4?useSSL=false&serverTimezone=Asia/Tokyo&characterEncoding=UTF-8";
		String user = "root";
		String password = "password";
		return DriverManager.getConnection(url, user, password);
	}
}
