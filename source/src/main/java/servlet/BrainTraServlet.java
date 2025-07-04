package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/OmoiyalinkBrainTra")
public class BrainTraServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/jsp/brainTra.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("start".equals(action)) {
			// セッション初期化
			request.getSession().setAttribute("winCount", 0);
			request.getSession().setAttribute("history", new java.util.ArrayList<String>());
			response.sendRedirect("https://plusdojo.jp/c4/OmoiyalinkBrainTraPlay");
		} else if ("history".equals(action)) {
			response.sendRedirect("https://plusdojo.jp/c4/OmoiyalinkBrainTraMng");
		} else {
			response.sendRedirect("https://plusdojo.jp/c4/OmoiyalinkBrainTra");
		}
}
}