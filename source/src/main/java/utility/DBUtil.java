package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    public static Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/c4?useSSL=false&serverTimezone=Asia/Tokyo";
        String user = "root";
        String password = "password";
        return DriverManager.getConnection(url, user, password);
    }
}
