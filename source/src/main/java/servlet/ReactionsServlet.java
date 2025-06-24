package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReactionsDao;

@WebServlet("/ReactionsServlet")
public class ReactionsServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer userId = (Integer) request.getSession().getAttribute("id");
		if (userId == null) {
			response.setStatus(401);
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write("{\"status\":\"login_required\"}");
			return;
		}

		int postId = Integer.parseInt(request.getParameter("postId"));
		String action = request.getParameter("action"); // "like" or "unlike"

		ReactionsDao dao = new ReactionsDao();

		boolean nowLiked;
		if ("like".equals(action)) {
			dao.addReaction(postId, userId);
			nowLiked = true;
		} else if ("unlike".equals(action)) {
			dao.removeReaction(postId, userId);
			nowLiked = false;
		} else {
			response.setStatus(400);
			response.getWriter().write("{\"status\":\"bad_request\"}");
			return;
		}

		int likeCount = dao.getLikeCountByPostId(postId);
		List<String> likedUsers = dao.getLikedUserNames(postId);

		// レスポンス（JSON形式）
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().write("{\"status\":\"ok\"," + "\"liked\":" + nowLiked + "," + "\"count\":" + likeCount
				+ "," + "\"users\":["
				+ String.join(",", likedUsers.stream().map(s -> "\"" + s + "\"").toArray(String[]::new)) + "]}");
	}
}
