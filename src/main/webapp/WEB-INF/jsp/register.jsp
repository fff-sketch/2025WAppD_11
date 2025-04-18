<%--
  Created by IntelliJ IDEA.
  User: on99
  Date: 8/4/2025
  Time: 23:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
<h1>Register</h1>
<c:url var="registerUrl" value="/register"/>
<form:form action="${registerUrl}" method="post" modelAttribute="user">
    <label>Username: <form:input path="username"/></label><br/>
    <label>Password: <form:password path="password"/></label><br/>
    <label>Full Name: <form:input path="fullName"/></label><br/>
    <label>Email Address: <form:input path="email"/></label><br/>
    <label>Phone Number: <form:input path="phone"/></label><br/>
    <input type="submit" value="Register"/>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form><br/>
<a href="/pj/index">Back to Home</a>
</body>
</html>
