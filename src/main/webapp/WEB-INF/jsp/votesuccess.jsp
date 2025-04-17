<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

<body>
<h1>Thank you for voting!</h1>
<p>You voted for: <strong>${selectedOption}</strong></p>
<p>Question: ${question}</p>

<a href="${pageContext.request.contextPath}/mc">Return to polls</a>
</body>
</html>
