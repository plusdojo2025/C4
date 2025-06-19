package servlet;  
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

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
		// TODO 自動生成されたメソッド・スタブ
		
	}
}