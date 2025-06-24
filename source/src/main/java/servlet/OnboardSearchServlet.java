package servlet;  
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostsDao;
import dao.ReactionsDao;
import dto.PostsDto;
 

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
        HttpSession session = request.getSession(false);
        Integer userIdObj = (Integer) session.getAttribute("id");
        if (userIdObj == null) {
            response.sendRedirect("OmoiyalinkLogin");
            return;
        }
        int userId = userIdObj;

        request.setCharacterEncoding("UTF-8");
        String tag = request.getParameter("tag");
        String pref = request.getParameter("pref");
        String city = request.getParameter("city");
        if (pref == null || pref.isEmpty()) {
            pref = (String) session.getAttribute("pref");
        }
        if (city == null || city.isEmpty()) {
            city = (String) session.getAttribute("city");
        }

        PostsDto dto = new PostsDto();
        dto.setTag(tag);
        dto.setPref(pref);
        dto.setCity(city);

        // 検索処理
        PostsDao bDao = new PostsDao();
        List<PostsDto> cardList = bDao.select(dto);

        // ★ここが重要★
        ReactionsDao reactionsDao = new ReactionsDao();
        for (PostsDto post : cardList) {
            post.setLikeCount(reactionsDao.getLikeCountByPostId(post.getPostId()));
            post.setLikedByCurrentUser(reactionsDao.isUserLiked(post.getPostId(), userId));
            post.setLikedUsers(reactionsDao.getLikedUserNames(post.getPostId()));
        }

        request.setAttribute("postsList", cardList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/onboardResult.jsp");
        dispatcher.forward(request, response);
    }
}