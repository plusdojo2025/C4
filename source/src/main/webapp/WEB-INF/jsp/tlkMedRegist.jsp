<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
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

th:nth-child(1), td:nth-child(1) { width: 25%; }  /* 愛称 */
th:nth-child(2), td:nth-child(2) { width: 35%; }  /* 正式名 */
th:nth-child(3), td:nth-child(3) { width: 10%; }  /* 用量 */
th:nth-child(4), td:nth-child(4) { width: 5%; }  /* チェック */
th:nth-child(5), td:nth-child(5) { width: 25%; }  /* メモ */


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

.submit-area   {
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

.nav-buttons {
    margin: 1rem 2rem;
	margin-top: 10px;
	text-align: right; /* 右寄せにしたい場合。中央ならcenter、左寄せならleft */
}

.nav-buttons a {
	text-decoration: none;
	margin-left: 8px;
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

.add  {
	margin: 2rem;
}

.date { 
	font-weight: bold; font-size: 1.2rem; 
}
.big-num { 
	font-size: 2rem; color: #2679d7;
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
	
	<!-- その日の日付表示 -->
		<strong class="date">
	  <span class="big-num"><%= y.format(today) %></span>年
	  <span class="big-num"><%= m.format(today) %></span>月
	  <span class="big-num"><%= d.format(today) %></span>日
	  (<%= e.format(today) %>)
		</strong>
		
		<!-- 薬情報から、設定した時間ごとに薬を表にまとめて表示 -->
		<c:forEach var="entry" items="${medsByTime}"  >
			<h3>${entry.key}の薬</h3>
			<table>
				<tr>
					<th>愛称</th>
					<th>正式名</th>
					<th>用量</th>
					<th>✔</th>
					<th>メモ（服薬時に記録）</th>
				</tr>
				<c:forEach var="med" items="${entry.value}" varStatus="status">
					<tr  class="selectable-row">
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
			
			<div class="submit-area">
			<button type="submit">登録</button>
			</div>
			
			<c:if test="${not empty message}">
				<p style="color: red;">${message}</p>
			</c:if>
			<br>
		</c:forEach>
	</form>
	
	 <!-- ▼ 追加登録フォーム -->
    <hr>
    <h3 class = "add" >追加登録</h3>
    <form method="post" action="OmoiyalinkTlkMedRegist">
        <input type="hidden" name="registerType" value="free">
        <table>
            <tr>
                <th>薬を選択</th>
                <th>日付</th>
                <th>時刻</th>
                <th>メモ</th>
            </tr>
            <tr>
                <td>
                    <select name="freeMedicationId" required>
                        <option value="">選択</option>
                        <c:forEach var="med" items="${allMeds}">
                            <option value="${med.medicationId}">${med.nickname}（${med.formalName}）</option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <input type="date" name="freeTakenDate"
                        value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                </td>
                <td>
                    <input type="time" name="freeTakenTime"
                        value="<%= new java.text.SimpleDateFormat("HH:mm").format(new java.util.Date()) %>" required>
                </td>
                <td>
                    <input type="text" name="freeMemo" style="width: 120px;">
                </td>
            </tr>
        </table> 
        
        <div class="submit-area">
        <button type="submit">追加登録</button>
        </div>
        
    </form>
	
	
	<%@ include file="footer.jsp"%>
	
	<script>
	document.addEventListener("DOMContentLoaded", function() {
	  document.querySelectorAll('tr.selectable-row').forEach(function(row) {
	    row.addEventListener('click', function(e) {
	      if (e.target.tagName === 'INPUT') return;
	      var checkbox = row.querySelector('input[type="checkbox"]');
	      if (checkbox && !checkbox.disabled) {
	        checkbox.checked = !checkbox.checked;
	      }
	    });
	  });
	});
	</script>
</body>
</html>
