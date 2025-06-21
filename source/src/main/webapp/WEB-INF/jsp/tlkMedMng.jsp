<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>服薬登録一覧</title>
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
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="sub-header">
		<h2>服薬登録一覧</h2>
	</div>
	<!-- メッセージ表示 -->
	<c:if test="${not empty message}">
		<div style="color: red;">${message}</div>
	</c:if>

	<table class="table-meds">
		<thead>
			<tr>
				<th>薬の愛称</th>
				<th>薬の正式名称</th>
				<th>用量</th>
				<th>日付</th>
				<th>飲んだ時間</th>
				<th>メモ</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="log" items="${mlogList}">
				<tr>
					<form action="OmoiyalinkTlkMedMng" method="post">
						<td>${log.nickname}</td>
						<td>${log.formalName}</td>
						<td>${log.dosage}</td>
						<td><input type="date" name="takenTime"
							value="${log.takenTimeString}" required style="width: 110px;">
						</td>
						<td><input type="time" name="takenTimeHourMin"
							value="${log.takenTimeHourMin}" required style="width: 80px;">
						</td>
						<td><input type="text" name="memo" value="${log.memo}"
							style="width: 120px;"></td>
						<td>
							<!-- 必要なhidden値を全部送る --> <input type="hidden" name="logId"
							value="${log.logId}"> <input type="hidden"
							name="nickname" value="${log.nickname}"> <input
							type="hidden" name="formalName" value="${log.formalName}">
							<input type="hidden" name="dosage" value="${log.dosage}">
							<input type="hidden" name="medicationId"
							value="${log.medicationId}"> <input type="hidden"
							name="takenMed" value="${log.takenMed}"> <!-- 更新ボタンと削除ボタン -->
							<input type="submit" name="submit" value="編集" class="button">
							<input type="submit" name="submit" value="削除" class="button"
							onclick="return confirm('本当に削除しますか？');">
						</td>
					</form>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<br>
	<a href="OmoiyalinkHome"><button>トップに戻る</button></a>
	<a href="OmoiyalinkTlkMedRegist"><button>服薬記録を追加</button></a>
<%@ include file="footer.jsp"%>
</body>
</html>
