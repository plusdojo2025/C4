package servlet;  
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PostsDao;
import dto.PostsDto;
 

@WebServlet("/OnboardSearch")
public class OnboardSearchServlet extends CustomTemplateServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (checkNoneLogin(request, response) || checkLogout(request, response)) {
            return; // チェックに引っかかったら処理終了
        }
        request.getRequestDispatcher("/WEB-INF/jsp/onboardSearch.jsp").forward(request, response);
    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		String tag = request.getParameter("tag");
		String pref = request.getParameter("pref");
		String city = request.getParameter("city");
		
	    // ここでDTOを作って値をセット！
	    PostsDto dto = new PostsDto();
	    dto.setTag(tag);
	    dto.setPref(pref);
	    dto.setCity(city);
	     

		// 検索処理を行う
		PostsDao bDao = new PostsDao();
	    List<PostsDto> cardList = bDao.select(dto);
		//List<PostsDto> cardList = bDao.select(new PostsDto(0, tag, title, content, new Date(), prefecture, city));

		// 検索結果をリクエストスコープに格納する
		request.setAttribute("postsList"/*採ってくるための箱*/, cardList/*採っていく実態*/);

		// 結果ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/onboardResult.jsp");
		dispatcher.forward(request, response);
		
		

	}
}