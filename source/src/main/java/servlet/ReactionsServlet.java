package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostsDao;
import dao.ReactionsDao;
import dto.PostsDto;
import dto.UsersDto;

/**
 * リアクション取得APIサーブレット 指定したpostIdのリアクション情報（いいね数、ユーザーID一覧など）をJSONで返す
 */
@WebServlet("/ReactionsServlet")
public class ReactionsServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * GET: 指定した投稿ID(postId)に対するリアクションユーザー一覧＆件数をJSONで返す
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログイン・ログアウトチェック
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
	    // 画面推移しないで「投稿ごとのいいね数取得」
	    String action = request.getParameter("action");
	    if ("count".equals(action)) {
	        try {
	            int postId = Integer.parseInt(request.getParameter("post_id"));
	            ReactionsDao dao = new ReactionsDao();
	            int count = dao.getLikeCountByPostId(postId); // このメソッドは DAO に実装する

	            response.setContentType("application/json");
	            response.setCharacterEncoding("UTF-8");
	            response.getWriter().write("{\"count\": " + count + "}");
	        } catch (Exception e) {
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        }
	        return;
	    }
	    // ★ここから通常の画面表示処理（一覧表示など）★
	    try {
	        HttpSession session = request.getSession();
	        int userId = (int) session.getAttribute("user_id");

	        PostsDao postDao = new PostsDao();
	        ReactionsDao reactionDao = new ReactionsDao();

	        List<PostsDto> myPosts = postDao.selectByUserId(userId);

	        Map<Integer, Integer> likeCountMap = new HashMap<>();
	        for (PostsDto post : myPosts) {
	            int postId = post.getId();  // DTOのgetterに合わせて
	            int count = reactionDao.getLikeCountByPostId(postId);
	            likeCountMap.put(postId, count);

	            System.out.println("投稿ID: " + postId + " いいね数: " + count);
	        }

	        System.out.println("■ likeCountMapの中身: " + likeCountMap);

	        request.setAttribute("myPosts", myPosts);
	        request.setAttribute("likeCountMap", likeCountMap);

	        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPost.jsp");
	        dispatcher.forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	    }
	}

	


	/**
	 * POST: 必要なら実装（リアクション追加など）
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	    if (checkNoneLogin(request, response) || checkLogout(request, response)) {
	        return;
	    }

	    // 投稿IDとリアクションタイプを取得
	    int postId = Integer.parseInt(request.getParameter("postId"));
	    String type = request.getParameter("type");

	    // セッションから userId を取得
	    HttpSession session = request.getSession();
	    UsersDto user = (UsersDto) session.getAttribute("user_id");
	    int userId = user.getUserId();

	    // リアクションを登録
	    ReactionsDao dao = new ReactionsDao();
	    dao.addReaction(postId, userId, type);

	    response.setStatus(HttpServletResponse.SC_OK);
	    response.setContentType("application/json; charset=UTF-8");
	    response.getWriter().write("{\"status\":\"success\"}");
	}
}
