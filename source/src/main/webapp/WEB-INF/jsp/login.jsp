<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>おもいやリンク ログイン</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<script src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
	<!-- ヘッダー（共通パーツにしたい場合はinclude） -->
	<%-- <%@ include file="/WEB-INF/jsp/common/header.jsp" %> --%>

	<div class="login-container">
		<h2>ログイン</h2>
		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<form action="OmoiyalinkLogin" method="post" autocomplete="off">
			<label for="user_id">ID（半角数字）</label> <input type="text" id="user_id"
				name="user_id" maxlength="10" required> <label for="name">名前</label>
			<input type="text" id="name" name="name" maxlength="50" required>

			<label for="birth_date">生年月日（8桁：例 20000101）</label> <input
				type="text" id="birth_date" name="birth_date" maxlength="8" required>

			<button type="submit">ログイン</button>
		</form>
		<!-- 新規登録ボタン -->
		<a
			href="${pageContext.request.contextPath}/OmoiyalinkUserRegistServlet"
			class="register-btn">新規登録はこちら</a>
	</div>

	<!-- フッターも共通化したい場合はここでinclude -->
	<%-- <%@ include file="/WEB-INF/jsp/common/footer.jsp" %> --%>
</body>
</html>
