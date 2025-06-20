<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>脳トレ履歴一覧</title>
<style>
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
	
	<!-- メニューに戻るボタン -->
	<a href="<%=request.getContextPath()%>/OmoiyalinkBrainTra"
		class="menu-btn">脳トレメニューに戻る</a>

	<form method="get" action="OmoiyalinkBrainTraMng"
		style="text-align: center; margin-bottom: 16px;">
		<input type="hidden" name="page" value="${page}" />
		<button class="sort-btn" type="submit" name="order" value="desc">勝利回数順↓</button>
		<button class="sort-btn" type="submit" name="order" value="asc">勝利回数順↑</button>
	</form>

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
	</table border="1">

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
