<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>体調登録</title>
</head>
<body>
<header>
	<!-- ヘッダー-->
    <!-- 共通ヘッダー -->
    <%-- <%@ include file="/WEB-INF/jsp/header.jsp" %> --%>
    <h1>体調登録</h1>
    <!-- ヘッダーここまで -->
</header>    

    <main>
        <p>本日の体調を入力してください！</p>
        <form method="POST" action="${pageContext.request.contextPath}/OmoiyalinkHealthRegist" autocomplete="off" id="regist_form" >
            <label>
                体温（必須項目）
                <input type="text" name="temperature"><br>
            </label>
            <label>
                最大血圧
                <input type="text" name="highBp"><br>
            </label>
            <label>
                最小血圧
                <input type="text" name="lowBp"><br>
            </label>
            <label>
                脈拍
                <input type="text" name="pulseRate"><br>
            </label>
            <label>
                血中酸素濃度
                <input type="text" name="pulseOx"><br>
            </label>
            睡眠休養感(必須項目)
            <select name="sleep" required>
                <option value="">選択してください</option>
                <option value="よく眠れた">よく眠れた</option>
                <option value="まぁまぁ眠れた">まぁまぁ眠れた</option>
                <option value="普通">普通</option>
                <option value="あまり眠れなかった">あまり眠れなかった</option>
                <option value="全然眠れなかった">全然眠れなかった</option>
            </select><br>
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
    <!-- フッター -->
     <%-- <%@ include file="/WEB-INF/jsp/footer.jsp" %> --%>
    <!-- フッターここまで -->
</footer>

    <!-- Javascriptの設定 -->
    <script>
    'use strict';
    document.getElementById('regist_form').onsubmit= function(){
    	const temperature = document.getElementById('regist_form').temperature.value;
    	const sleep = document.getElementById('regist_form').sleep.value;
        if (temperature ==='' || sleep ===''){
            document.getElementById('regist').textContent ='体温と睡眠休養感を入力してください';
            event.preventDefault();
        }
    }
    </script>	
</body>
</html>