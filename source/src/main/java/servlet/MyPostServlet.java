package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostsDao;
import dto.PostsDto;
import dto.UsersDto;

/**
 * Servlet implementation class MyPostServlet
 */
@WebServlet("/OmoiyalinkMyPost")
public class MyPostServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		//マイ投稿の検索
		try {		
	        // ログインユーザーの取得
	        HttpSession session = request.getSession();
	        UsersDto user = (UsersDto) session.getAttribute("user_id");
	        int userId = user.getUserId();

			// ユーザーの投稿を取得
	        PostsDao postDao = new PostsDao();
	        List<PostsDto> myPosts = postDao.selectByUserId(userId);

			// 検索結果をリクエストスコープに格納する
			request.setAttribute("myPosts", myPosts);

			// 結果ページにフォワードする
			RequestDispatcher dispatcher = request.getRequestDispatcher(request.getContextPath() + "/myPost.jsp");
			dispatcher.forward(request, response);
		}
		catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("message", "エラーが発生しました。お薬情報を取得できませんでした");
	        request.getRequestDispatcher(request.getContextPath() + "/HomeServlet").forward(request, response);
	    }
	}
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
	}	
}
