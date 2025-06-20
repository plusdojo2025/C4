<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>服薬記録登録</title>
<style>
</style>
</head>

<body>
	<header class="site-header">おもいやリンク 服薬記録登録</header>
	<div class="container">
		<h2>服薬記録 登録フォーム</h2>
		<c:if test="${not empty errorMessage}">
			<div class="form-error">${errorMessage}</div>
		</c:if>
		<form
			action="${pageContext.request.contextPath}/OmoiyalinkMedRegistServlet"
			method="post">
			<label for="takenTime">服薬時間</label> <input type="datetime-local"
				name="takenTime" id="takenTime" required> <label
				for="nickname">薬の愛称</label> <input type="text" name="nickname"
				id="nickname" required> <label for="formalName">薬の正式名称</label>
			<input type="text" name="formalName" id="formalName" required>

			<label for="dosage">用量</label> <input type="text" name="dosage"
				id="dosage" required> <label for="takenMed">服薬名（例：朝食後など）</label>
			<input type="text" name="takenMed" id="takenMed"> <label
				for="memo">メモ</label>
			<textarea name="memo" id="memo" rows="2"></textarea>

			<button type="submit">記録を登録する</button>
			<button type="button" onclick="history.back()">戻る</button>
		</form>
	</div>
	<footer class="site-footer">© 2025 おもいやリンク</footer>
</body>
</html>

