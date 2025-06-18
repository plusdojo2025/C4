package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// DB接続ユーティリティ
import utility.DBUtil;

@WebServlet(urlPatterns = {"", "/OmoiyalinkLogin"})
public class LoginServlet extends CustomTemplateServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // すでにログイン済みならホームへリダイレクト
        if (checkDoneLogin(request, response)) {
            return;
        }
        // ログインページへフォワード
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (checkDoneLogin(request, response)) {
            return;
        }

        // 入力値取得
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String birthday = request.getParameter("birthday");

        // 入力チェック
        if (id == null || id.isEmpty() || 
            name == null || name.isEmpty() || 
            birthday == null || birthday.isEmpty()) {
            request.setAttribute("error", "ID・氏名・生年月日をすべて入力してください。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // DB認証
        boolean isAuthenticated = false;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT name FROM users WHERE id = ? AND name = ? AND birthday = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            stmt.setString(2, name);
            stmt.setString(3, birthday);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // nameが完全一致したら認証OK
                isAuthenticated = true;
                name = rs.getString("name"); // 取得した名前（大文字小文字/全角半角の正規化も可）
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "システムエラーが発生しました。管理者に連絡してください。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if (isAuthenticated) {
            // 認証OK→セッションへセット
            HttpSession session = request.getSession();
            session.setAttribute("id", id);
            session.setAttribute("userName", name); // JSPはuserNameを参照
            session.setAttribute("birthday", birthday);

            // ホームへリダイレクト
            response.sendRedirect("OmoiyalinkHome");
        } else {
            // 認証NG
            request.setAttribute("error", "ID・氏名・生年月日が一致しません。再度ご確認ください。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
