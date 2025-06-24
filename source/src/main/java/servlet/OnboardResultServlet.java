package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostsDao;
import dao.ReactionsDao;
import dto.PostsDto;

@WebServlet("/OnboardResult")
public class OnboardResultServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		// ログインユーザーID取得
		HttpSession session = request.getSession(false);
		Integer userId = (session != null) ? (Integer) session.getAttribute("id") : null;

		// 全件検索
		PostsDao postsDao = new PostsDao();
		PostsDto searchDto = new PostsDto(); // 空条件で全件
		List<PostsDto> postsList = postsDao.select(searchDto);

		// 各投稿に「いいね」情報をセット
		if (userId != null) {
			ReactionsDao reactionsDao = new ReactionsDao();
			for (PostsDto post : postsList) {
				post.setLikedByCurrentUser(reactionsDao.isUserLiked(post.getPostId(), userId));
				post.setLikeCount(reactionsDao.getLikeCountByPostId(post.getPostId()));
				post.setLikedUsers(reactionsDao.getLikedUserNames(post.getPostId()));
			}
		}

		request.setAttribute("postsList", postsList);
		request.getRequestDispatcher("/WEB-INF/jsp/onboardResult.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		try {
			request.setCharacterEncoding("UTF-8");
			HttpSession session = request.getSession(false);
			Integer userId = (session != null) ? (Integer) session.getAttribute("id") : null;

			// 検索条件取得
			String tag = request.getParameter("tag");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String pref = request.getParameter("prefecture");
			String city = request.getParameter("city");

			// DTOに検索条件をセット
			PostsDto searchDto = new PostsDto();
			searchDto.setTag(tag);
			searchDto.setTitle(title);
			searchDto.setContent(content);
			searchDto.setPref(pref);
			searchDto.setCity(city);

			PostsDao postsDao = new PostsDao();
			List<PostsDto> postsList = postsDao.select(searchDto);

			// 各投稿に「いいね」情報をセット
			if (userId != null) {
				ReactionsDao reactionsDao = new ReactionsDao();
				for (PostsDto post : postsList) {
					post.setLikedByCurrentUser(reactionsDao.isUserLiked(post.getPostId(), userId));
					post.setLikeCount(reactionsDao.getLikeCountByPostId(post.getPostId()));
					post.setLikedUsers(reactionsDao.getLikedUserNames(post.getPostId()));
				}
			}

			request.setAttribute("postsList", postsList);
			request.getRequestDispatcher("/WEB-INF/jsp/onboardResult.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "検索処理でエラーが発生しました");
		}
	}
}
