<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>体調記録一覧</title>
<style>
body {
	margin: 0;
	padding: 0;
	background: #FFFEEF;
	color: #22292F;
	font-family: 'メイリオ', 'Meiryo', sans-serif;
	font-size: 17px;
	min-height: 100vh;
}

.button-center {
	text-align: center;
	margin-top: 18px;
	margin-bottom: 5px;
}

.button-link {
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

.button-link:hover {
	background: #7ba9c9;
	color: #fff;
	text-decoration: none !important;
}

.table-scroll-x {
	width: 100%;
	overflow-x: auto;
}

table {
	width: 100%;
	min-width: 800px;
	border-collapse: collapse;
	margin: 24px 0;
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 2px 12px #eef1f4;
}

th, td {
	padding: 0.7em 1em;
	text-align: center;
	border-bottom: 1px solid #a3cde2;
	white-space: nowrap;
}

th {
	background: #eaf6fc;
	color: #2d7ea3;
}

.no-data {
	text-align: center;
	color: #aaa;
	font-style: italic;
}

.paging {
	text-align: center;
	margin: 18px 0 10px 0;
	font-size: 1em;
	user-select: none;
}

.paging a, .paging span {
	display: inline-block;
	margin: 0 6px;
	padding: 0.45em 1.2em;
	border-radius: 7px;
	text-decoration: none;
	font-weight: bold;
	transition: background 0.18s, color 0.18s, box-shadow 0.14s;
}

.paging a {
	background: #e0eef8;
	color: #2980b9;
	border: 1.3px solid #aed1eb;
	box-shadow: 0 1px 4px #e5edf1;
	cursor: pointer;
}

.paging a:hover {
	background: #46B1E1;
	color: #fff;
	border-color: #46B1E1;
}

.paging span {
	background: #46B1E1;
	color: #fff;
	border: 1.3px solid #46B1E1;
	box-shadow: 0 1px 6px #bee8ff;
	cursor: default;
}

@media ( max-width : 800px) {
	table {
		min-width: 600px;
		font-size: 0.98em;
	}
}

@media ( max-width : 480px) {
	.paging a, .paging span {
		padding: 0.45em 0.8em;
		font-size: 0.95em;
	}
}

.sub-header {
	background-color: #46B1E1; /* 青色 */
	color: #FFFEEF;
	padding: 15px 30px;
	margin-top: 0px !important;
}

.sub-header h2 {
	margin: 0;
	font-size: 2rem;
	text-align: center;
	color: #FFFEEF;
	background-color: #46B1E1;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/header.jsp"%>

	<main>
		<div class="sub-header">
			<h2>登録した体調の一覧</h2>
		</div>

		<div class="button-center">
			<a href="${pageContext.request.contextPath}/OmoiyalinkHealthRegist"
				class="button-link">体調登録に戻る</a>
		</div>

		<!-- ページング上部 -->
		<div class="paging">
			<c:if test="${hasPrev}">
				<a href="OmoiyalinkHealthMng?page=${page - 1}">&laquo; 前の10件</a>
			</c:if>
			<span>ページ：${page + 1}</span>
			<c:if test="${hasNext}">
				<a href="OmoiyalinkHealthMng?page=${page + 1}">次の10件 &raquo;</a>
			</c:if>
		</div>

		<div class="table-scroll-x">
			<table>
				<thead>
					<tr>
						<th>記録日</th>
						<th>体温（℃）</th>
						<th>最高血圧</th>
						<th>最低血圧</th>
						<th>脈拍(bpm)</th>
						<th>血中酸素濃度(%)</th>
						<th>睡眠休養感(不眠 1 2 3 4 5 快眠)</th>
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
		</div>

		<!-- ページング下部 -->
		<div class="paging">
			<c:if test="${hasPrev}">
				<a href="OmoiyalinkHealthMng?page=${page - 1}">&laquo; 前の10件</a>
			</c:if>
			<span>ページ：${page + 1}</span>
			<c:if test="${hasNext}">
				<a href="OmoiyalinkHealthMng?page=${page + 1}">次の10件 &raquo;</a>
			</c:if>
		</div>
	</main>

	<%@ include file="/WEB-INF/jsp/footer.jsp"%>
</body>
</html>
