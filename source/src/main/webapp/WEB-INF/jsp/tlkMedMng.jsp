<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>服薬記録一覧</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
</head>
<body>
	<header class="site-header">おもいやリンク 服薬記録一覧</header>
	<div class="container">
		<h2>服薬記録一覧</h2>
		<a
			href="${pageContext.request.contextPath}/OmoiyalinkMedRegistServlet"
			class="btn">新規記録登録</a>
		<table>
			<thead>
				<tr>
					<th>記録ID</th>
					<th>服薬時間</th>
					<th>薬の愛称</th>
					<th>正式名称</th>
					<th>用量</th>
					<th>服薬名</th>
					<th>メモ</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty medLogs}">
						<c:forEach var="log" items="${medLogs}">
							<tr>
								<td>${log.logId}</td>
								<td><fmt:formatDate value="${log.takenTime}"
										pattern="yyyy/MM/dd HH:mm" /></td>
								<td>${log.nickname}</td>
								<td>${log.formalName}</td>
								<td>${log.dosage}</td>
								<td>${log.takenMed}</td>
								<td>${log.memo}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="7" class="no-data">記録がありません。</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	<footer class="site-footer">© 2025 おもいやリンク</footer>
</body>
</html>
