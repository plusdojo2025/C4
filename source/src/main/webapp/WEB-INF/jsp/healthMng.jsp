<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>体調記録一覧</title>
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
				<th>体温</th>
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
						<td colspan="8">体調記録がありません。</td>
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
