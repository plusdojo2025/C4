<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>体調記録一覧</title>
<style>
body {
	font-family: 'Segoe UI', 'メイリオ', 'Arial', sans-serif;
	margin: 32px;
}

h2 {
	margin-bottom: 18px;
}

table {
	border-collapse: collapse;
	width: 98%;
	background: #fff;
	margin-top: 18px;
	margin-bottom: 28px;
	box-shadow: 0 0 8px #bbb4;
}

th, td {
	border: 1.5px solid #bbb;
	padding: 10px 7px;
	text-align: center;
	font-size: 1.05em;
}

th {
	background: #e3ecf9;
	font-weight: bold;
	font-size: 1.12em;
}

tr:nth-child(even) td {
	background: #f8fbff;
}

tr:hover td {
	background: #f5f1f8;
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
	color: #1a2138;
	background: #e3ecf9;
	border: 1.5px solid #bbb;
	font-size: 1em;
}

.paging a:hover {
	background: #a9d3ff;
	color: #19405d;
}

.no-data {
	color: #888;
	font-size: 1.1em;
	padding: 28px 0;
	text-align: center;
}
</style>
</head>
<body>
	<h2>体調記録一覧</h2>

	<div class="paging">
		<c:if test="${hasPrev}">
			<a href="OmoiyalinkHealthMng?page=${page - 1}">&laquo; 前の10件</a>
		</c:if>
		<span>ページ：${page + 1}</span>
		<c:if test="${hasNext}">
			<a href="OmoiyalinkHealthMng?page=${page + 1}">次の10件 &raquo;</a>
		</c:if>
	</div>

	<table>
		<thead>
			<tr>
				<th>記録日</th>
				<th>体温（℃）</th>
				<th>最高血圧</th>
				<th>最低血圧</th>
				<th>脈拍</th>
				<th>血中酸素</th>
				<th>睡眠休養感</th>
				<th>メモ</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty records}">
					<c:forEach var="rec" items="${records}">
						<tr>
							<td><c:out value="${rec.date}" /></td>
							<td><c:out value="${rec.temperature}" /></td>
							<td><c:choose>
									<c:when test="${rec.highBp != null}">
										<c:out value="${rec.highBp}" />
									</c:when>
									<c:otherwise>―</c:otherwise>
								</c:choose></td>
							<td><c:choose>
									<c:when test="${rec.lowBp != null}">
										<c:out value="${rec.lowBp}" />
									</c:when>
									<c:otherwise>―</c:otherwise>
								</c:choose></td>
							<td><c:choose>
									<c:when test="${rec.pulseRate != null}">
										<c:out value="${rec.pulseRate}" />
									</c:when>
									<c:otherwise>―</c:otherwise>
								</c:choose></td>
							<td><c:choose>
									<c:when test="${rec.pulseOx != null}">
										<c:out value="${rec.pulseOx}" />
									</c:when>
									<c:otherwise>―</c:otherwise>
								</c:choose></td>
							<td><c:out value="${rec.sleep}" /></td>
							<td><c:out value="${rec.memo}" /></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td class="no-data" colspan="8">体調記録がありません。</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<div class="paging">
		<c:if test="${hasPrev}">
			<a href="OmoiyalinkHealthMng?page=${page - 1}">&laquo; 前の10件</a>
		</c:if>
		<span>ページ：${page + 1}</span>
		<c:if test="${hasNext}">
			<a href="OmoiyalinkHealthMng?page=${page + 1}">次の10件 &raquo;</a>
		</c:if>
	</div>
</body>
</html>
