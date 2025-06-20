<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>服薬登録</title>
    <link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
    <style>
       table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #aaa; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        input[type="text"] { width: 95%; }

        
    table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
}

th, td {
  border: 1px solid #ccc;
  padding: 8px;
  text-align: center;
}

h2 {
  margin-top: 120px;
  font-size: 1.8rem;
}

h3 {
  margin-top: 20px;
  font-size: 1.4rem;
  color: #007BFF;
}
</style>
</head>
<body>

<h2>服薬登録</h2>

<c:if test="${not empty message}">
    <p style="color:red;">${message}</p>
</c:if>

<form method="post" action="OmoiyalinkTlkMedRegist">

    <c:forEach var="entry" items="${medsByTime}">
        <h3>${entry.key} の薬</h3>
        <table>
            <tr>
                <th>✔</th>
                <th>愛称</th>
                <th>正式名</th>
                <th>用量</th>
                <th>メモ（服薬時に記録）</th>
            </tr>
            <c:forEach var="med" items="${entry.value}">
                <tr>
                    <td>
                        <input type="checkbox" name="takenMed" value="${med.medicationId}"
                            <c:if test="${checkedIds.contains(med.medicationId)}">checked disabled</c:if> />
                    </td>
                    <td>${med.nickname}</td>
                    <td>${med.formalName}</td>
                    <td>${med.dosage}</td>
                    <td>
                        <input type="text" name="memo_${med.medicationId}"
                            <c:if test="${checkedIds.contains(med.medicationId)}">value="${med.memo}" disabled</c:if> />
                    </td>
                </tr>
            </c:forEach>
        </table>
        <br>
    </c:forEach>

    <button type="submit">登録</button>
</form>

</body>
</html>