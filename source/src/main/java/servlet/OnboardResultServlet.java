package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PostsDao;
import dto.PostsDto;
/**
 * Servlet implementation class OnboardResultServlet
 */
@WebServlet("/OnboardResult")
public class OnboardResultServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	
        // 検索条件を取得
        String prefecture = request.getParameter("prefecture");
        String city = request.getParameter("city");
        
     // コネクションを準備
        Connection connection = null;
		try {
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/c4");
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
			
			if (checkNoneLogin(request, response) || checkLogout(request, response)); 
		    		
		}
        // PostsDaoを使用して検索実行
        PostsDao dao = new PostsDao(connection); // PostsDaoをインスタンス化
        List<PostsDto> results = null;
		try {
			results = dao.select(prefecture, city);
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}

        // 検索結果をリクエストに保存
        request.setAttribute("results", results);
        request.getRequestDispatcher("/WEB-INF/jsp/onboardResult.jsp").forward(request, response);
    }

	private boolean checkNoneLogin(HttpServletRequest request, HttpServletResponse response) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}

	private boolean checkLogout(HttpServletRequest request, HttpServletResponse response) {
		// TODO 自動生成されたメソッド・スタブ
		return false;
	}
}
