<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
<h2>Register</h2>
<c:url var="registerUrl" value="/register"/>
<form:form action="${registerUrl}" method="post" modelAttribute="user">
    <label>Username: <form:input path="username"/></label><br/>
    <label>Password: <form:password path="password"/></label><br/>
    <label>Full Name: <form:input path="fullName"/></label><br/>
    <label>Email Address: <form:input path="email"/></label><br/>
    <label>Phone Number: <form:input path="phone"/></label><br/>
    <input type="submit" value="Register"/>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>
</body>
</html>
