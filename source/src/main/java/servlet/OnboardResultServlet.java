package servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PostsDao;
import dto.PostsDto;
/**
 * Servlet implementation class OnboardResultServlet
 */
@WebServlet("/OnboardResult")
public class OnboardResultServlet extends CustomTemplateServlet {
    private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		try {
		       // PostsDaoを使用して検索実行
	        PostsDao dao = new PostsDao(); // PostsDaoをインスタンス化
	        PostsDto searchDto = new  PostsDto( 0, "", "", "", new Date());
	        List<PostsDto> postsList = dao.select(searchDto);

			// 検索結果をリクエストスコープに格納する
			request.setAttribute("postsList", postsList);
			
			//postsList = dao.select(prefecture, city);どう動くか分からない

	        // 検索結果をリクエストに保存
	        request.getRequestDispatcher("/WEB-INF/jsp/onboardResult.jsp").forward(request, response);


					} catch (Exception e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
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
