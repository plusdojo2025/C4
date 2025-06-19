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

import utility.DBUtil;

@WebServlet(urlPatterns = { "/", "/OmoiyalinkLogin" })
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

        // 文字化け対応
        request.setCharacterEncoding("UTF-8");

        if (checkDoneLogin(request, response)) {
            return;
        }

        // 入力値取得
        String user_id = request.getParameter("user_id");
        String name = request.getParameter("name");
        String birth_date = request.getParameter("birth_date");

        // 必要に応じて型変換
        int userIdInt = 0;
        int birthDateInt = 0;
        try {
            userIdInt = Integer.parseInt(user_id);
            birthDateInt = Integer.parseInt(birth_date);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "IDと生年月日は半角数字で入力してください。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        System.out.println("user_id: [" + user_id + "]");
        System.out.println("userIdInt: " + userIdInt);
        System.out.println("name: [" + name + "]");
        System.out.println("birth_date: [" + birth_date + "]");
        System.out.println("birthDateInt: " + birthDateInt);

        // DB認証
        boolean isAuthenticated = false;
        String pref = null;
        String city = null;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT name, pref, city FROM users WHERE user_id = ? AND name = ? AND birth_date = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userIdInt);
            stmt.setString(2, name);
            stmt.setInt(3, birthDateInt);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                isAuthenticated = true;
                name = rs.getString("name");
                pref = rs.getString("pref");
                city = rs.getString("city");
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
            session.setAttribute("user_id", user_id);
            session.setAttribute("userName", name);
            session.setAttribute("birth_date", birth_date);
            session.setAttribute("pref", pref);   // ← ここでprefを保存
            session.setAttribute("city", city);

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