package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 全サーブレット共通のテンプレート。ログイン・ログアウトチェックなどを集約
 */
public abstract class CustomTemplateServlet extends HttpServlet {

    /**
     * ログアウト処理（?logout=1 などで呼ばれる想定）
     */
    public boolean checkLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String logout = request.getParameter("logout");
        boolean result = (logout != null);
        if (result) {
            HttpSession session =  request.getSession();
            session.removeAttribute("user"); // ← user属性だけで統一する！
            response.sendRedirect("OmoiyalinkLogin");
        }
        return result;
    }

    /**
     * 未ログイン時のチェック（未ログインならtrue＋ログイン画面に飛ばす）
     */
    protected final boolean checkNoneLogin(HttpServletRequest request, HttpServletResponse response) 
               throws IOException {
        HttpSession session = request.getSession(false);
        boolean result = (session == null || session.getAttribute("user") == null);
        if (result) { 
            // 未ログインなのでログイン画面にリダイレクト
            response.sendRedirect("OmoiyalinkLogin");
        }
        return result;
    }

    /**
     * すでにログイン済みのチェック（ログイン済みならtrue＋ホーム画面に飛ばす）
     */
    protected final boolean checkDoneLogin(HttpServletRequest request, HttpServletResponse response) 
               throws IOException {
        HttpSession session = request.getSession(false);
        boolean result = (session != null && session.getAttribute("user") != null);
        if (result) {
            // すでにログインしていればホームへ
            response.sendRedirect("TlkMedMngServlet");
        }
        return result;
    }

    @Override
    protected abstract void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;

    @Override
    protected abstract void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;

}
