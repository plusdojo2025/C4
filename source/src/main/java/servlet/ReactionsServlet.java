package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReactionsDao;
import dto.ReactionsDto;

/**
 * Servlet implementation class ReactionsServlet
 */
@WebServlet("/ReactionsServlet")
public class ReactionsServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
        int postId = Integer.parseInt(request.getParameter("postId"));
        try {
        	//Usersを持ってくるため
        	ReactionsDao ReactionsDao = new ReactionsDao();
            List<ReactionsDto> users = ReactionsDao.findUsersByPostId(postId);

            // JSONに変換
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"likeCount\":" + users.size() + ",\"users\":[");
            for (int i = 0; i < users.size(); i++) {
                out.print("{\"name\":\"" + users.get(i).getUserId() + "\"}");
                if (i < users.size() - 1) out.print(",");
            }
            out.print("]}");
        } catch (Exception e) {
            e.printStackTrace();
        }

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO 自動生成されたメソッド・スタブ
		
	}
}	