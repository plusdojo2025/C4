<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>脳トレ履歴一覧</title>
<style>
body {
	font-family: 'メイリオ', sans-serif;
	background: #f9fafb;
}

h2 {
	margin: 10px 0 28px 0;
	font-size: 1.5em;
	color: #377;
}

.paging {
	margin: 16px 0 22px 0;
	text-align: center;
}

.paging a, .paging span {
	display: inline-block;
	margin: 0 9px;
	padding: 7px 22px;
	text-decoration: none;
	border-radius: 6px;
	color: #155;
	background: #eef;
	border: 1.5px solid #bbd;
	font-size: 1em;
}

.paging a:hover {
	background: #b9d6ff;
	color: #19405d;
}

table {
	border-collapse: collapse;
	width: 94%;
	margin: 0 auto;
	background: #fff;
	box-shadow: 0 0 8px #bbb4;
}

th, td {
	border: 1.5px solid #bbb;
	padding: 10px 7px;
	text-align: center;
	font-size: 1.05em;
}

th {
	background: #e0f6ff;
	font-weight: bold;
}

tr:nth-child(even) td {
	background: #f9fdff;
}

tr:hover td {
	background: #f5f1f8;
}

.no-data {
	color: #888;
	font-size: 1.1em;
	padding: 28px 0;
	text-align: center;
}

.sort-btn {
	background: none;
	border: none;
	color: #237;
	font-size: 1em;
	cursor: pointer;
}

.sort-btn:hover {
	text-decoration: underline;
	color: #2a6;
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
	<form method="get" action="OmoiyalinkBrainTraMng"
		style="text-align: center; margin-bottom: 16px;">
		<input type="hidden" name="page" value="${page}" />
		<button class="sort-btn" type="submit" name="order" value="desc">勝利回数順↓</button>
		<button class="sort-btn" type="submit" name="order" value="asc">勝利回数順↑</button>
	</form>
	<table>
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
</body>
</html>
