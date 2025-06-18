<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>おもいやリンク ログイン</title>
    <style>
        body { font-family: 'メイリオ', sans-serif; background: #f9fafb; }
        .login-container {
            width: 98%;
            max-width: 420px;
            margin: 44px auto;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 2px 20px #eef1f4;
            padding: 36px 18px 44px 18px;
        }
        h2 { margin: 10px 0 28px 0; font-size: 1.5em; color: #2666b5; }
        .error { color: #c00; margin-bottom: 1em; }
        label { display: block; margin: 1em 0 0.3em 0; }
        input[type="text"], input[type="number"] {
            width: 98%; padding: 0.5em; font-size: 1em; margin-bottom: 1em;
        }
        button, .register-btn {
            width: 100%; padding: 0.7em; font-size: 1em; border: none;
            border-radius: 10px; margin-top: 1em; cursor: pointer;
            display: block;
        }
        button {
            background: #2666b5; color: #fff;
        }
        button:hover { background: #3a66a7; }
        .register-btn {
            background: #fff; color: #2666b5; border: 2px solid #2666b5;
            margin-top: 0.5em;
        }
        .register-btn:hover {
            background: #eaf2ff; color: #204078;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>ログイン</h2>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="OmoiyalinkLogin" method="post">
            <label for="user_id">ID（半角数字）</label>
            <input type="text" id="user_id" name="user_id" maxlength="10" required />

            <label for="name">名前</label>
            <input type="text" id="name" name="name" maxlength="50" required />

            <label for="birth_date">生年月日（8桁：例 20000101）</label>
            <input type="text" id="birth_date" name="birth_date" maxlength="8" required />

            <button type="submit">ログイン</button>
        </form>
        <!-- 新規登録ボタン -->
        <a href="UserRegistServlet" class="register-btn">新規登録はこちら</a>
    </div>
</body>
</html>
