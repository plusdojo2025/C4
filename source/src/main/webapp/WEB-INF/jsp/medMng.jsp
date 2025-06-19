<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>薬の編集・削除</title>
</head>
<body>
<header>
    <!-- 共通ヘッダー -->

    <h1>薬の編集・削除</h1>
</header>
<main>
    <h2>登録されているお薬の一覧</h2>
    <c:forEach var="e" items="${cardList}" >
        <form method="POST" action="${pageContext.request.contextPath}/OmoiyalinkMedMng" id="regist_form">
            <label>
                薬の正式名称
                <input type="text" name="formalName" value="${e.formalName}"><br>
            </label>
            <label>
                薬の愛称
                <input type="text" name="nickName" value="${e.nickName}"><br>
            </label>
            <label>
                服薬時間
                <input type="time" name="intake_time" value="${e.intake_time}"><br>
            </label>
            <label>
                用量
                <input type="text" name="formalName" value="${e.nickName}"><br>
            </label>
            <label>
                メモ
                <input type="text" name="memo" value="${e.memo}"><br>
            </label>
            <label>
                <input type="submit" name="submit" value="更新">
                <input type="submit" name="delete" value="削除">
            </label>        
        </form>
        <p id="regist"></p>
    </c:forEach>
    <c:if test="${empty cardList}"></c:if>
	<p>指定された条件に一致するデータはありません。</p>
</main>

<!-- Javascriptの設定 -->
<script>
'use strict';
    document.getElementById('regist_form').onsubmit= function(){
    	const formalName = document.getElementById('regist_form').formalName.value;
    	const intake_time = document.getElementById('regist_form').intake_time.value;
        if (formalName ==='' || intake_time ===''){
            document.getElementById('regist').textContent ='体温と睡眠休養感を入力してください';
            event.preventDefault();
        }
    }
</script>
</body>
</html>