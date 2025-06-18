package servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UsersDao;
import dto.UsersDto;
import utility.MailUtil;

@WebServlet("/OmoiyalinkUserRegistServlet")
public class UserRegistServlet extends CustomTemplateServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // フォームの値を取得
            String name = request.getParameter("name");
            String pref = request.getParameter("pref");
            String city = request.getParameter("city");
            String birthDate = request.getParameter("birthdate");
            String email = request.getParameter("email");

            // 入力バリデーション（必要に応じて追加）
            if (name == null || name.isEmpty() ||
                pref == null || pref.isEmpty() ||
                city == null || city.isEmpty() ||
                birthDate == null || birthDate.isEmpty() ||
                email == null || email.isEmpty()) {
                request.setAttribute("errorMessage", "全ての項目を入力してください。");
                request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp").forward(request, response);
                return;
            }

            // DTO生成。userIdは0（自動採番）でOK
            UsersDto userDto = new UsersDto(0, name, Integer.parseInt(birthDate), pref, city, email, new Date());

            // DAOで登録
            UsersDao userDao = new UsersDao();
            boolean result = userDao.insert(userDto);

            if (result) {
                // 仮にDAOのinsertでuserDtoに自動採番されたIDがセットされている場合は下記のように使える
                // int newUserId = userDto.getUserId();

                // メール送信（メール内容は適宜調整）
                MailUtil.sendMail(email,
                        "【おもいやリンク】登録完了のお知らせ",
                        "おもいやリンク運営事務局です。\n\n" +
                        "ご登録ありがとうございます。\n" +
                        "ID（自動採番番号）とパスワード（生年月日8桁）でログインできます。\n\n" +
                        "今後ともよろしくお願いいたします。\n");

                // サーブレット名でログイン画面へリダイレクト
                response.sendRedirect("OmoiyalinkLogin");
            } else {
                // 失敗時
                request.setAttribute("errorMessage", "登録に失敗しました。やり直してください。");
                request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "システムエラー: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp").forward(request, response);
        }
    }
}
