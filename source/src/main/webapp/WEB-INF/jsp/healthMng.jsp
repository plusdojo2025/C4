<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>



<!-- 前の１０件、次の１０件機能 -->
<c:if test="${hasPrev}">
<a href="OmoiyalinkHealthMng?page=${page - 1}">前の10件</a>
</c:if>
<c:if test="${hasNext}">
  <a href="OmoiyalinkHealthMng?page=${page + 1}">次の10件</a>
</c:if>
