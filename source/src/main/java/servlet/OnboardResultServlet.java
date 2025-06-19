package servlet;

import java.io.IOException;
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

        // 検索画面から直接GETで来たら空条件で全件表示、でもよい
        request.getRequestDispatcher("/WEB-INF/jsp/searchForm.jsp").forward(request, response);
    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    if (checkNoneLogin(request, response) || checkLogout(request, response)) {
	        return;
	    }

	    try {
	        request.setCharacterEncoding("UTF-8");

	        String prefecture = request.getParameter("prefecture");
	        String city = request.getParameter("city");
	        String tags = request.getParameter("tags");

	        // 検索条件をもとにDtoを作成
	        PostsDto searchDto = new PostsDto(0, prefecture, city, tags, null);

	        PostsDao dao = new PostsDao();
	        List<PostsDto> postsList = dao.select(searchDto);

	        request.setAttribute("postsList", postsList);
	        request.getRequestDispatcher("/WEB-INF/jsp/onboardResult.jsp").forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace();
	        // エラー画面に飛ばす処理を追加しても◎
	    }
	
	}	

}
