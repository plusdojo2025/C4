package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class BrainTraResultServlet
 */
@WebServlet("/OmoiyalinkBrainTraResult")
public class BrainTraResultServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public BrainTraResultServlet() {
    	super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		//勝利数の履歴を取得
		Integer winCount = (Integer) session.getAttribute("winCount");
		@SuppressWarnings("unchecked")
		List<String>history = (List<String>) session.getAttribute("history");
		
		if (winCount == null) winCount = 0;
		if (history == null) history = new ArrayList<>();
		
		//リクエストを渡す
		request.setAttribute("winCount",winCount);
		request.setAttribute("history",history);
		
		request.getRequestDispatcher("/WEB-INF/jsp/brainTraResult.jsp").forward(request, response);
		
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO 自動生成されたメソッド・スタブ
		
	}

}
