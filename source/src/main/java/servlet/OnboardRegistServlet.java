package servlet;
import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostsDao;
import dto.PostsDto;
@WebServlet("/OnboardRegist")
public class OnboardRegistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // ログインチェック（本来は共通親クラス化推奨！）
    private boolean checkNoneLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("OmoiyalinkLogin");
            return true;
        }
        return false;
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (checkNoneLogin(request, response)) {
            return;
        }
        HttpSession session = request.getSession(false);
        // セッションからpref/city取得（無い場合は空文字）
        String pref = (String) session.getAttribute("pref");
        String city = (String) session.getAttribute("city");
        if (pref == null) pref = "";
        if (city == null) city = "";
        // JSPで${pref},${city}で参照できるようセット
        request.setAttribute("pref", pref);
        request.setAttribute("city", city);
        request.getRequestDispatcher("/WEB-INF/jsp/onboardRegist.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (checkNoneLogin(request, response)) {
            return;
        }
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        Integer userIdObj = (Integer) session.getAttribute("id");
        if (userIdObj == null) {
            response.sendRedirect("OmoiyalinkLogin");
            return;
        }
        int userId = userIdObj;
        // 都道府県・市区町村をフォーム値 or セッションから取得
        String pref = request.getParameter("pref");
        String city = request.getParameter("city");
        if (pref == null || pref.isEmpty()) {
            pref = (String) session.getAttribute("pref");
        }
        if (city == null || city.isEmpty()) {
            city = (String) session.getAttribute("city");
        }
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String[] tags = request.getParameterValues("tags");
        // 必須チェック
        if (title == null || title.isEmpty() ||
            content == null || content.isEmpty() ||
            tags == null || tags.length == 0) {
            request.setAttribute("errorMessage", "タイトル・内容・タグは必須です。");
            // エラー時にもpref/cityを再セット
            request.setAttribute("pref", pref != null ? pref : "");
            request.setAttribute("city", city != null ? city : "");
            request.getRequestDispatcher("/WEB-INF/jsp/onboardRegist.jsp").forward(request, response);
            return;
        }
        String tag = String.join(",", tags);
        // 投稿DTO作成
        PostsDto post = new PostsDto(userId, tag, title, content, new Date(), pref, city);
        // 登録
        try {
            PostsDao dao = new PostsDao();
            dao.insert(post);
            response.sendRedirect("OmoiyalinkMyPost");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "投稿処理中にエラーが発生しました");
        }
    }
    }






















