<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Poll Succerss Page</title>
</head>
<body>
<h1>Thank you for voting!</h1>
<p>Question: <strong>${selectedQuestion}</strong></p>
<p>You voted for: <strong>${selectedOption}</strong></p>
<a href="${pageContext.request.contextPath}/index">Back to Home</a>
</body>
</html>
