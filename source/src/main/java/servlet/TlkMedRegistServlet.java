package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MedicationLogsDao;
import dao.MedicationsDao;
import dto.MedicationLogsDto;
import dto.MedicationsDto;
import dto.UsersDto;

/**
 * 服薬記録登録サーブレット GET: 登録画面表示（薬情報の取得） POST: 服薬記録を登録（複数選択可）
 */
@WebServlet("/OmoiyalinkTlkMedRegist")
public class TlkMedRegistServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 服薬登録画面の表示（GET時）
	 */

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// ログインチェック（未ログイン・ログアウト状態ならリダイレクト）
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		try {
			// セッションからログイン中のユーザー情報を取得
			HttpSession session = request.getSession();
			UsersDto user = (UsersDto) session.getAttribute("user");
			int userId = user.getUserId();

			// ユーザーの登録薬を取得
			MedicationsDao medicationsDao = new MedicationsDao();
			List<MedicationsDto> allMeds = medicationsDao.selectByUser(userId);

			// 薬の登録件数の確認
			// System.out.println("★登録薬件数: " + allMeds.size());

			// どの薬が取得されているか
//	        for (MedicationsDto med : allMeds) {
//	            System.out.println("・" + med.getNickName() + " - " + med.getIntakeTime());
//	        }

			// 時間帯（intakeTime）ごとに薬をグループ分け
			// 例: "09:00", "12:00" など
			Map<String, List<MedicationsDto>> medsByTime = new LinkedHashMap<>();
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

			for (MedicationsDto med : allMeds) {
				String key = med.getIntakeTime() != null ? sdf.format(med.getIntakeTime()) : "未指定";
				medsByTime.computeIfAbsent(key, k -> new ArrayList<>()).add(med);
			}

			// 今日すでに登録された服薬ログを取得（チェック状態反映用）
			MedicationLogsDao logsDao = new MedicationLogsDao();
			MedicationLogsDto cond = new MedicationLogsDto();
			cond.setUserId(userId);
			cond.setTakenTime(new Date()); // 今日の服薬記録取得
			List<MedicationLogsDto> todayLogs = logsDao.selectByDate(cond);

			// チェック済みIDセットに変換
			Set<Integer> checkedmeds = todayLogs.stream().map(MedicationLogsDto::getMedicationId)
					.collect(Collectors.toSet());

			// JSPに渡すデータをリクエストスコープにセット
			request.setAttribute("medsByTime", medsByTime); // 時間帯ごとの薬
			request.setAttribute("checkedIds", checkedmeds); // 今日すでに登録された薬のID
			request.setAttribute("allMeds", allMeds); // 追加登録用

			// 服薬登録画面にフォワード
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/tlkMedRegist.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。登録画面を表示できませんでした。");
			request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
		}
	}

	/**
	 * 服薬記録の登録（POST時） ・1回の登録で複数の薬が選択された場合、すべて登録 ・成功/失敗でメッセージ＋遷移
	 */
@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException { 

	    // ログインチェック（セッション無効時など）
	    if (checkNoneLogin(request, response) || checkLogout(request, response)) {
	        return;
	    }
	
	    request.setCharacterEncoding("UTF-8"); // 文字コード指定（日本語入力対策）
	    
	    try {
	    // セッションからログイン中のユーザー情報を取得
	    String registerType = request.getParameter("registerType");
	    HttpSession session = request.getSession();
	    UsersDto user = (UsersDto) session.getAttribute("user");
	    int userId = user.getUserId();
	    
	    
	 // 【1】自由登録フォームからの登録か判定
	    if ("free".equals(registerType)) {
	        // ----- 自由登録フォーム -----
	        String medIdStr    = request.getParameter("freeMedicationId");
	        String freeTakenDate = request.getParameter("freeTakenDate"); // yyyy-MM-dd
	        String freeTakenTime = request.getParameter("freeTakenTime"); // HH:mm
	        String freeMemo      = request.getParameter("freeMemo");
	
	        // 入力チェック
	        if (medIdStr == null || freeTakenDate == null || freeTakenTime == null
	            || medIdStr.isEmpty() || freeTakenDate.isEmpty() || freeTakenTime.isEmpty()) {
	            request.setAttribute("message", "すべて入力してください。");
	            doGet(request, response); // 再表示
	            return;
	        }
	
	        int medicationId = Integer.parseInt(medIdStr);
	        // yyyy-MM-dd HH:mm:00 形式でTimestamp生成
	        String tsStr = freeTakenDate + " " + freeTakenTime + ":00";
	        Timestamp takenTimestamp = Timestamp.valueOf(tsStr);
	
	        MedicationLogsDto dto = new MedicationLogsDto();
	        dto.setUserId(userId);
	        dto.setMedicationId(medicationId);
	        dto.setTakenTime(takenTimestamp);
	        dto.setTakenMed("服用済み");
	        dto.setMemo(freeMemo);
	
	        boolean result = new MedicationLogsDao().insert(dto);
	        session.setAttribute("message", result ? "自由記録を登録しました。" : "登録に失敗しました。");
	        response.sendRedirect(request.getContextPath() + "/OmoiyalinkTlkMedMng");
	        return;
	    }
	
	    // 【2】チェックボックス一括登録
	    String[] selectedTakenMed = request.getParameterValues("takenMed");
	    if (selectedTakenMed == null || selectedTakenMed.length == 0) {
	        request.setAttribute("message", "服用した薬にチェックを入れてください。");
	        doGet(request, response);
	        return;
	    }
	    Timestamp now = new Timestamp(System.currentTimeMillis());
	    int successCount = 0;
	    for (String medIdStr : selectedTakenMed) {
	        int medicationId = Integer.parseInt(medIdStr);
	        String memo = request.getParameter("memo_" + medicationId);
	
	        MedicationLogsDto dto = new MedicationLogsDto();
	        dto.setUserId(userId);
	        dto.setMedicationId(medicationId);
	        dto.setTakenTime(now);
	        dto.setTakenMed("服用済み");
	        dto.setMemo(memo);
	
	        boolean result = new MedicationLogsDao().insert(dto);
	        if (result) successCount++;
	    }
	    String message = (successCount == selectedTakenMed.length) ? "服薬記録を登録しました。"
	            : (successCount == 0 ? "服薬記録の登録に失敗しました。" : "一部の服薬記録を登録できませんでした。");
	    session.setAttribute("message", message);
	    response.sendRedirect(request.getContextPath() + "/OmoiyalinkTlkMedMng");
	
	} catch (Exception e) {
	    e.printStackTrace();
	    request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
	    doGet(request, response); // 再表示
	}
}}
