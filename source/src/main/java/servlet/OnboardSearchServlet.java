package servlet;  
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

@WebServlet("/OnboardSearch")
public class OnboardSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 検索フォームの初期表示を設定
        request.getRequestDispatcher("/WEB-INF/jsp/onboardSearch.jsp").forward(request, response);
        
        if (checkNoneLogin(request, response) || checkLogout(request, response));
    }

	private boolean checkLogout(HttpServletRequest request, HttpServletResponse response) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}

	private boolean checkNoneLogin(HttpServletRequest request, HttpServletResponse response) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}
}
