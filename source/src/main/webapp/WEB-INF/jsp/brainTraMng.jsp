<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>脳トレ履歴一覧</title>
<style>
/*画面遷移ボタン*/
.buttons {
	display: flex;
	justify-content: center;
	gap: 30px;
	margin-top: 30px;
	margin-bottom: 10px;
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
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    background: #FFFEEF;  /* 背景色指定 */
    color: #22292F;       /* 薄めの黒（ややグレー系：#22292F） */
    font-family: 'メイリオ', 'Meiryo', 'sans-serif';
    font-size: 17px;
    line-height: 1.8;
    background-image: url('<%=request.getContextPath()%>/img/R.jpg');
    background-position: center;
}

h2 {
    color: #fff;
    margin-top: 1em;
    margin-bottom: .7em;
    font-weight: bold;
    text-align: center;
    background:#46B1E1;
    margin-top: 0;
}

button, .btn {
    background: #46B1E1;
    color: #fff;
    border: none;
    border-radius: 9px;
    padding: 0.65em 1.6em;
    margin: 6px 0;
    cursor: pointer;
    font-size: 1em;
    font-family: inherit;
    transition: background 0.22s;
}
table {
	margin-left: auto;
	margin-right:auto;
	 border-collapse: separate;
	 border-spacing: 1px;
	 background: #eaf6fe;
	 width:90%;
}

table th {
	color:#fff;
	background: #46B1E1;
}

table td {
  text-align: center;
}

.paging a {
	color: #fff;
	text-decoration: none;
	font-weight: bold;
}

.paging a:hover {
	color: #F9BEB1;
	text-decoration: underline;
}

span {
	color:#fff;
}
</style>
</head>
<body>
	<h2>脳トレ履歴一覧</h2>
	<div class="paging">
		<c:if test="${hasPrev}">
			<a href="OmoiyalinkBrainTraMng?page=${page - 1}&order=${order}">&laquo;
				前の10件</a>
		</c:if>
		<span>ページ：${page + 1}</span>
		<c:if test="${hasNext}">
			<a href="OmoiyalinkBrainTraMng?page=${page + 1}&order=${order}">次の10件
				&raquo;</a>
		</c:if>
	</div>
	
<div class="buttons">
	<!-- 脳トレメニューに戻る -->
	<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTra" method="get">
		<button type="submit" class="seni">脳トレメニューに戻る</button>
	</form>

	<!-- 勝利回数順ソートボタン -->
	<form method="get" action="OmoiyalinkBrainTraMng">
		<input type="hidden" name="page" value="${page}" />
		<c:choose>
			<c:when test="${order == 'asc'}">
				<button class="seni" type="submit" name="order" value="desc">勝利回数順↓</button>
			</c:when>
			<c:otherwise>
				<button class="seni" type="submit" name="order" value="asc">勝利回数順↑</button>
			</c:otherwise>
		</c:choose>
	</form>
</div>

	<table border="1">
		<thead>
			<tr>
				<th>実施日</th>
				<th>勝利回数</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty records}">
					<c:forEach var="rec" items="${records}">
						<tr>
							<td><c:out value="${rec.played_at}" /></td>
							<td><c:out value="${rec.score}" /></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td class="no-data" colspan="2">脳トレ履歴がありません。</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<!--  <div class="paging">
		<c:if test="${hasPrev}">
			<a href="OmoiyalinkBrainTraMng?page=${page - 1}&order=${order}">&laquo;
				前の10件</a>
		</c:if>-->
		<!--  <span>ページ：${page + 1}</span>
		<c:if test="${hasNext}">
			<a href="OmoiyalinkBrainTraMng?page=${page + 1}&order=${order}">次の10件
				&raquo;</a>
		</c:if>
	</div>-->
	
</body>
</html>
