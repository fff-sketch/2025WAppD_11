<%--
  Created by IntelliJ IDEA.
  User: on99
  Date: 9/4/2025
  Time: 1:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Poll Succerss Page</title>
</head>
<body>
<h1>Thank you for voting!</h1>
<p>Question: ${selectedQuestion}</p>
<p>You voted for: <strong>${selectedOption}</strong></p>
<a href="${pageContext.request.contextPath}/index">Back to Home</a>
</body>
</html>
