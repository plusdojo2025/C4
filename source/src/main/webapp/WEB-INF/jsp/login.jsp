<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン</title>
</head>

<body>
    <h2>ログイン</h2>
    <form action="OmoiyalinkLogin" method="post">
        <label for="id">ID：</label>
        <input type="text" id="id" name="id" required><br><br>

        <label for="name">名前：</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="birthday">誕生日：</label>
        <input type="date" id="birthday" name="birthday" required><br><br>

        <input type="submit" value="ログイン">

	</form>
</body>
</html>