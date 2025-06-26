<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date"%>
<%
Date today = new Date();
SimpleDateFormat y = new SimpleDateFormat("yyyy");
SimpleDateFormat m = new SimpleDateFormat("M");
SimpleDateFormat d = new SimpleDateFormat("d");
java.text.SimpleDateFormat e = new java.text.SimpleDateFormat("E");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>服薬登録</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<style>
form {
	margin: 2rem
}

th {
	background-color: #f2f2f2;
}

input[type="text"] {
	width: 95%;
}

input {
	margin-bottom: 0;
}

th, td {
	border: 1px solid #ccc;
	padding: 10px 14px;
	text-align: center;
	font-size: 1.13rem;
}

th:nth-child(1), td:nth-child(1) {
	width: 25%;
} /* 愛称 */
th:nth-child(2), td:nth-child(2) {
	width: 35%;
} /* 正式名 */
th:nth-child(3), td:nth-child(3) {
	width: 10%;
} /* 用量 */
th:nth-child(4), td:nth-child(4) {
	width: 5%;
} /* チェック */
th:nth-child(5), td:nth-child(5) {
	width: 25%;
} /* メモ */
h2 {
	margin-top: 120px;
	font-size: 1.8rem;
}

h3 {
	margin-top: 20px;
	font-size: 1.4rem;
	color: #007BFF;
	margin: 1rem 0
}

.submit-area {
	text-align: right;
	margin-top: 10px;
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

.button-nav a:hover {
	background: #2d7ea3;
}
/*画面遷移ボタンのスタイル*/
.nav-buttons button {
	cursor: pointer;
}

.date-row {
	margin: 0 0 20px 0;
	display: flex;
	align-items: center;
}

.date-row label {
	margin-right: 8px;
	font-weight: bold;
}

.add {
	margin: 2rem;
}

.date {
	font-weight: bold;
	font-size: 1.2rem;
}

.big-num {
	font-size: 2rem;
	color: #2679d7;
}

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

.submit-area {
	text-align: center;
	margin-top: 10px;
}

@media (max-width: 700px) {
  .table-scroll table {
    min-width: 400px;
    font-size: 0.95rem;
  }
  th, td {
    padding: 8px 4px;
  }
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="sub-header">
		<h2>服薬登録</h2>
	</div>
	<div class="button-center">
    <a class="seni" href="${pageContext.request.contextPath}/OmoiyalinkMedMng" class="btn-nav">登録した薬</a>
    <a class="seni" href="${pageContext.request.contextPath}/OmoiyalinkTlkMedMng" class="btn-nav">飲んだ薬</a>
</div>

	<c:if test="${not empty message}">
		<p style="color: red;">${message}</p>
	</c:if>

	<form method="post" action="OmoiyalinkTlkMedRegist">
		<strong class="date"> <span class="big-num"><%=y.format(today)%></span>年
			<span class="big-num"><%=m.format(today)%></span>月 <span
			class="big-num"><%=d.format(today)%></span>日 (<%=e.format(today)%>)
		</strong>
		
		<c:forEach var="entry" items="${medsByTime}">
		<h3 class="table-time-title">${entry.key}の薬</h3>
		<div class="table-scroll">
			
				<table>
					<tr>
						<th>愛称</th>
						<th>正式名</th>
						<th>用量</th>
						<th>✔</th>
						<th>メモ（服薬時に記録）</th>
					</tr>
					<c:forEach var="med" items="${entry.value}" varStatus="status">
						<tr class="selectable-row">
							<td>${med.nickname}</td>
							<td>${med.formalName}</td>
							<td>${med.dosage}</td>
							<td>
						    <c:choose>
						      <c:when test="${registeredMap[med.medicationId]}">
						        <input type="checkbox" disabled checked>
						        <span style="color:gray;"></span>
						      </c:when>
						      <c:otherwise>
						        <input type="checkbox" name="takenMed" value="${med.medicationId}">
						      </c:otherwise>
						    </c:choose>
						  </td>
						  <td>
						    <input type="text" name="memo_${med.medicationId}" <c:if test="${registeredMap[med.medicationId]}">disabled</c:if>>
						  </td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="submit-area">
				<button type="submit">登録</button>
			</div>
			<br>
		</c:forEach>
	</form>

	<hr>
	<h3 class="add">追加登録</h3>
	<form method="post" action="OmoiyalinkTlkMedRegist">
		<input type="hidden" name="registerType" value="free">
		<div class="table-scroll">
			<table>
				<tr>
					<th>薬を選択</th>
					<th>日付</th>
					<th>時刻</th>
					<th>メモ</th>
				</tr>
				<tr>
					<td><select name="freeMedicationId" required>
							<option value="">飲んだ薬を選択してください</option>
							<c:forEach var="med" items="${allMeds}">
								<option value="${med.medicationId}">${med.nickname}（${med.formalName}）</option>
							</c:forEach>
					</select></td>
					<td><input type="date" name="freeTakenDate"
						value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>"
						required></td>
					<td><input type="time" name="freeTakenTime"
						value="<%=new java.text.SimpleDateFormat("HH:mm").format(new java.util.Date())%>"
						required></td>
					<td><input type="text" name="freeMemo" style="width: 120px;">
					</td>
				</tr>
			</table>
		</div>
		<div class="submit-area">
			<button type="submit">追加登録</button>
		</div>
	</form>

	<%@ include file="footer.jsp"%>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			document.querySelectorAll('tr.selectable-row').forEach(
					function(row) {
						row.addEventListener('click', function(e) {
							if (e.target.tagName === 'INPUT')
								return;
							var checkbox = row
									.querySelector('input[type="checkbox"]');
							if (checkbox && !checkbox.disabled) {
								checkbox.checked = !checkbox.checked;
							}
						});
					});
			// ▼登録時アラート
			if (location.search.indexOf("registered=1") >= 0) {
				alert("登録しました！");
			}
		});
	</script>
</body>
</html>
