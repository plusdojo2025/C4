
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

/**
 * Servlet implementation class OnboardRegistServlet
 */
@WebServlet("/OnboardRegist")
public class OnboardRegistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
        // フォームの初期表示を設定
        HttpSession session = request.getSession();
        String prefecture = (String) session.getAttribute("prefecture");
        String city = (String) session.getAttribute("city");

        request.setAttribute("prefecture", prefecture);
        request.setAttribute("city", city);
        request.getRequestDispatcher("/WEB-INF/jsp/onboardRegist.jsp").forward(request, response);
    }

    private boolean checkLogout(HttpServletRequest request, HttpServletResponse response) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}

	private boolean checkNoneLogin(HttpServletRequest request, HttpServletResponse response) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		try  {
        // 投稿内容を取得
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId"); // ユーザーID
        String tag = session.getAttribute("prefecture") + " " + session.getAttribute("city");

        PostsDto post = new PostsDto(userId, tag, title, content, new Date());
        
            PostsDao dao = new PostsDao(); // Connectionオブジェクトを渡してDAOをインスタンス化
            dao.insert(post); // 投稿データを保存

        } 
		catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "投稿処理中にエラーが発生しました");
        }

        // 投稿後、マイ投稿ページへリダイレクト
        response.sendRedirect("OmoiyalinkMyPosts");
    }

}


