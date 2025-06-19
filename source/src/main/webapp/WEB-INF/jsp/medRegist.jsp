<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>薬の新規登録</title>
</head>
<body>
<header>
<!-- 共通ヘッダー -->
    <%-- <%@ include file="/WEB-INF/jsp/header.jsp" %> --%>
    <h1>薬の新規登録</h1>
</header>

<!-- メイン -->
<main>
    <form method="POST" action="${pageContext.request.contextPath}/OmoiyalinkMedRegist" autocomplete="off" id="regist_form">
        <label>
            薬の正式名称（必須項目）
            <input type="text" name="formalName"><br>
        </label>
        <label>
            薬の愛称
            <input type="text" name="nickName"><br>
        </label>
        <label>
            服薬時間(必須項目)
            <input type="text" name="intake_time"><br>
        </label>
        <label>
            用量
            <input type="text" name="dosage"><br>
        </label>
        <label>
            メモ
            <input type="text" name="memo"><br>
        </label>
        <button type="submit">登録する</button>
    </form>
    <p id="regist"></p>
</main>
    <!-- メインここまで -->

<footer>
<!-- 共通フッター -->
    <%-- <%@ include file="/WEB-INF/jsp/footer.jsp" %> --%>
</footer>

<!-- Javascriptの設定 -->
<script>
'use strict';
    document.getElementById('regist_form').onsubmit= function(){
    	const formalName = document.getElementById('regist_form').formalName.value;
    	const intake_time = document.getElementById('regist_form').intake_time.value;
        if (formalName ==='' || intake_time ===''){
            document.getElementById('regist').textContent ='薬の正式名称と服薬時間を入力してください';
            event.preventDefault();
        }
    }
</script>	

</body>
</html>