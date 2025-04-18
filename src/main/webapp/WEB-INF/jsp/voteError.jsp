<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Poll Error Page</title>
</head>
<body>
<h1>Error Occurred</h1>
<p>${error}</p>
<a href="${pageContext.request.contextPath}/polling">Return to Polls</a>
</body>
</html>
