<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
int year = (Integer) request.getAttribute("year");
int month = (Integer) request.getAttribute("month");
%>
<%
// 年月パラメータを取得
int prevYear = year, prevMonth = month - 1;
int nextYear = year, nextMonth = month + 1;
if (prevMonth == 0) {
	prevYear--;
	prevMonth = 12;
}
if (nextMonth == 13) {
	nextYear++;
	nextMonth = 1;
}
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>服薬登録一覧</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<style>
.page {
	margin: 2rem;
}

th, td {
	border: 1px solid #aaa;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

input[type="date"], input[type="time"], input[type="text"] {
	font-size: 1.1rem;
	min-width: 90px;
	max-width: 170px;
	width: 100%;
	box-sizing: border-box;
	margin-bottom: 0;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	table-layout: fixed;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: center;
}

th:nth-child(1), td:nth-child(1) {
	width: 15%;
} /* 日付 */
th:nth-child(2), td:nth-child(2) {
	width: 10%;
} /* 飲んだ時間 */
th:nth-child(3), td:nth-child(3) {
	width: 15%;
} /* 愛称 */
th:nth-child(4), td:nth-child(4) {
	width: 20%;
} /* 正式名称*/
th:nth-child(5), td:nth-child(5) {
	width: 10%;
} /* 用量 */
th:nth-child(5), td:nth-child(5) {
	width: 20%;
} /* メモ */
th:nth-child(5), td:nth-child(5) {
	width: 10%;
} /*ボタン*/
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

/*画面遷移ボタン*/
.button-center {
	text-align: center;
	margin-top: 18px;
	margin-bottom: 5px;
}

.seni {
	display: inline-block;
	background: #A9C9E1;
	color: #22292F;
	text-decoration: none;
	border-radius: 9px;
	padding: 0.6em 1.7em;
	margin-bottom: 22px;
	margin-top: 8px;
	font-size: 1em;
	font-weight: bold;
	transition: background 0.2s;
	text-decoration: none !important;
}

.seni:hover {
	background: #7BA9C9;
	color: #fff;
	text-decoration: none !important;
}

/*更新、削除ボタン*/
.buttonE, .buttonD {
	font-size: 1rem;
	padding: 7px 20px;
	border-radius: 6px;
	margin: 0 5px 5px 0;
	border: none;
	cursor: pointer;
}

.buttonE {
	background: #82bdf7;
	color: white;
	font-weight: bold;
}

.buttonD {
	background: #ff9e86;
	color: white;
	font-weight: bold;
}

.edit-plain {
	width: 100%;
	font-size: 1.5rem;
	border: none;
	background: transparent;
	color: inherit;
	padding: 0 3px;
}

.edit-plain:focus {
	outline: 1.5px solid #74b6ea;
	background: #f3f8fd;
}

/* スクロール */
.table-scroll {
	overflow-x: auto;
	width: 100%;
	margin-bottom: 1em;
	display: flex;
	justify-content: center;
}

.table-scroll table {
	width: 80vw;
	min-width: 650px;
	max-width: 1600px;
	margin: 0 auto;
}

input[type="text"].memo-input {
	width: 95%;
	min-width: 50px;
	max-width: 700px;
	font-size: 1.13rem;
	padding: 10px 14px;
}

.table-scroll {
	overflow-x: auto;
	width: 100%;
	margin-bottom: 1em;
}

textarea.memo-input {
	width: 100%;
	min-width: 50px;
	max-width: 100%;
	font-size: 1.13rem;
	padding: 10px 14px;
	white-space: pre-wrap;
	word-break: break-all;
	resize: none; /* ← 追加！ユーザーによるリサイズ禁止 */
	box-sizing: border-box;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="sub-header">
		<h2>服薬登録一覧・編集</h2>
	</div>
	<div class="button-center">
		<a class="seni"
			href="${pageContext.request.contextPath}/OmoiyalinkMedMng">登録した薬</a>
		<a class="seni"
			href="${pageContext.request.contextPath}/OmoiyalinkTlkMedRegist">薬を飲む</a>
	</div>
	<div class="page">

		<div style="text-align: center; margin-bottom: 0.7rem;">
			<span style="font-size: 1.3rem; font-weight: bold;"> <%=year%>年<%=month%>月の服薬記録
			</span>
		</div>

		<!-- 2. 前月・翌月ボタン（表の下にも置いてOK） -->
		<div style="text-align: center; margin: 1.2rem 0 1rem 0;">
			<a href="OmoiyalinkTlkMedMng?year=<%=prevYear%>&month=<%=prevMonth%>">
				<button type="button">前月</button>
			</a> <a
				href="OmoiyalinkTlkMedMng?year=<%=nextYear%>&month=<%=nextMonth%>">
				<button type="button">翌月</button>
			</a>
		</div>
		<!-- 横スクロール可能なテーブル -->
		<div class="table-scroll">
			<table class="table-meds">
				<thead>
					<tr>
						<th>日付</th>
						<th>飲んだ時間</th>
						<th>薬の愛称</th>
						<th>薬の正式名称</th>
						<th>用量</th>
						<th>メモ</th>
						<th>変更</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="log" items="${mlogList}">
					<form action="OmoiyalinkTlkMedMng" method="post">
						<tr>
								<td><input type="date" name="takenTime"
									value="${log.takenTimeString}" required class="edit-plain"></td>
								<td><input type="time" name="takenTimeHourMin"
									value="${log.takenTimeHourMin}" required class="edit-plain"></td>
								<td><input type="text" name="nickname"
									value="${log.nickname}" class="edit-plain"></td>
								<td><input type="text" name="formalName"
									value="${log.formalName}" class="edit-plain"></td>
								<td><input type="text" name="dosage" value="${log.dosage}"
									class="edit-plain"></td>
								<td><textarea name="memo" class="edit-plain memo-input"
										rows="2"
										style="white-space: pre-wrap; word-break: break-all; resize: vertical;">${log.memo}</textarea>
								</td>
								<td>
									<!-- 必要なhidden値を全部送る --> 
									<input type="hidden" name="logId" value="${log.logId}"> 
									<input type="hidden" name="takenMed" value="${log.takenMed}"> 
									<input type="hidden" name="medicationId" value="${log.medicationId}">
									
									<!-- 更新ボタンと削除ボタン -->
									 <input type="submit" name="submit"  value="更新" class="buttonE"> 
									 <input type="submit" name="submit" value="削除" class="buttonD"  onclick="return confirm('本当に削除しますか？');">
								</td>
							</form>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- メッセージ表示 -->
		<c:if test="${not empty message}">
			<div style="color: red;">${message}</div>
		</c:if>

	</div>

	<%@ include file="footer.jsp"%>
</body>

</html>
