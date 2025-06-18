package servlet;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BrainTraPlayServlet
 */
@WebServlet("/OmoiyalinkBrainTraPlay")
public class BrainTraPlayServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

    private static final String[] HANDS = {"グー","チョキ","パー"};  //CPUの手の表示
	
    public BrainTraPlayServlet() {
    }

	//じゃんけんの選択画面を表示
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/jsp/brainMenu.jsp").forward(request, response);
		
	}

	//利用者の手を受け取って勝つ手を出して結果を表示
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String usersHand = request.getParameter("hand");  //利用者の手
		
		String cpuHand = HANDS[new Random().nextInt(HANDS.length)]; //CPUの手をランダムで選ぶ
				
		//String result;  //勝利判定
		//if (isUserWin(usersHand,cpuHand)) {
			//result = "正解！" ;
		//} else {
			//result = "不正解";
		//}
		
		
		
		
	}
}
