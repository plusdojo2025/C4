package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/OmoiyalinkBrainTraPlay")
public class BrainTraPlayServlet extends CustomTemplateServlet {
    private static final long serialVersionUID = 1L;
    private static final String[] HANDS = {"グー", "チョキ", "パー"};

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/brainTraPlay.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String userHand = request.getParameter("hand");
        String cpuHand = HANDS[new Random().nextInt(HANDS.length)];
        String result;

        HttpSession session = request.getSession();
        Integer winCount = (Integer) session.getAttribute("winCount");
        if (winCount == null) winCount = 0;
        @SuppressWarnings("unchecked")
        List<String> history = (List<String>) session.getAttribute("history");
        if (history == null) history = new ArrayList<>();

        // 勝敗判定
        if (isUserWin(userHand, cpuHand)) {
            result = "正解！";
            winCount++;
        } else {
            result = "不正解";
        }

        // 履歴追加
        String record = "あなた:" + userHand + " CPU:" + cpuHand + " → " + result;
        history.add(record);

        // セッション保存
        session.setAttribute("winCount", winCount);
        session.setAttribute("history", history);

        // 表示用
        request.setAttribute("userHand", userHand);
        request.setAttribute("cpuHand", cpuHand);
        request.setAttribute("result", result);
        request.setAttribute("winCount", winCount);
        request.setAttribute("history", history);

        request.getRequestDispatcher("/WEB-INF/jsp/brainTraResult.jsp").forward(request, response);
    }

    private boolean isUserWin(String user, String cpu) {
        return (user.equals("グー") && cpu.equals("チョキ")) ||
               (user.equals("チョキ") && cpu.equals("パー")) ||
               (user.equals("パー") && cpu.equals("グー"));
    }
}
