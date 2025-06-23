<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>服薬登録</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<style>
table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	border: 1px solid #aaa;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

input[type="text"] {
	width: 95%;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: center;
}

h2 {
	margin-top: 120px;
	font-size: 1.8rem;
}

h3 {
	margin-top: 20px;
	font-size: 1.4rem;
	color: #007BFF;
}

.sub-header {
	background-color: #46B1E1; /* 青色 */
	color: #FFFEEF;
	padding: 15px 30px;
	margin-top: 0px; /* ヘッダーがfixedなので被らないようにする */
}

.sub-header h2 {
	margin: 0;
	color: #FFFEEF;
	font-size: 2rem;
	text-align: center;
}

.nav-buttons {
    margin-top: 10px;
    text-align: right;    /* 右寄せにしたい場合。中央ならcenter、左寄せならleft */
}

.nav-buttons a {
    text-decoration: none;
    margin-left: 8px;
}
/*画面遷移ボタンのスタイル*/
.nav-buttons button {
    cursor: pointer;
}

</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="sub-header">
		<h2>服薬登録</h2>
	</div>
	<div class="nav-buttons">
			<a href="OmoiyalinkMedRegist">
				<button type="button">薬の登録</button>
			</a> <a href="OmoiyalinkTlkMedMng">
				<button type="button">服薬登録一覧</button>
			</a>
		
	</div>


	<c:if test="${not empty message}">
		<p style="color: red;">${message}</p>
	</c:if>

	<form method="post" action="OmoiyalinkTlkMedRegist">

		<c:forEach var="entry" items="${medsByTime}">
			<h3>${entry.key}の薬</h3>
			<table>
				<tr>
					<th>愛称</th>
					<th>正式名</th>
					<th>用量</th>
					<th>✔</th>
					<th>メモ（服薬時に記録）</th>
				</tr>
				<c:forEach var="med" items="${entry.value}">
					<tr>
						<td>${med.nickname}</td>
						<td>${med.formalName}</td>
						<td>${med.dosage}</td>
						<td><input type="checkbox" name="takenMed"
							value="${med.medicationId}"
							<c:if test="${checkedIds.contains(med.medicationId)}">checked disabled</c:if> />
						</td>
						<td><input type="text" name="memo_${med.medicationId}"
							<c:if test="${checkedIds.contains(med.medicationId)}">value="${med.memo}" disabled</c:if> />
						</td>
					</tr>

				</c:forEach>
			</table>
			<button type="submit">登録</button>
				<c:if test="${not empty message}">
		<p style="color: red;">${message}</p>
	</c:if>
			<br>
		</c:forEach>


	</form>
	<%@ include file="footer.jsp"%>
</body>
</html>