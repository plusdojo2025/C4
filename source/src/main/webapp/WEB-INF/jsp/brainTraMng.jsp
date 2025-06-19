<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>脳トレ履歴一覧</title>
<style>
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

	<!-- メニューに戻るボタン -->
	<a href="<%=request.getContextPath()%>/OmoiyalinkBrainTra"
		class="menu-btn">脳トレメニューに戻る</a>
</body>
</html>
