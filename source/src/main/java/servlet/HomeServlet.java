package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * ホーム画面（トップページ）サーブレット
 * ログインユーザー名をJSPに渡して表示
 */
@WebServlet("/OmoiyalinkHome")
public class HomeServlet extends CustomTemplateServlet {
    private static final long serialVersionUID = 1L;

    /**
     * GETリクエスト時の処理
     * ・未ログインならログイン画面へリダイレクト
     * ・ログイン済みならユーザー名を取得しJSPに渡してホーム画面を表示
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // （1）未ログインの場合はチェック用メソッドで中断（ログイン画面にリダイレクトなど）
        if (checkNoneLogin(request, response)) {
            return;
        }

        // （2）セッションからユーザー名を取得
        HttpSession session = request.getSession(false); // セッションがなければnull
        String userName = null;
        if (session != null) {
            userName = (String) session.getAttribute("userName"); // 属性名は統一推奨
        }
        if (userName == null) {
            userName = "ゲスト"; // 万一セッション切れ時用
        }

        // （3）ユーザー名をリクエストスコープにセット（JSPで${userName}で使える）
        request.setAttribute("userName", userName);

        // （4）JSP（ホーム画面）へフォワード
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * POSTリクエスト時もGETの内容に転送
     * 不要なら省略も可（ボタンクリックなどでPOSTになる場合に備える）
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
